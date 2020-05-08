using System;
using System.ComponentModel.DataAnnotations;

namespace backend.Models
{
    public class Employees
    {
        [Key]
        public int employee_id { get; set; }
        public int department_id { get; set; }
        public string first_name { get; set; }
        public string last_name { get; set; }
        public string email { get; set; }

        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        [DataType(DataType.Date)]
        public DateTime hire_date { get; set; }
        public int job_id { get; set; }
        public int? manager_id { get; set; }
        public string phone_number { get; set; }
        public decimal salary { get; set; }
    }
}