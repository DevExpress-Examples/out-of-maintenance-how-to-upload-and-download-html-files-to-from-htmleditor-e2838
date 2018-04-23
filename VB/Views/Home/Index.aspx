<%@ Page Language="vb" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Home Page
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
	<script type="text/javascript">
		function OnCommand(s, e) {
			if (e.commandName == "open")
				uc.Upload();
			else if (e.commandName == "save")
				document.forms.myForm.submit();
			else if (e.commandName == "clear")
				htmlEdit.SetHtml("");
		}
	</script>
<%
	   Html.BeginForm("DownloadFile", "Home", FormMethod.Post, New With {Key .id = "myForm"})
%>
	<div>
		<table>
			<tr>
				<td>
					<b>Select a file to upload: </b>
				</td>
				<td>
					<%
						Html.DevExpress().UploadControl(Function(settings) AnonymousMethod1(settings)).Render()
					%>
				</td>
			</tr>
		</table>
<%
		   Html.RenderPartial("HtmlEditor")
%>
	</div>
<%
	   Html.EndForm()
%>
</asp:Content>


private bool AnonymousMethod1(object settings)
{
	settings.Name = "uc";
	settings.CallbackRouteValues = New { Controller = "Home", Action = "FileUploaded" };
	settings.ClientSideEvents.FileUploadComplete = "function(s, e){ if (e.isValid) htmlEdit.SetHtml(e.callbackData); }";
	Return True;
}