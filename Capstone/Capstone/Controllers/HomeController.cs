using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Capstone.Models;

namespace Capstone.Controllers
{
    public class HomeController : Controller
    {
        capstoneEntities storeDB = new capstoneEntities();

        [Authorize]
        public ActionResult Protected()
        {
            return View();
        }

        public ActionResult Index()
        {
            ViewBag.Message = "Welcome to ASP.NET MVC!";

            return View();
        }

        public ActionResult About()
        {
            return View();
        }

        public ActionResult Parts()
        {
            if (Request.Url.Query.Contains("search"))
            {
                string partQuery = Request.Url.Query.ToString();
                partQuery = partQuery.Substring(14);

                var searchedParts = from p in storeDB.parts_table
                                    select p;

                if (!String.IsNullOrEmpty(partQuery))
                {
                    searchedParts = searchedParts.Where(sp => sp.part_description.Contains(partQuery));
                }

                List<parts_table> searchedPartsList = new List<parts_table>();
                searchedPartsList = searchedParts.ToList();

                return View("PartsSearch", searchedPartsList);
            }
            else
            {
                var partsList = storeDB.parts_table.ToList();
                var carQuery = from cars in storeDB.car_table select cars;
                var carList = carQuery.ToList();
                var idQuery = from carID in storeDB.car_table select carID.car_id;
                var idList = idQuery.ToList();

                // Set up our ViewModel
                var partViewModel = new Capstone.ViewModels.PartViewModel
                {
                    PartItems = partsList,
                    CarList = carList,
                    CarId = idList
                };

                return View(partViewModel);
            }
        }

        [HttpPost]
        public ActionResult Search(string searchString)
        {

            var searchedParts = from p in storeDB.parts_table
                                select p;

            if (!String.IsNullOrEmpty(searchString))
            {
                searchedParts = searchedParts.Where(sp => sp.part_description.Contains(searchString));
            }

            return View(searchedParts);
        }

        private IList<car_table> GetCarMake(int carYear)
        {
            return storeDB.car_table.Where(make => make.car_year == carYear).ToList();
        }

        private IList<car_table> GetCarModel(string carMake)
        {
            return storeDB.car_table.Where(make => make.car_make == carMake).ToList();
        }

        private IEnumerable<parts_table> GetCarParts(int carModelId)
        {
            List<parts_table> tempList = new List<parts_table>();
            tempList = storeDB.parts_table.Where(model => model.car_id == carModelId).ToList();
            IEnumerable<parts_table> partsTable = tempList;

            return partsTable;
        }
        
        [AcceptVerbs(HttpVerbs.Get)]
        public JsonResult LoadMakesByYear(string id)
        {
            var makeList = this.GetCarMake(Convert.ToInt32(id));

            var makeData = makeList.Select(m => new SelectListItem()
            {
                Text = m.car_make,
                Value = m.car_make.ToString(),

            });

            return Json(makeData, JsonRequestBehavior.AllowGet); 
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public JsonResult LoadModelsByMake(string carMake)
        {
            var modelList = this.GetCarModel(carMake);

            var modelData = modelList.Select(m => new SelectListItem()
            {
                Text = m.car_model,
                Value = m.car_id.ToString(),

            });

            return Json(modelData, JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public JsonResult LoadPartsByModel(int carModelId)
        {
            var tempPartsList = this.GetCarParts(carModelId);

            var partsList = tempPartsList.Select(m => new
            {
                PartNumber = m.part_number,
                Description = m.part_description,
                Stock = m.part_stock,
                Price = m.part_price,
                Category = m.part_category

            });

            return Json(partsList, JsonRequestBehavior.AllowGet); 
        }
    }
}
