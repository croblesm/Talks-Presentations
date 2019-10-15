using System;
using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend
{
    public class DemoContext : DbContext
    {
        public DemoContext(DbContextOptions<DemoContext> options)
            : base(options)
        { }

        public DbSet<Countries> Countries { get; set; }

        public DbSet<backend.Models.Departments> Departments { get; set; }

        public DbSet<backend.Models.Dependents> Dependents { get; set; }

        public DbSet<backend.Models.Employees> Employees { get; set; }

        public DbSet<backend.Models.Jobs> Jobs { get; set; }

        public DbSet<backend.Models.Locations> Locations { get; set; }

        public DbSet<backend.Models.Regions> Regions { get; set; }
    }
}