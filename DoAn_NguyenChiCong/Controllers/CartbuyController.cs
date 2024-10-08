﻿using NguyenChiCong.Models.VN_Pay;
using NguyenChiCong.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NguyenChiCong.Controllers
{
    public class CartbuyController : Controller
    {
        // GET: Cartbuy
        BaseAppDbContext db = new BaseAppDbContext();
        // GET: Cart

        public List<CartItem> getcart()
        {
            List<CartItem> carts = Session["Cart"] as List<CartItem>;
            if (carts == null || Session["Cart"] == null)
            {
                carts = new List<CartItem>();
                Session["Cart"] = carts;
            }
            return carts;
        }
        
        public ActionResult ShowCart()
        {
            if (Session["UserID"] == null)
            {
                return RedirectToAction("Login", "Page");
            }
            else
            {

                if (Session["Cart"] == null)
                {
                    ViewBag.totalmoney = 0;
                    return View();

                }
                else
                {
                    List<CartItem> listcart = Session["Cart"] as List<CartItem>;
                    ViewBag.totalmoney = TotalMoney();
                    return View(listcart);
                }

            }

        }
        public double TotalMoney()
        {
            List<CartItem> carts = Session["Cart"] as List<CartItem>;

            double totalmoney = carts.Sum(s => s.Product_Size.Product.newprice(s.Product_Size.Product.SaleOff, s.Product_Size.Product.Price) * s.QuantityProductSale);

            return totalmoney;
        }

        [HttpPost]
        public ActionResult AddtoCart(FormCollection form)
        {

            int id = int.Parse(form["ProductID"]);
            int sizeId = 1;
            var pro = db.Product_Size.SingleOrDefault(s => s.ProductID == id && s.SizeID == sizeId);
            if (pro != null)
            {

                var pro_size = getcart().FirstOrDefault(s => s.Product_Size.ProductID == id && s.Product_Size.SizeID == sizeId);
                if (pro_size == null)
                {
                    CartItem cartitem = new CartItem();
                    cartitem.Product_Size = pro;
                    cartitem.QuantityProductSale = 1;
                    getcart().Add(cartitem);
                }
                if (pro_size != null)
                {
                    pro_size.QuantityProductSale += 1;
                }
                
            }
            return RedirectToAction("ShowCart", "Cartbuy");
        }
        public ActionResult UpdateCartup(int id)
        {
            List<CartItem> carts = Session["Cart"] as List<CartItem>;
            var item = carts.Find(s => s.Product_SizeID == id);
            if (item != null)
            {
                item.QuantityProductSale += 1;
            }
            return RedirectToAction("ShowCart", "Cartbuy");
        }
        public ActionResult UpdateCartdown(int id)
        {
            List<CartItem> carts = Session["Cart"] as List<CartItem>;
            var item = carts.Find(s => s.Product_SizeID == id);
            if (item != null && item.Product_Size.Quantity > 0)
            {
                if (item.QuantityProductSale >= 1)
                {
                    item.QuantityProductSale -= 1;
                }

            }
            return RedirectToAction("ShowCart", "Cartbuy");
        }
        public PartialViewResult TotalQuantity()
        {
            List<CartItem> carts = Session["Cart"] as List<CartItem>;
            int total_quantity;
            if (carts == null)
            {
                total_quantity = 0;
            }
            else
            {
                total_quantity = carts.Sum(s => s.QuantityProductSale);

            }
            ViewBag.total_quantity = total_quantity;
            return PartialView("TotalQuantity");
        }
        public ActionResult Delete_Products(int id)
        {
            List<CartItem> carts = Session["Cart"] as List<CartItem>;
            var item = carts.Find(s => s.Product_SizeID == id);
            if (item != null)
            {
                carts.Remove(item);
            }
            return RedirectToAction("ShowCart", "Cartbuy");
        }
        public ActionResult CheckOut()
        {
            List<CartItem> carts = Session["Cart"] as List<CartItem>;
            ViewBag.totalmoney = TotalMoney();
            return View(carts);
        }
        public ActionResult SuccessOrder()
        {
            List<CartItem> carts = Session["Cart"] as List<CartItem>;
            
            foreach (var item in carts)
            {
                int proid = item.Product_Size.Product.ProductID;
                int sizeid = item.Product_Size.Size.SizeID;
                Product_Size pro_size = db.Product_Size.FirstOrDefault(s => s.Product.ProductID == proid && s.SizeID == sizeid);
                pro_size.Quantity -= item.QuantityProductSale;
                db.Product_Size.Attach(pro_size);
                db.Entry(pro_size).State = System.Data.Entity.EntityState.Modified;
                
            }
            carts.Clear();
            db.SaveChanges();
            return View();
        }
        public ActionResult VnPay_Return()
        {
            if (Request.QueryString.Count > 0)
            {
                string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Chuoi bi mat
                var vnpayData = Request.QueryString;
                VnPayLibrary vnpay = new VnPayLibrary();

                foreach (string s in vnpayData)
                {
                    //get all querystring data
                    if (!string.IsNullOrEmpty(s) && s.StartsWith("vnp_"))
                    {
                        vnpay.AddResponseData(s, vnpayData[s]);
                    }
                }
                string orderCode = Convert.ToString(vnpay.GetResponseData("vnp_TxnRef"));
                long vnpayTranId = Convert.ToInt64(vnpay.GetResponseData("vnp_TransactionNo"));
                string vnp_ResponseCode = vnpay.GetResponseData("vnp_ResponseCode");
                string vnp_TransactionStatus = vnpay.GetResponseData("vnp_TransactionStatus");
                String vnp_SecureHash = Request.QueryString["vnp_SecureHash"];
                String TerminalID = Request.QueryString["vnp_TmnCode"];
                long vnp_Amount = Convert.ToInt64(vnpay.GetResponseData("vnp_Amount")) / 100;
                String bankCode = Request.QueryString["vnp_BankCode"];

                bool checkSignature = vnpay.ValidateSignature(vnp_SecureHash, vnp_HashSecret);
                if (checkSignature)
                {
                    if (vnp_ResponseCode == "00" && vnp_TransactionStatus == "00")
                    {
                        var itemOrder = db.Orders.FirstOrDefault(x => x.OrderCode == orderCode);
                        if (itemOrder != null)
                        {
                            List<CartItem> carts = Session["Cart"] as List<CartItem>;
                            foreach (var item in carts)
                            {
                                int proid = item.Product_Size.Product.ProductID;
                                int sizeid = item.Product_Size.Size.SizeID;
                                Product_Size pro_size = db.Product_Size.FirstOrDefault(s => s.Product.ProductID == proid && s.SizeID == sizeid);
                                pro_size.Quantity -= item.QuantityProductSale;
                                db.Product_Size.Attach(pro_size);
                                db.Entry(pro_size).State = System.Data.Entity.EntityState.Modified;
                            }
                            carts.Clear();
                            itemOrder.OrderStatus = "1";
                            db.Orders.Attach(itemOrder);
                            db.Entry(itemOrder).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        //Thanh toan thanh cong
                        ViewBag.InnerText = "Giao dịch được thực hiện thành công. Cảm ơn quý khách đã sử dụng dịch vụ";
                        //log.InfoFormat("Thanh toan thanh cong, OrderId={0}, VNPAY TranId={1}", orderId, vnpayTranId);
                    }
                    else
                    {

                        ViewBag.InnerText = "Có lỗi xảy ra trong quá trình xử lý.Mã lỗi: " + vnp_ResponseCode;

                    }

                    ViewBag.ThanhToanThanhCong = "Số tiền thanh toán (VND):" + vnp_Amount.ToString();

                }

            }
            return View();
        }

        [HttpPost]
        public ActionResult CheckOut(FormCollection form)
        {
            int TypePayMent = int.Parse(form["TypePayment"]);
            List<CartItem> carts = Session["Cart"] as List<CartItem>;


            Order order = new Order();
            order.Address_Delivery = form["Address_Delivery"];
            order.PhoneCustomer = form["phone"];
            order.CustomerName = form["Name"];
            order.OrderDate = DateTime.Now;
            order.OrderTotalPrice = TotalMoney();
            order.TypePayment = TypePayMent;
            Random rd = new Random();
            order.OrderCode = "DH" + rd.Next(0, 9) + rd.Next(0, 9) + rd.Next(0, 9) + rd.Next(0, 9);
            order.OrderStatus = "0";
            order.UserID = (int)Session["UserID"];
            db.Orders.Add(order);
            foreach (var item in carts)
            {
                OrderDetail orderdetail = new OrderDetail();
                int proid = item.Product_Size.Product.ProductID;
                int sizeid = item.Product_Size.Size.SizeID;
                Product_Size pro_size = db.Product_Size.FirstOrDefault(s => s.Product.ProductID == proid && s.SizeID == sizeid);
                orderdetail.Product_SizeID = pro_size.Product_SizeID ;
                orderdetail.OrderQuantity = item.QuantityProductSale;
                orderdetail.TotalPrice = TotalMoney();
                orderdetail.OrderID = order.OrderID;
                db.OrderDetails.Add(orderdetail);
            }
            db.SaveChanges();
            //carts.Clear();
            string url = UrlPayment(order.OrderCode);
            if (TypePayMent > 0)
            {
                return Redirect(url);
            }
            else
            {
                return RedirectToAction("SuccessOrder","Cartbuy");
            }


        }



        public string UrlPayment(string ordercode)
        {
            //Get Config Info
            string vnp_Returnurl = ConfigurationManager.AppSettings["vnp_Returnurl"]; //URL nhan ket qua tra ve 
            string vnp_Url = ConfigurationManager.AppSettings["vnp_Url"]; //URL thanh toan cua VNPAY 
            string vnp_TmnCode = ConfigurationManager.AppSettings["vnp_TmnCode"]; //Ma định danh merchant kết nối (Terminal Id)
            string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Secret Key

           

            //Save order to db
            Order item = db.Orders.FirstOrDefault(s => s.OrderCode == ordercode);
            var price = (long)item.OrderTotalPrice * 100;
            //Build URL for VNPAY
            VnPayLibrary vnpay = new VnPayLibrary();

            vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);
            vnpay.AddRequestData("vnp_Command", "pay");
            vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
            vnpay.AddRequestData("vnp_Amount", (price).ToString()); //Số tiền thanh toán. Số tiền không mang các ký tự phân tách thập phân, phần nghìn, ký tự tiền tệ. Để gửi số tiền thanh toán là 100,000 VND (một trăm nghìn VNĐ) thì merchant cần nhân thêm 100 lần (khử phần thập phân), sau đó gửi sang VNPAY là: 10000000
            vnpay.AddRequestData("vnp_BankCode", "VNBANK");
            //if (TypePaymentVN ==1)
            //{
            //    vnpay.AddRequestData("vnp_BankCode", "VNPAYQR");
            //}
            //else if (TypePaymentVN == 2)
            //{
            //    vnpay.AddRequestData("vnp_BankCode", "VNBANK");
            //}
            //else if (TypePaymentVN == 3)
            //{
            //    vnpay.AddRequestData("vnp_BankCode", "INTCARD");
            //}

            vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));
            vnpay.AddRequestData("vnp_CurrCode", "VND");
            vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());
            vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang Mobile");
            vnpay.AddRequestData("vnp_OrderType", "VNPAY"); //default value: other
            vnpay.AddRequestData("vnp_Locale", "vn");
            vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
            vnpay.AddRequestData("vnp_TxnRef", ordercode.ToString()); // Mã tham chiếu của giao dịch tại hệ thống của merchant. Mã này là duy nhất dùng để phân biệt các đơn hàng gửi sang VNPAY. Không được trùng lặp trong ngày

            //Add Params of 2.1.0 Version
            //Billing

            string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);

            return paymentUrl;
        }
    }
}