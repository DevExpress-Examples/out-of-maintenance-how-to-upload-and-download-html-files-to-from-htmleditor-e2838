<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Models.EditHtmlText>" %>
<% 
    Html.DevExpress().HtmlEditor(
        settings => {
            settings.Name = "htmlEdit";
            settings.ClientSideEvents.CustomCommand = "OnCommand";
            settings.CallbackRouteValues = new { Controller = "Home", Action = "FeaturesPartial" };
            settings.SettingsImageUpload.UploadCallbackRouteValues = new { Controller = "Home", Action = "ImageUpload" };

            settings.SettingsImageSelector.Enabled = true;
            settings.SettingsImageSelector.EditingSettings.AllowCreate = true;
            settings.SettingsImageSelector.EditingSettings.AllowDelete = true;
            settings.SettingsImageSelector.EditingSettings.AllowMove = true;
            settings.SettingsImageSelector.EditingSettings.AllowRename = true;
            settings.SettingsImageSelector.UploadSettings.Enabled = true;
            if (ViewData["Html"] != null)
                settings.Html = (string)ViewData["Html"];
            settings.SettingsHtmlEditing.AllowScripts = true;
            settings.SettingsHtmlEditing.AllowIFrames = true;
            settings.SettingsHtmlEditing.AllowFormElements = true;
            settings.SettingsHtmlEditing.UpdateDeprecatedElements = true;
            settings.SettingsHtmlEditing.UpdateBoldItalic = true;
            settings.SettingsHtmlEditing.EnterMode = HtmlEditorEnterMode.Default;
            settings.Settings.AllowContextMenu = DefaultBoolean.Default;
            settings.Settings.AllowDesignView = true;
            settings.Settings.AllowHtmlView = true;
            settings.Settings.AllowPreview = true;

            settings.PreRender = (sender, e) => {
                ASPxHtmlEditor editor = (ASPxHtmlEditor)sender;
                editor.Width = 700;
            };
            Action<object, FileManagerActionEventArgsBase> editHandler = (sender, e) => {
                ((FileManagerActionEventArgsBase)e).Cancel = true;
                ((FileManagerActionEventArgsBase)e).ErrorText = "Error Text";
            };
            settings.ImageSelectorItemDeleting = (sender, e) => editHandler(sender, e);
            settings.ImageSelectorFolderCreating = (sender, e) => editHandler(sender, e);
            settings.ImageSelectorFileUploading = (sender, e) => editHandler(sender, e);
            settings.ImageSelectorItemMoving = (sender, e) => editHandler(sender, e);
            settings.ImageSelectorItemRenaming = (sender, e) => editHandler(sender, e);
            settings.Toolbars.CreateDefaultToolbars();

            var toolbar = settings.Toolbars.Add();
            var button = new CustomToolbarButton("Open HTML", "open");
            button.BeginGroup = true;
            button.ViewStyle = ViewStyle.Text;
            toolbar.Items.Add(button);

            button = new CustomToolbarButton("Save HTML", "save");
            button.ViewStyle = ViewStyle.Text;
            toolbar.Items.Add(button);

            button = new CustomToolbarButton("Clear", "clear");
            button.ViewStyle = ViewStyle.Text;
            toolbar.Items.Add(button);
        })
        .Render();
%>
