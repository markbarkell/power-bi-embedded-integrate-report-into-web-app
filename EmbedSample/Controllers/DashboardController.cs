using System;
using System.Configuration;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;
using Microsoft.PowerBI.Api.V1;
using Microsoft.PowerBI.Security;
using Microsoft.Rest;
using paas_demo.Models;

namespace paas_demo.Controllers
{
    public class DashboardController : Controller
    {
        private readonly string workspaceCollection;
        private readonly string workspaceId;
        private readonly string accessKey;
        private readonly string apiUrl;

        public DashboardController()
        {
            // At one point, the code was directly reading the web.config file for the settings.
            // Given that I want to help ensure that I don't put private keys up within a web.config file
            // I have made it so that the code reads environmental variables.  Nevertheless, even this pattern
            // is not suitable for production code.   The reason is that the settings should be passed in
            // by dependency injection.  The implementation of the dependency injection might actually do reading
            // of the enviornment in more idealized code.
            // 
            // However, this code is code existing only for the purpose of understanding
            // how to program to use Microsoft's Power BI Embedded.   
            //
            // So, this comment is just telling the reader
            // that the code ought to be structured diffferently if doing a project that is not just a sample.
            // TODO, perhaps.
            string webConfigWorkspaceCollectionKey = ConfigurationManager.AppSettings["powerbi:WorkspaceCollection"];
            this.workspaceCollection = Environment.GetEnvironmentVariable(webConfigWorkspaceCollectionKey);
            string webConfigWorkspaceIdKey = ConfigurationManager.AppSettings["powerbi:WorkspaceId"];
            this.workspaceId = Environment.GetEnvironmentVariable(webConfigWorkspaceIdKey);
            string webConfigAccessKeyKey = ConfigurationManager.AppSettings["powerbi:AccessKey"];
            this.accessKey = Environment.GetEnvironmentVariable(webConfigAccessKeyKey);
            string webConfigApiUrlKey = ConfigurationManager.AppSettings["powerbi:ApiUrl"];
            this.apiUrl = webConfigApiUrlKey;
        }

        public ActionResult Index()
        {
            return View();
        }

        [ChildActionOnly]
        public ActionResult Reports()
        {
            using (var client = this.CreatePowerBIClient())
            {
                var reportsResponse = client.Reports.GetReports(this.workspaceCollection, this.workspaceId);

                var viewModel = new ReportsViewModel
                {
                    Reports = reportsResponse.Value.ToList(),
                    // TODO perhaps,  using the Session is very much the lazy man's way.   Of course,
                    // it limits the ability for throughput with some type of server farm.
                    // Yet, all of this code is meant as sample
                    // code to understand Microsoft Power BI Embedded in the content of ASP.NET MVC.
                    // So, I don't feel too bad.
                    UserName = Session["UserName"] as string,
                    RolesCSV = Session["RolesCSV"] as string
                };

                return PartialView(viewModel);
            }
        }

        [ValidateAntiForgeryToken]
        public ActionResult SetRoles(ReportsViewModel rvm)
        {
            // TODO perhaps,  using the Session is very much the lazy man's way.   Of course,
            // it limits the ability for throughput with some type of server farm.
            // Yet, all of this code is meant as sample
            // code to understand Microsoft Power BI Embedded in the content of ASP.NET MVC.
            // So, I don't feel too bad.
            Session["UserName"] = rvm.UserName;
            Session["RolesCSV"] = rvm.RolesCSV;
            return RedirectToAction("Index");
        }
        public async Task<ActionResult> Report(string reportId, string userName, string rolesCSV)
        {
            using (var client = this.CreatePowerBIClient())
            {
                var reportsResponse = await client.Reports.GetReportsAsync(this.workspaceCollection, this.workspaceId);
                var report = reportsResponse.Value.FirstOrDefault(r => r.Id == reportId);

                PowerBIToken embedToken = null;

                var userNameResolve = string.IsNullOrWhiteSpace(userName) ? null : userName.Trim();
                var roles = string.IsNullOrWhiteSpace(rolesCSV) ? null : rolesCSV.Split(new char[] { ',' }).Select(r => r.Trim());
                embedToken = PowerBIToken.CreateReportEmbedToken(
                    workspaceCollectionName: this.workspaceCollection, 
                    workspaceId: this.workspaceId, 
                    reportId: report.Id, 
                    username: userNameResolve, 
                    roles: roles
                    );
                
                

                var viewModel = new ReportViewModel
                {
                    Report = report,
                    AccessToken = embedToken.Generate(this.accessKey)
                };

                return View(viewModel);
            }
        } 

        // There are actually at least two ways of going about this which would be unit testable.
        // One way would be to make this an abstract method and provide an implementation in
        // a concrete class.  This would be an application of the Template Method Design Pattern.
        //
        // The other way would be to use Dependency Injection when constructing the controller.
        // the dependency injection would have provided an IPowerBIClient valid with a lifecycle
        // of the Http Request Cycle.
        //
        // Of course, this code was written as a sample on how to use Microsoft Power BI Embedded.
        // So, applying more SOLID principles and unit testing might confuse the primary purpose.
        // And of course, this sample code is not meant to be used for a production environment unchanged
        // and unvalidated.
        // TODO, perhaps.
        private IPowerBIClient CreatePowerBIClient()
        {
            var credentials = new TokenCredentials(accessKey, "AppKey");
            var client = new PowerBIClient(credentials)
            {
                BaseUri = new Uri(apiUrl)
            };

            return client;
        }
    }
}