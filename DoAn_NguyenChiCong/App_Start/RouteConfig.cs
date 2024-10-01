using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace NguyenChiCong
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Page", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "GridShop",
                url: "shop/category/{categoryId}",
                defaults: new { controller = "PageController", action = "GridShop" }
            );

            routes.MapRoute(
                name:"DetailProduct",
                url: "product/{productId}",
                defaults: new { controller = "PageController", action = "DetailProduct" }
            );
        }
    }
}
