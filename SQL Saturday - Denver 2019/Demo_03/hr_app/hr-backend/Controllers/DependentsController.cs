using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using backend;
using backend.Models;

namespace backend.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DependentsController : ControllerBase
    {
        private readonly DemoContext _context;

        public DependentsController(DemoContext context)
        {
            _context = context;
        }

        // GET: api/Dependents
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Dependents>>> GetDependents()
        {
            return await _context.Dependents.ToListAsync();
        }

        // GET: api/Dependents/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Dependents>> GetDependents(int id)
        {
            var dependents = await _context.Dependents.FindAsync(id);

            if (dependents == null)
            {
                return NotFound();
            }

            return dependents;
        }

        // PUT: api/Dependents/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutDependents(int id, Dependents dependents)
        {
            if (id != dependents.dependent_id)
            {
                return BadRequest();
            }

            _context.Entry(dependents).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!DependentsExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Dependents
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for
        // more details see https://aka.ms/RazorPagesCRUD.
        [HttpPost]
        public async Task<ActionResult<Dependents>> PostDependents(Dependents dependents)
        {
            _context.Dependents.Add(dependents);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetDependents", new { id = dependents.dependent_id }, dependents);
        }

        // DELETE: api/Dependents/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Dependents>> DeleteDependents(int id)
        {
            var dependents = await _context.Dependents.FindAsync(id);
            if (dependents == null)
            {
                return NotFound();
            }

            _context.Dependents.Remove(dependents);
            await _context.SaveChangesAsync();

            return dependents;
        }

        private bool DependentsExists(int id)
        {
            return _context.Dependents.Any(e => e.dependent_id == id);
        }
    }
}
