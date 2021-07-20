using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Projeto_Exercicios
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static List<String> Exercicio_1(String id)
        {

            List<String> listFuncionarios = new List<String>();
            for (int i = 1; i <= 10; i++)
            {

                String funcionario = "";
                funcionario += "Funcionario_" + i.ToString();
                listFuncionarios.Add(funcionario);
            }

            return listFuncionarios;


        }

        protected void btnVetor_Click(object sender, EventArgs e)
        {

            int[] vetor = { Convert.ToInt32(txt_0.Value), Convert.ToInt32(txt_1.Value), Convert.ToInt32(txt_2.Value), Convert.ToInt32(txt_3.Value) };

            int[] vetorInverso = { Convert.ToInt32(txt_0.Value), Convert.ToInt32(txt_1.Value), Convert.ToInt32(txt_2.Value), Convert.ToInt32(txt_3.Value) };

            for (int i = 0, j = 3; i < vetor.Length; i++, j--)
            {
                vetorInverso[j] = vetor[i];
            }

            String resultado = "";
            for (int i = 0; i < vetor.Length; i++)
            {
                resultado += vetorInverso[i].ToString() + ",";
            }


            lbResult0.Text = resultado.Split(',')[0];
            lbResult1.Text = resultado.Split(',')[1];
            lbResult2.Text = resultado.Split(',')[2];
            lbResult3.Text = resultado.Split(',')[3];
            lblwelcome.Attributes.Add("class", "hidden");
            tbExercicio2.Attributes.Add("class", "");
            flexSwitchCheckChecked.Checked = true;


        }

        protected void btnListaAlunos_Click(object sender, EventArgs e)
        {
            List<Aluno> listaAlunos = new List<Aluno>();
            listaAlunos.Add(
                           new Aluno()
                           {
                               matricula = 9,
                               Nome = "Davi",
                               idade = 12
                           });

            listaAlunos.Add(
                           new Aluno()
                           {
                               matricula = 20,
                               Nome = "Jorge",
                               idade = 12
                           });

            listaAlunos.Add(
                            new Aluno()
                            {
                                matricula = 15,
                                Nome = "Camila",
                                idade = 12
                            });

            listaAlunos.Add(
                             new Aluno()
                             {
                                 matricula = 10,
                                 Nome = "Natalia",
                                 idade = 12
                             });


            var query = from Aluno alunos in listaAlunos
                        orderby alunos.matricula ascending
                        select alunos;

            lblwelcome.Attributes.Add("class", "hidden");
            tbExercicio3.Attributes.Add("class", "");
            flexSwitchCheckDisabled.Checked = true;

            foreach (Aluno a in query)
            {

                Label lbl1 = new Label
                {
                    ID = "lblmatricula" + a.matricula,
                    Text = "Matricula: " + a.matricula.ToString() + "</br>" + "Nome: " + a.Nome +"</br>" + "Idade: " + a.idade.ToString() + "</br></br>"
                };

                tdExercicio3.Controls.Add(lbl1);

                
            }

      
        }


    }
    

    public class Aluno
    {
        public Int32 matricula { get; set; }
        public String Nome { get; set; }
        public Int32 idade { get; set; }
    }

    public class Album
    {
        public String Nome { get; set; }
        public String Artista { get; set; }
        public String Ritimo { get; set; }
    }
    public class Banda
    {
        public String Nome { get; set; }
        public Int32 Qtde_integrantes { get; set; }
        public String Ritmo { get; set; }
    }

}