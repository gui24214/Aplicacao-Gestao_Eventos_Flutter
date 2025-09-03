using Microsoft.AspNetCore.Mvc;
using GestaoEventosAPI.Models;
using GestaoEventosAPI.DTOs;
using GestaoEventosAPI.Data;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class InscricaoController : ControllerBase
    {
        private readonly AppDbContext _context;

        public InscricaoController(AppDbContext context)
        {
            _context = context;
        }

        // GET: api/inscricao
        [HttpGet]
        public ActionResult<List<Inscricao>> Get()
        {
            var inscricoes = _context.Inscricao
                .Include(i => i.Estado_Pagamento)
                .Include(i => i.Tipo_Pagamento)
                .Include(i => i.Evento)
                .Include(i => i.Utilizador)
                .ToList();

            return Ok(inscricoes);
        }

        // GET: api/inscricao/{id}
        [HttpGet("{id}")]
        public ActionResult<Inscricao> Get(int id)
        {
            var inscricao = _context.Inscricao
                .Include(i => i.Estado_Pagamento)
                .Include(i => i.Tipo_Pagamento)
                .Include(i => i.Evento)
                .Include(i => i.Utilizador)
                .FirstOrDefault(i => i.Id_Inscricao == id);

            if (inscricao == null)
                return NotFound();

            return Ok(inscricao);
        }

        // POST: api/inscricao
        [HttpPost]
        public ActionResult Post([FromBody] InscricaoDTO dto)
        {
            try
            {
                var novaInscricao = new Inscricao
                {
                    Data_Inscricao = dto.Data_Inscricao,

                    // Se forem null, atribui valor padrão (ex: 1)
                    Id_Estado = dto.Id_Estado ?? 1,
                    Id_Tipo_Pagamento = dto.Id_Tipo_Pagamento ?? 1,

                    Id_Evento = dto.Id_Evento,
                    Id_Utilizador = dto.Id_Utilizador
                };

                _context.Inscricao.Add(novaInscricao);
                _context.SaveChanges();

                return CreatedAtAction(nameof(Get), new { id = novaInscricao.Id_Inscricao }, novaInscricao);
            }
            catch (Exception ex)
            {
                return BadRequest(new { mensagem = "Erro ao salvar inscrição", detalhes = ex.Message });
            }
        }

        // PUT: api/inscricao/{id}
        [HttpPut("{id}")]
        public ActionResult Put(int id, [FromBody] InscricaoDTO dto)
        {
            var inscricao = _context.Inscricao.Find(id);
            if (inscricao == null)
                return NotFound();

            inscricao.Data_Inscricao = dto.Data_Inscricao;
            inscricao.Id_Estado = dto.Id_Estado ?? inscricao.Id_Estado;
            inscricao.Id_Tipo_Pagamento = dto.Id_Tipo_Pagamento ?? inscricao.Id_Tipo_Pagamento;
            inscricao.Id_Evento = dto.Id_Evento;
            inscricao.Id_Utilizador = dto.Id_Utilizador;

            _context.SaveChanges();
            return NoContent();
        }

        // DELETE: api/inscricao/{id}
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var inscricao = _context.Inscricao.Find(id);
            if (inscricao == null)
                return NotFound();

            _context.Inscricao.Remove(inscricao);
            _context.SaveChanges();
            return NoContent();
        }
    }
}
