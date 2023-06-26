/* -----------------------------------------------------------
 * :: :  C  O  S  M  O  :                                   ::
 * -----------------------------------------------------------
 * @wabistudios :: cosmos :: realms
 *
 * CREDITS.
 *
 * T.Furby              @furby-tm       <devs@wabi.foundation>
 *
 *         Copyright (C) 2023 Wabi Animation Studios, Ltd. Co.
 *                                        All Rights Reserved.
 * -----------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * ----------------------------------------------------------- */

import SwiftUI

// Usage 1: ExternalLink with title
//    ExternalLink("Title", destination: URL(string: "https://apple.com")!)
//
// Usage 2: ExternalLink with title and subtitle but no icon
//    ExternalLink(destination: URL(string: "https://apple.com")!) {
//        Text("Title")
//        Text("Subtitle")
//    } icon: {
//        Image(systemName: "star")
//    }
//
// Usage 3: ExternalLink with title, subtitle and icon
//    ExternalLink(destination: URL(string: "https://apple.com")!) {
//        Text("Title")
//        Text("Subtitle")
//    } icon: {
//        Image(systemName: "star")
//    }

struct ExternalLink<Content: View, Icon: View>: View
{
  let title: String?
  let subtitle: String?
  let destination: URL
  let icon: (() -> Icon)?
  let content: () -> Content

  init(
    _ title: String,
    destination: URL,
    subtitle: String? = nil,
    icon: (() -> Icon)? = nil
  ) where Content == EmptyView, Icon == EmptyView
  {
    self.title = title
    self.subtitle = subtitle
    self.destination = destination
    self.icon = icon
    content = { EmptyView() }
  }

  init(
    destination: URL,
    @ViewBuilder content: @escaping () -> Content,
    title: String? = nil,
    subtitle: String? = nil,
    @ViewBuilder icon: @escaping () -> Icon = { EmptyView() }
  )
  {
    self.title = title
    self.subtitle = subtitle
    self.destination = destination
    self.icon = icon
    self.content = content
  }

  var body: some View
  {
    Button(action: { NSWorkspace.shared.open(destination) }, label: {
      HStack(spacing: 8)
      {
        icon?()
        VStack(alignment: .leading, spacing: 2)
        {
          if let title
          {
            Text(title)
          }
          if let subtitle
          {
            Text(subtitle)
              .font(.caption)
              .foregroundColor(Color(.secondaryLabelColor))
          }
          content()
        }
        Spacer()
        Image(systemName: "arrow.up.right")
          .font(.system(size: 12, weight: .semibold))
          .foregroundColor(Color(.tertiaryLabelColor))
      }
    })
    .buttonStyle(ExternalLinkButtonStyle())
  }
}

struct ExternalLinkButtonStyle: ButtonStyle
{
  func makeBody(configuration: Configuration) -> some View
  {
    configuration.label
      .padding(10)
      .background(configuration.isPressed ? Color(.separatorColor) : Color(.clear))
      .contentShape(Rectangle())
      .padding(-10)
  }
}
