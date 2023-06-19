using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Tarea1_AaronVillalobos_PrograAvanzada
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                double enteredValue;
                string resultado = "";
                bool parseSuccess = double.TryParse(value.Text, out enteredValue);
                if (parseSuccess)
                {
                    switch(calculation.SelectedValue)
                    {
                        case "Coseno":
                            resultado = calcularCoseno(enteredValue).ToString();
                            break;
                        case "Tangente":
                            resultado = calcularTangente(enteredValue).ToString();
                            break;
                        case "Area":
                            resultado = calcularArea(enteredValue).ToString();
                            break;
                        default:
                            resultado = "Error al realizar el calculo.";
                            break;
                    }

                    ltMessage.Text = String.Format("Resultado : {0}", resultado);
                }
            }
        }

        protected double calcularCoseno(double valor)
        {
            //double radianes = valor * (Math.PI / 180);
            return Math.Cos(valor);
        }

        protected double calcularTangente(double valor)
        {
            //double radianes = valor * (Math.PI / 180);
            return Math.Tan(valor);
        }

        protected double calcularArea(double valor)
        {
            return Math.PI * Math.Pow(valor, 2);
        }

        protected void cvValue_ServerValidate(object source, ServerValidateEventArgs args)
        {
            double enteredValue;
            string selectedCalculation = calculation.SelectedValue;
            bool parseSuccess = double.TryParse(args.Value, out enteredValue);
            bool trigonometryCalculation = selectedCalculation.Equals("Coseno") || selectedCalculation.Equals("Tangente");
            
            if (parseSuccess) {
                args.IsValid = trigonometryCalculation ? enteredValue >= 0 && enteredValue <= 360 : enteredValue >= 1 && enteredValue <= 2600;
            } else
            {
                args.IsValid = false;
            }
        }
    }
}