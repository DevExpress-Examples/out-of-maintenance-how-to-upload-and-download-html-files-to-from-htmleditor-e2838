Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web

Namespace Models
	Public Class EditHtmlText
		Private privateHtmlText As String
		Public Property HtmlText() As String
			Get
				Return privateHtmlText
			End Get
			Set(ByVal value As String)
				privateHtmlText = value
			End Set
		End Property
		Private privateFileName As String
		Public Property FileName() As String
			Get
				Return privateFileName
			End Get
			Set(ByVal value As String)
				privateFileName = value
			End Set
		End Property
	End Class
End Namespace