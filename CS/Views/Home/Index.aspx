<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

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
    <% Html.BeginForm("DownloadFile", "Home", FormMethod.Post, new { id = "myForm" });  %>
    <div>
        <table>
            <tr>
                <td>
                    <b>Select a file to upload: </b>
                </td>
                <td>
                    <%
                        Html.DevExpress().UploadControl(
                            settings => {
                                settings.Name = "uc";
                                settings.CallbackRouteValues = new { Controller = "Home", Action = "FileUploaded" };
                                settings.ClientSideEvents.FileUploadComplete = "function(s, e){ if (e.isValid) htmlEdit.SetHtml(e.callbackData); }";
                            })
                            .Render();
                    %>
                </td>
            </tr>
        </table>
        <% Html.RenderPartial("HtmlEditor"); %>
    </div>
    <% Html.EndForm();  %>
</asp:Content>
