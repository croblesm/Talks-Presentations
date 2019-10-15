using System;
using System.ComponentModel.DataAnnotations;

namespace backend.Models
{
    public class Jobs
    {
        [Key]
        public int job_id { get; set; }
        public string job_title { get; set; }
        public decimal max_salary { get; set; }
        public decimal min_salary { get; set; }
    }
}