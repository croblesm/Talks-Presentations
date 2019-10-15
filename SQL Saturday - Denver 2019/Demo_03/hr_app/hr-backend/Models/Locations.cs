using System;
using System.ComponentModel.DataAnnotations;

namespace backend.Models
{
    public class Locations
    {
        [Key]
        public int location_id { get; set; }
        public string country_id { get; set; }
        public string city { get; set; }
        public string postal_code { get; set; }
        public string state_province { get; set; }
        public string street_address { get; set; }
    }
}