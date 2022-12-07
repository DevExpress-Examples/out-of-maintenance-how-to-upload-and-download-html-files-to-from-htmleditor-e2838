Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.Mvc
Imports Models
Imports DevExpress.Web.Mvc
Imports DevExpress.Web

Namespace Controllers
	<HandleError> _
	Public Class HomeController
		Inherits Controller
		Public Function Index() As ActionResult

			ViewData("Html") = String.Empty
			Return View(New EditHtmlText())
		End Function

		<ValidateInput(False)> _
		Public Function FeaturesPartial() As ActionResult
			Return PartialView("HtmlEditor")
		End Function

		 <HttpPost> _
		 Public Function DownloadFile() As FileContentResult
			Dim html As String = HtmlEditorExtension.GetHtml("htmlEdit")

			Dim result As New FileContentResult(System.Text.Encoding.UTF8.GetBytes(html), "text/html")
			result.FileDownloadName = "myFile.html"
			Return result
		 End Function

		Public Function FileUploaded() As ActionResult
			UploadControlExtension.GetUploadedFiles("uc", New UploadControlValidationSettings() With {.AllowedFileExtensions = New String() { ".html", ".htm", ".txt" }}, AddressOf FileUploadComplete)
			Return Nothing
		End Function

		Protected Sub FileUploadComplete(ByVal sender As Object, ByVal e As FileUploadCompleteEventArgs)
			If e.UploadedFile.IsValid Then
				e.CallbackData = System.Text.Encoding.UTF8.GetString(e.UploadedFile.FileBytes)
			End If
		End Sub
	End Class
End Namespace
