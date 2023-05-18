/* -----------------------------------------------------------
 * :: :  C  O  S  M  O  :                                ::
 * -----------------------------------------------------------
 * @wabistudios :: cosmo :: composer
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

struct SourceControlGitView: View
{
  @AppSettings(\.sourceControl.git) var git

  @State
  var ignoredFileSelection: IgnoredFiles.ID?

  var body: some View
  {
    SettingsForm
    {
      Section
      {
        gitAuthorName
        gitEmail
      }
      Section
      {
        preferToRebaseWhenPulling
        showMergeCommitsInPerFileLog
      }
    }
  }
}

private extension SourceControlGitView
{
  private var gitAuthorName: some View
  {
    TextField("Author Name", text: $git.authorName)
  }

  private var gitEmail: some View
  {
    TextField("Author Email", text: $git.authorEmail)
  }

  private var preferToRebaseWhenPulling: some View
  {
    Toggle(
      "Prefer to rebase when pulling",
      isOn: $git.preferRebaseWhenPulling
    )
  }

  private var showMergeCommitsInPerFileLog: some View
  {
    Toggle(
      "Show merge commits in per-file log",
      isOn: $git.showMergeCommitsPerFileLog
    )
  }

  private var bottomToolbar: some View
  {
    HStack(spacing: 12)
    {
      Button {} label: {
        Image(systemName: "plus")
          .foregroundColor(Color.secondary)
      }
      .buttonStyle(.plain)
      Button {} label: {
        Image(systemName: "minus")
      }
      .disabled(true)
      .buttonStyle(.plain)
      Spacer()
    }
  }
}
