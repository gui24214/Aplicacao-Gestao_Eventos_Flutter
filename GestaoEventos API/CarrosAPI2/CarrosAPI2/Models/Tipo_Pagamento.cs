using System.ComponentModel.DataAnnotations;

namespace GestaoEventosAPI.Models
{
    public class Tipo_Pagamento
    {
        [Key] //define a chave primaria
        public int Id_Tipo_Pagamento { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings
        public string Categoria { get; set; }
    }
}