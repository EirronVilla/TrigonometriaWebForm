<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Tarea1_AaronVillalobos_PrograAvanzada._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <div style="display: flex;" class="mt-5">
            <div style="margin: auto;">
                <h1> Calculo de Coseno, Tangente, &Aacute;rea</h1>
            </div>
        </div>
        <div class="container">
            <div class="row mt-5">
                <div class="col-6">
                    <h2>Instrucciones: </h2>

                    <p> 
                        1. Introduzca el valor que desea conocer, <br />
                        2. Seleccione el calculo que desea realizar. <br />
                        3. Si el calculo es el area de un circulo, ingrese el valor del radio. <br />
                        4. Haga click en calcular.
                    </p>

                </div>
                <div class="col-6">
                    <h2>Formulario:</h2>
                    <div class="formulario">
                        <div class="row">
                            <label class="form-label">Valor <span id="metric"></span>: </label> <br />
                            <asp:TextBox ID="value" runat="server" type="number" min="0" step="any" CssClass="form-control" value="0"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ID="rfvValue" ControlToValidate="value" ErrorMessage="Este campo es requerido" Display="Dynamic"/>
                            <asp:CustomValidator runat="server" ID="cvValue" ControlToValidate="value" OnServerValidate="cvValue_ServerValidate" ErrorMessage="Valor es demasiado grande" Display="Dynamic"/>
                        </div>

                        <div class="row mt-3">
                            <label class="form-label">Operacion: </label> <br />
                            <asp:DropDownList ID="calculation" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Tangente" Value="Tangente"></asp:ListItem>
                                <asp:ListItem Text="Coseno" Value="Coseno"></asp:ListItem>
                                <asp:ListItem Text="Area" Value="Area"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="row mt-3">
                            <asp:Button ID="submit" Text="Calcular" runat="server" OnClick="submit_Click" CssClass="btn btn-primary"/>

                        </div>

                    </div>
                </div>
            </div>


            <div class="row mt-5">
                <div class="col">
                    <asp:Literal ID="ltMessage" runat="server" /> <br />
                </div>
            </div>
            <canvas id="myChart" style="width:100%; display:none;"></canvas>

        </div>
    </main>

    <script>
        let operationValue = "";
        $(document).ready(function () {
            let calculationValue = $('select').val();
            updateMetricValue(calculationValue);

            $('select').on('change', function () {
                updateMetricValue(this.value);
            });

            if (operationValue.length > 0) {
                generateGraph();
            }

        });

        function updateMetricValue(calculationType) {
            if (calculationType == "Tangente") {
                operationValue = "tan(x)";
                $("#metric").text('(radianes)');
            }
            if (calculationType == "Coseno") {
                operationValue = "cos(x)";
                $("#metric").text('(radianes)');
            }
            if (calculationType == "Area") {
                $("#myChart").css("display", "none");
                $("#metric").text('(radio)');
            }
        }

        // CHART JS
        function generateGraph() {
            let numberValue = parseFloat($("#MainContent_value").val());

            if (numberValue > 360) {
                return;
            }

            $("#myChart").css("display", "block");

            var xValues = [];
            var yValues = [];
            generateData(`Math.${operationValue}`, numberValue - 15, numberValue + 15, 0.5);

            var myChart = new Chart("myChart", {
                type: "line",
                data: {
                    labels: xValues,
                    datasets: [{
                        fill: false,
                        pointRadius: 2,
                        pointBackgroundColor: [],
                        pointRadius: [],
                        borderColor: "rgba(0,0,255,0.5)",
                        data: yValues
                    }]
                },
                options: {
                    legend: { display: false },
                    title: {
                        display: true,
                        text: `y = ${operationValue}`,
                        fontSize: 16
                    }
                }
            });

            myChart.data.datasets[0].pointBackgroundColor[30] = 'lightgreen';
            myChart.data.datasets[0].pointRadius[30] = 10;
            myChart.update();

            function generateData(value, i1, i2, step = 1) {
                for (let x = i1; x <= i2; x += step) {
                    yValues.push(eval(value));
                    xValues.push(x);
                }
            }
        }


       


    </script>

</asp:Content>
