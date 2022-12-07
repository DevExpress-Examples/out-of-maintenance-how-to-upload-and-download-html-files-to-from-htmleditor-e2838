using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Models;
using DevExpress.Web.Mvc;
using DevExpress.Web;

namespace Controllers {
    [HandleError]
    public class HomeController : Controller {
        public ActionResult Index() {

            ViewData["Html"] = String.Empty;
            return View(new EditHtmlText());
        }

        [ValidateInput(false)]
        public ActionResult FeaturesPartial() {
            return PartialView("HtmlEditor");
        }

         [HttpPost]
        public FileContentResult DownloadFile() {
            String html = HtmlEditorExtension.GetHtml("htmlEdit");

            FileContentResult result = new FileContentResult(System.Text.Encoding.UTF8.GetBytes(html), "text/html");
            result.FileDownloadName = "myFile.html";
            return result;
        }

        public ActionResult FileUploaded() {
            UploadControlExtension.GetUploadedFiles("uc", new UploadControlValidationSettings() {
                AllowedFileExtensions = new String[] { ".html", ".htm", ".txt" }
            }, FileUploadComplete);
            return null;
        }

        protected void FileUploadComplete(object sender, FileUploadCompleteEventArgs e) {
            if (e.UploadedFile.IsValid) {
                e.CallbackData = System.Text.Encoding.UTF8.GetString(e.UploadedFile.FileBytes);
            }
        }
    }
}
