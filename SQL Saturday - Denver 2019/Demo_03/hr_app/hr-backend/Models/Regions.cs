using System;
using System.ComponentModel.DataAnnotations;

namespace backend.Models
{
    public class Regions
    {
        [Key]
        public int region_id { get; set; }
        public string region_name { get; set; }
    }
}