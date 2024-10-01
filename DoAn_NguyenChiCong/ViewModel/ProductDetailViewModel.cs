using NguyenChiCong.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DoAn_TranTheAnh_2020607026.ViewModel
{
    public class ProductDetailViewModel
    {

        public Product Product { get; set; }
        public IEnumerable<Brand> Brands { get; set; }

        public IEnumerable<Slide> Slides { get; set; }

        public IEnumerable<Category> Categories { get; set; }
      

        public IEnumerable<Product> RelatedProducts { get; set; }

    }
}