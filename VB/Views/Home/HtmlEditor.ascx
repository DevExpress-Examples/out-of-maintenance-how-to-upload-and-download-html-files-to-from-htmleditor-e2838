<%@ Control Language="vb" Inherits="System.Web.Mvc.ViewUserControl<Models.EditHtmlText>" %>
<% 
	Html.DevExpress().HtmlEditor(Function(settings) AnonymousMethod1(settings)).Render()
%>


private bool AnonymousMethod1(object settings)
{
	settings.Name = "htmlEdit";
	settings.ClientSideEvents.CustomCommand = "OnCommand";
	settings.CallbackRouteValues = New { Controller = "Home", Action = "FeaturesPartial" };
	settings.SettingsImageUpload.UploadCallbackRouteValues = New { Controller = "Home", Action = "ImageUpload" };
	settings.SettingsImageSelector.Enabled = True;
	settings.SettingsImageSelector.EditingSettings.AllowCreate = True;
	settings.SettingsImageSelector.EditingSettings.AllowDelete = True;
	settings.SettingsImageSelector.EditingSettings.AllowMove = True;
	settings.SettingsImageSelector.EditingSettings.AllowRename = True;
	settings.SettingsImageSelector.UploadSettings.Enabled = True;
	if (ViewData["Html"] != Nothing)
		settings.Html = (string)ViewData["Html"];
		settings.SettingsHtmlEditing.AllowScripts = True;
		settings.SettingsHtmlEditing.AllowIFrames = True;
		settings.SettingsHtmlEditing.AllowFormElements = True;
		settings.SettingsHtmlEditing.UpdateDeprecatedElements = True;
		settings.SettingsHtmlEditing.UpdateBoldItalic = True;
		settings.SettingsHtmlEditing.EnterMode = HtmlEditorEnterMode.Default;
		settings.Settings.AllowContextMenu = DefaultBoolean.Default;
		settings.Settings.AllowDesignView = True;
		settings.Settings.AllowHtmlView = True;
		settings.Settings.AllowPreview = True;
		settings.PreRender = (sender, e) =>
		{
			ASPxHtmlEditor editor = (ASPxHtmlEditor)sender;
			editor.Width = 700;
		};
		Action<object, FileManagerActionEventArgsBase> editHandler = (sender, e) =>
		{
			((FileManagerActionEventArgsBase)e).Cancel = True;
			((FileManagerActionEventArgsBase)e).ErrorText = "Error Text";
		};
		settings.ImageSelectorItemDeleting = (sender, e) => editHandler(sender, e);
		settings.ImageSelectorFolderCreating = (sender, e) => editHandler(sender, e);
		settings.ImageSelectorFileUploading = (sender, e) => editHandler(sender, e);
		settings.ImageSelectorItemMoving = (sender, e) => editHandler(sender, e);
		settings.ImageSelectorItemRenaming = (sender, e) => editHandler(sender, e);
		settings.Toolbars.CreateDefaultToolbars();
		var toolbar = settings.Toolbars.Add();
		var button = New CustomToolbarButton("Open HTML", "open");
		button.BeginGroup = True;
		button.ViewStyle = ViewStyle.Text;
		toolbar.Items.Add(button);
		button = New CustomToolbarButton("Save HTML", "save");
		button.ViewStyle = ViewStyle.Text;
		toolbar.Items.Add(button);
		button = New CustomToolbarButton("Clear", "clear");
		button.ViewStyle = ViewStyle.Text;
		toolbar.Items.Add(button);
	Return True;
}