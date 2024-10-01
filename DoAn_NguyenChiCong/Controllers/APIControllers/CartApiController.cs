using DoAn_TranTheAnh_2020607026.ViewModel;
using NguyenChiCong.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace DoAn_TranTheAnh_2020607026.Controllers.APIControllers
{
    public class CartApiController : ApiController
    {

        BaseAppDbContext db = new BaseAppDbContext();

        [HttpGet()]
        [Route("getall")]
        public IEnumerable<CartItem> GetAllCart()
        {
            var result = db.CartItems.ToList();
            return result;
        }
    }
}
