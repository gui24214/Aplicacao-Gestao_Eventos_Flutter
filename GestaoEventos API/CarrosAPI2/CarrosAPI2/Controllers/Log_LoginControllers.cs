using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using GestaoEventosAPI.Models;
using Microsoft.Extensions.Configuration;

namespace GestaoEventosAPI.Controllers
{
    public class LogLogin
    {
        private readonly string _connectionString;

        public LogLogin(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public List<Utilizador> GetUtilizadoresSQL(int idUtilizador)
        {
            List<Utilizador> listaUtilizador = new List<Utilizador>();

            using (var conn = new SqlConnection(_connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("sp_ObterUtilizadorPorId", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Id", idUtilizador);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var user = new Utilizador
                            {
                                Nome = reader["Nome"].ToString(),
                                Email = reader["Email"].ToString(),
                                // Preencha mais campos se necessário
                            };
                            listaUtilizador.Add(user);
                        }
                    }
                }
            }

            return listaUtilizador;
        }
    }
}
