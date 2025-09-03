using System.ComponentModel.DataAnnotations;

namespace GestaoEventosAPI.Models
{
    public class Oradores
    {
        [Key] //define a chave primaria
        public int Id_Orador { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings
        public string Nome { get; set; }

        public string Nif { get; set; }

        public string Email{ get; set; }

        public string Telefone { get; set; }

    }
}

