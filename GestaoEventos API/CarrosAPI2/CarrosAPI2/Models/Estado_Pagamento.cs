using System.ComponentModel.DataAnnotations;

namespace GestaoEventosAPI.Models
{
    public class Estado_Pagamento
    {
        [Key] //define a chave primaria
        public int Id_Estado { get; set; }

        [Required] // Campo obrigatorio
        [StringLength(100)] //Limita o tamanho das strings
        public string Descricao { get; set; }


    }
}