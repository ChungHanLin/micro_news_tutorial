//
//  MicroNewsWidget.swift
//  MicroNewsWidget
//
//  Created by 林重翰 on 2023/10/13.
//

import WidgetKit
import SwiftUI


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> NewsArticleEntry {
        NewsArticleEntry(date: Date(), showPlaceholder: true, stories: Array(
            arrayLiteral: NewsArticle(title: "這是新聞標題在 widget 顯示範例", source: "新聞來源", cover: "")
        ))
    }

    func getSnapshot(in context: Context, completion: @escaping (NewsArticleEntry) -> ()) {
        let entry: NewsArticleEntry
        if context.isPreview{
            entry = placeholder(in: context)
        } else {
            let userDefaults = UserDefaults(suiteName: "group.microNewsTutorial")
            let stories = userDefaults?.array(forKey: "posts")
            // convert any type to NewsArticle
            let newsArticles = stories?.map { story -> NewsArticle in
                let story = story as! [String: String]
                return NewsArticle(title: story["title"]!, source: story["source"]!, cover: story["cover"]!)
            }
            entry = NewsArticleEntry(date: Date(), showPlaceholder: false, stories: newsArticles!)
        }
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
              completion(timeline)
        }
    }
}

struct NewsArticle {
    let title: String
    let source: String
    let cover: String
}

struct NewsArticleEntry: TimelineEntry {
    let date: Date
    let showPlaceholder: Bool
    let stories: [NewsArticle]
}

struct MicroNewsWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            MicroNewsSmallWidget(entry: entry)
        case .systemMedium:
            MicroNewsMediumWidget(entry: entry)
        case .systemLarge:
            MicroNewsLargeWidget(entry: entry)
        default:
            Text("Unsupported widget family")
        }
    }
}

struct MicroNewsSmallWidget: View {
    var entry: Provider.Entry

    var body: some View {
        if (entry.showPlaceholder) {
            VStack(alignment: .leading) {
                Text("焦點新聞").font(.system(size: 14)).foregroundColor(.pink)
                Spacer()
                Text(entry.stories[0].source).font(.system(size: 14)).foregroundStyle(.gray)
                Text(entry.stories[0].title).font(.system(size: 16))
            }.redacted(reason: .placeholder)
        } else {
            VStack(alignment: .leading) {
                Text("焦點新聞").font(.system(size: 14)).foregroundColor(.pink)
                Spacer()
                Text(entry.stories[0].source).font(.system(size: 14)).foregroundStyle(.gray)
                Text(entry.stories[0].title).font(.system(size: 16))
            }
        }
    }
}

struct MicroNewsListItem : View {
    var story: NewsArticle?
    var body: some View {
        if (story != nil) {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: story!.cover)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 48, height: 48)
                            .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(story!.title).font(.system(size: 16))
                    Text(story!.source).font(.system(size: 14)).foregroundStyle(.gray)
                }
            }
        } else {
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.3)).frame(width: 48, height: 48)
                ViewThatFits {
                    VStack(alignment: .leading) {
                        Text("這是新聞標題在 widget 顯示範例").font(.system(size: 16))
                        Text("新聞來源").font(.system(size: 14)).foregroundStyle(.gray)
                    }
                }
            }.redacted(reason: .placeholder)
        }
    }
}

struct MicroNewsMediumWidget : View {
    var entry: Provider.Entry

    var body: some View {
        if (entry.showPlaceholder) {
            VStack(alignment: .leading) {
                Text("焦點新聞").font(.system(size: 14)).foregroundColor(.pink)
                Spacer()
                MicroNewsListItem(story: nil)
                MicroNewsListItem(story: nil)
            }.redacted(reason: .placeholder)
        } else {
            VStack(alignment: .leading) {
                Text("焦點新聞").font(.system(size: 14)).foregroundColor(.pink)
                Spacer()
                MicroNewsListItem(story: entry.stories[0])
                MicroNewsListItem(story: entry.stories[1])
            }
        }
    }
}

struct MicroNewsLargeWidget : View {
    var entry: Provider.Entry

    var body: some View {
        if (entry.showPlaceholder) {
            VStack(alignment: .leading, spacing: 8) {
                Text("焦點新聞").font(.system(size: 14)).foregroundColor(.pink)
                MicroNewsListItem(story: nil)
                MicroNewsListItem(story: nil)
                MicroNewsListItem(story: nil)
                MicroNewsListItem(story: nil)
                Spacer()
                Text("查看更多新聞").font(.system(size:14)).foregroundColor(.gray)
            }.redacted(reason: .placeholder)
        } else {
            VStack(alignment: .leading, spacing: 8) {
                Text("焦點新聞").font(.system(size: 14)).foregroundColor(.pink)
                MicroNewsListItem(story: entry.stories[0])
                MicroNewsListItem(story: entry.stories[1])
                MicroNewsListItem(story: entry.stories[2])
                MicroNewsListItem(story: entry.stories[3])
                Spacer()
                Text("查看更多新聞").font(.system(size:14)).foregroundColor(.gray)
            }
        }
    }
}

struct MicroNewsWidget: Widget {
    let kind: String = "MicroNewsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MicroNewsWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MicroNewsWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    MicroNewsWidget()
} timeline: {
    NewsArticleEntry(date: Date(), showPlaceholder: true, stories: Array(
        arrayLiteral: NewsArticle(title: "這是新聞標題在 widget 顯示範例", source: "新聞來源", cover: "")
    ))
}
