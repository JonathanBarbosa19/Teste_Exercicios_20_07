<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Index.aspx.cs" Inherits="Projeto_Exercicios.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="Front-End/Bootstrap/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="Front-End/Bootstrap/Js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script type="text/javascript" src="Front-End/Script/jquery-3.3.1.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100&display=swap" rel="stylesheet">

    <script type="text/javascript" src="Front-End/Script/jquery.maskMoney.js"></script>
    <script type="text/javascript" src="Front-End/Script/jquery.maskMoney.min.js"></script>
    <title></title>
</head>
<body>

    <script type="text/javascript">


        function setExercicio(value) {
            var FecharTabelas;
            $('.form-check-input').each(
                function () {
                    if ($(this).prop("checked")) {
                        $(this).prop("checked", false);
                        $('.' + value).prop("checked", true);
                    } else {

                        if ($('.' + value).prop("checked")) {


                        } else {

                            FecharTabelas = 'Fecha Tabela';

                        }
                    }



                }
            );


            if (FecharTabelas == 'Fecha Tabela') {
                FecharTbExercicios('Fecha Tabela');
            }
            else if (value == 'Exercicio1') {
                FecharTbExercicios('Fecha Tabela');
                exercicio1();


            } else if (value == 'Exercicio2') {
                FecharTbExercicios('Fecha Tabela');
                exercicio2();

            }
            else if (value == 'Exercicio3') {
                FecharTbExercicios('Fecha Tabela');
                exercicio3();

            }
        }

        function FecharTbExercicios(value) {

            if (value == 'Exercicio1') {

                $('#tbExercicio2').addClass('hidden');

            } else if (value == 'Exercicio2') {

                $('#tbExercicio1').addClass('hidden');

            } else if (value == 'Fecha Tabela') {
                $('#tbExercicio1').addClass('hidden');
                $('#tbExercicio2').addClass('hidden');
                $('#tbExercicio1').html('');

            }

        }

        function exercicio1() {
            console.log('aqui');
            var id = '';
            $.ajax({
                type: 'POST',
                async: false,
                url: 'Index.aspx/Exercicio_1',
                data: "{'id':'" + id + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'JSON',
                success: function (data) {
                    console.log(data.d);
                    $('#lblwelcome').addClass('hidden');
                    $('#tbExercicio1').removeClass('hidden');

                    var table = '</hr> <tr> <td align="left">Funcionarios</td> <td></td> <td align="center">Salários</td> <td></td>  <td align="right" id="tdResultext" class="hidden">Resultado</td> </tr>'
                    $.each(data.d, function (index, value) {

                        table += '<tr style="height:20px">';
                        table += '<td style="height:20px; padding-top:0px" align="left">';
                        table += '<label style="font-size:15px;font-family: "Roboto", sans-serif;height:30px" name="lbDados_' + index + '"> ' + value + ' </label>';
                        table += '</td>'
                        table += '<td style="width:20px" align="center"> </td>';
                        table += '<td style="height:20px; padding-bottom:unset" align="center">'
                        table += '<input type="text" class="input_text decimal" style="width:100px;height:23px;text-align:right" name="salario" id="txtDados_' + index + '" value="0,00"/>';
                        table += '</td> '
                        table += '<td id="tdIgual' + index + '" class="hidden" style="width:20px" align="center">=</td>';
                        table += '<td class="hidden" style="height:20px;" id="tdResultado' + index + '" align="right">';
                        table += '<label style="font-size:15px;font-family: "Roboto", sans-serif;height:30px" id="lbResultado' + index + '"></label>';
                        table += '</td> '
                        table += '</tr>';

                    });
                    table += '<tr>';
                    table += '<td colspan="5"> </br> </br> </td>';
                    table += '</tr>';
                    table += '<tr>';
                    table += '<td colspan="4" align=center> <button class="btn btn-primary" onclick="calcular(); return false;">Gerar Calculo </button> </td>';
                    table += '</tr> </hr> ';

                    $('#tbExercicio1').html(table);

                    $('.decimal').maskMoney({ allowZero: true, thousands: '.', decimal: ',' });

                    // $('#tdDadosInput').html(input);

                },
                error: function (request, status, error) {
                    console.log(request.responseText);
                }
            });
        }

        function calcular() {

            var inputs = jQuery('input[name^="salario"]');
            var values = [];

            var valorAlterado = 0.00;
            var valor = 0.00;
            var resultado = 0.00;

            for (var i = 0; i < inputs.length; i++) {

                values.push($(inputs[i]).val());
                valor = values[i].replace('.', '').replace(',', '.');
                console.log(valor);
                if (valor <= 300) {

                    valorAlterado = (parseFloat(valor) * 50) / 100;
                    resultado = (parseFloat(valorAlterado) + parseFloat(valor));
                    $('#lbResultado' + [i]).html(resultado.toLocaleString('PT-BR', { minimumFractionDigits: 2 }));
                    $('#tdResultado' + [i]).removeClass('hidden');
                    $('#tdIgual' + [i]).removeClass('hidden');


                } else {

                    valorAlterado = (parseFloat(valor) * 30) / 100;
                    resultado = (parseFloat(valorAlterado) + parseFloat(valor));
                    $('#lbResultado' + [i]).html(resultado.toLocaleString('PT-BR', { minimumFractionDigits: 2 }));
                    $('#tdResultado' + [i]).removeClass('hidden');
                    $('#tdIgual' + [i]).removeClass('hidden');

                }

                $('#tdResultext').removeClass('hidden');
            }

        }

        function exercicio2() {
            $('#lblwelcome').addClass('hidden');
            $('#tbExercicio2').removeClass('hidden');

        }

        function exercicio3() {
            $('#lblwelcome').addClass('hidden');
            $('#tbExercicio3').removeClass('hidden');

        }

         function exercicio4() {
           
            var id = '';
            $.ajax({
                type: 'POST',
                async: false,
                url: 'Index.aspx/Exercicio_1',
                data: "{'id':'" + id + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'JSON',
                success: function (data) {
                    console.log(data.d);
                   

                },
                error: function (request, status, error) {
                    console.log(request.responseText);
                }
            });
        }




    </script>

    <style type="text/css">
        .hidden {
            visibility: hidden;
        }

        .input_text {
            display: block;
            width: 100%;
            padding: 2px 4px;
            font-size: 12px;
            line-height: 1.428571429;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
        }
    </style>

    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td>
                    <div style="width: 100%">
                        <div class="form-check form-switch">
                            <input class="form-check-input Exercicio1" type="checkbox" id="flexSwitchCheckDefault" onchange="setExercicio('Exercicio1')">
                            <label class="form-check-label" for="flexSwitchCheckDefault">1- Faça um algoritmo que calcule e exiba o salário reajustado de dez funcionários de acordo com a seguinte regra: Salário até 300, reajuste de 50%; Salários maiores que 300, reajuste de 30%.</label>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input Exercicio2" runat="server" type="checkbox" id="flexSwitchCheckChecked" onchange="setExercicio('Exercicio2')">
                            <label class="form-check-label" for="flexSwitchCheckChecked">2- Array na ordem inversa à da leitura.</label>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input Exercicio3" runat="server" type="checkbox" id="flexSwitchCheckDisabled" onchange="setExercicio('Exercicio3')">
                            <label class="form-check-label" for="flexSwitchCheckDisabled">3- Utilizando listas e LINQ ou lambdas, dada uma lista com n alunos, imprimi-la de forma ordenada pela matricula</label>
                        </div>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" runat="server" id="flexSwitchCheckCheckedDisabled" onchange="setExercicio('Exercicio4')">
                            <label class="form-check-label" for="flexSwitchCheckCheckedDisabled">4- Crie um serviço WEB API que possibilite a criação, alteração e pesquisa de um aluno</label>
                        </div>
                    </div>

                </td>
            </tr>
        </table>



        <br />
        <br />
        <div id="Div1" runat="server" style="background-color: aliceblue" align="center">
            <hr />
            <label id="lblwelcome" runat="server" class="">Olá vamos começar? Escolha um exercicio acima por favor!!</label>

            <table id="tbExercicio1" runat="server" class="hidden" align="center" style="width: 30%"></table>
        

            <table id="tbExercicio2" runat="server" class="hidden" align="center" style="width: 30%">
                <tr>
                    <td style="width: 100px" align="center">
                        <asp:Label ID="lbResult0" runat="server"></asp:Label>
                        <br />
                        <input style="width: 50px; text-align: center; align-items: center" maxlength="1" runat="server" id="txt_0" />

                    </td>
                    <td style="width: 100px" align="center">
                        <asp:Label ID="lbResult1" runat="server"></asp:Label>
                        <br />
                        <input style="width: 50px; text-align: center; align-items: center" maxlength="1" runat="server" id="txt_1" />

                    </td>
                    <td style="width: 100px" align="center">
                        <asp:Label ID="lbResult2" runat="server"></asp:Label>
                        <br />
                        <input style="width: 50px; text-align: center; align-items: center" maxlength="1" runat="server" id="txt_2" />

                    </td>

                    <td style="width: 100px" align="center">
                        <asp:Label align="center" ID="lbResult3" runat="server"></asp:Label>
                        <br />
                        <input style="width: 50px; text-align: center; align-items: center" maxlength="1" runat="server" id="txt_3" />

                    </td>

                </tr>

                <tr>
                    <td colspan="4" align="center">
                        <br />
                        <br />
                        <asp:Button ID="btnVetor" runat="server" class="btn btn-primary" Text="Inverter" OnClick="btnVetor_Click" />
                    </td>
                </tr>
            </table>

             <table id="tbExercicio3" runat="server" class="hidden" align="center" style="width: 30%">
                 <tr>
                     <td id="tdExercicio3" runat="server" align="center">
                           
                     </td>
                 </tr>
                  <tr>
                    <td align="center">
                        <br />
                      
                        <asp:Button ID="btnListaAlunos" runat="server" class="btn btn-primary" Text="Imprimir"  OnClick="btnListaAlunos_Click"/>
                    </td>
                </tr>
            </table>
            <hr />
        </div>
        <br />

    </form>
</body>
</html>
