using MvcBookStore.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MvcBookStore.Controllers
{
    public class BookStoreController : Controller
    {
        LinhKienDienTuDataContext data = new LinhKienDienTuDataContext();
        // GET: BookStore

        private List<SanPham> Laysachmoi(int count)
        {
            return data.SanPhams.OrderByDescending(a => a.TinhTrang).Take(count).ToList();
        }
        public ActionResult Index()
        {
            var sachmoi = Laysachmoi(5);
            return View(sachmoi);
        }

        public ActionResult ChuDe()
        {
            var chude = from cd in data.Loais select cd;
            return PartialView(chude);
        }

        public ActionResult Nhaxuatban()
        {
            var nhaXuatBan = from cd in data.NhaSanXuats select cd;
            return PartialView(nhaXuatBan);
        }

        //=============
        private string getTenLoai(int? id)
        {
            var tenloai = from s in data.Loais where s.MaLoai == id select s.TenLoai;
            return tenloai.FirstOrDefault();
        }

        public ActionResult SPTheoLoai(int id)
        {
            var sp = from s in data.SanPhams where s.MaLoai == id select s;
            ViewBag.tenloai = getTenLoai(id);
            return View(sp);
        }
        //===================
        private string getTenNSX(int? id)
        {
            var tenNSX = from s in data.NhaSanXuats where s.MaNhaSX == id select s.TenNhaSX;
            return tenNSX.FirstOrDefault();
        }

        public ActionResult SPTheoNSX(int id)
        {
            var sp = from s in data.SanPhams where s.MaNhaSX == id select s;
            ViewBag.tenNSX = getTenNSX(id);
            return View(sp);
        }
        //=================
        public ActionResult Details(int? id)
        {
            if (id == null) return HttpNotFound("Sản phẩm không tồn tại");
            var sp = from s in data.SanPhams where s.MaSanPham == id select s;
            return View(sp.Single());
        }
    }
}