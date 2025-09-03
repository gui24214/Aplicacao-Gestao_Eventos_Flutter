using System.ComponentModel.DataAnnotations;

namespace GestaoEventosAPI.Models
{
    public class Utilizador
    {
        [Key]
        public int Id_Utilizador { get; set; }

        [Required]
        [StringLength(100)]
        public string Nome { get; set; }

        public string Email { get; set; }

        public string Telemovel { get; set; }

        public DateTime Data_Nascimento { get; set; }

        [Required]
        [StringLength(100)]
        public string passe { get; set; }  // adiciona aqui a password
    }
}
