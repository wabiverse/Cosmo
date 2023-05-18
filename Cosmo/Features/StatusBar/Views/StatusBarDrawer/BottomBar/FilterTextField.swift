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

struct FilterTextField: View
{
  let title: String

  @Binding
  var text: String

  @FocusState
  private var isFocused: Bool

  var body: some View
  {
    HStack(spacing: 5)
    {
      Image(systemName: "line.3.horizontal.decrease.circle")
        .foregroundColor(Color(nsColor: .labelColor))
        .font(.system(size: 13, weight: .regular))
        .padding(.leading, -1)
        .padding(.trailing, -2)
      textField
      if !text.isEmpty { clearButton }
    }
    .padding(.horizontal, 5)
    .frame(height: 22)
    .background(Color(nsColor: isFocused ? .textBackgroundColor : .quaternaryLabelColor))
    .cornerRadius(7)
    .overlay(
      RoundedRectangle(cornerRadius: 7)
        .stroke(isFocused ? .secondary : .tertiary, lineWidth: 0.75).cornerRadius(7)
    )
  }

  private var textField: some View
  {
    TextField(title, text: $text)
      .font(.system(size: 11, weight: .regular))
      .disableAutocorrection(true)
      .textFieldStyle(PlainTextFieldStyle())
      .focused($isFocused)
  }

  private var clearButton: some View
  {
    Button
    {
      text = ""
    } label: {
      Image(systemName: "xmark.circle.fill")
    }
    .foregroundColor(.secondary)
    .buttonStyle(PlainButtonStyle())
  }
}
