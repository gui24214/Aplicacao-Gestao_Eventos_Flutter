namespace GestaoEventosAPI.DTOs
{
    public class InscricaoDTO
    {
        public DateTime Data_Inscricao { get; set; }
        public int? Id_Estado { get; set; }
        public int? Id_Tipo_Pagamento { get; set; }
        public int Id_Evento { get; set; }
        public int Id_Utilizador { get; set; }
    }
}
