using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;
using GestaoEventosAPI.Models;

namespace GestaoEventosAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly string connectionString;

        // Recebe a configuração via injeção de dependência
        public AuthController(IConfiguration configuration)
        {
            // Pega a connection string do appsettings.json (DefaultConnection)
            connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest login)
        {
            if (string.IsNullOrEmpty(login.Email) || string.IsNullOrEmpty(login.passe))
                return BadRequest("Email e password são obrigatórios.");

            Utilizador user = null;

            using (var conn = new SqlConnection(connectionString))
            {
                using (var cmd = new SqlCommand("sp_ObterUtilizadorPorEmail", conn)) // Stored procedure
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Email", login.Email);

                    conn.Open();
                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            var passwordDoBanco = reader["passe"].ToString();

                            if (passwordDoBanco == login.passe)
                            {
                                user = new Utilizador
                                {
                                    Nome = reader["Nome"].ToString(),
                                    Email = reader["Email"].ToString(),
                                    Telemovel = reader["Telemovel"].ToString(),
                                    Data_Nascimento = reader.GetDateTime(reader.GetOrdinal("Data_Nascimento")),
                                    passe = passwordDoBanco
                                };
                            }
                            else
                            {
                                return Unauthorized("Senha incorreta.");
                            }
                        }
                        else
                        {
                            return Unauthorized("Email não encontrado.");
                        }
                    }
                }
            }

            if (user == null)
                return Unauthorized();

            return Ok(user);
        }
    }
}
