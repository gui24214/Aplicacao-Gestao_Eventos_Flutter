using System.ComponentModel.DataAnnotations;

namespace GestaoEventosAPI.Models
{
    public class Localizacao
    {
        [Key] //define a chave primaria
        public int Id_Localizacao { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings
        public string Morada { get; set; }

        public string? Codigo_Postal { get; set; }


    }
}