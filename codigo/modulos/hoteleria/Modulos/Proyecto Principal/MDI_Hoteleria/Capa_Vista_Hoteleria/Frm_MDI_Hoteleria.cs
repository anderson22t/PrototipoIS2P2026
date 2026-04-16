using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Capa_Vista;



namespace Capa_Vista_Hoteleria
{
    public partial class Frm_MDI_Hoteleria : Form
    {
        private int iIChildFormNumber = 0;

        public Frm_MDI_Hoteleria()
        {
            InitializeComponent();
            this.IsMdiContainer = true; // <- activa MDI container
            this.Load += Frm_MDI_Hoteleria_Load;
        }

        private void Frm_MDI_Hoteleria_Load(object sender, EventArgs e)
        {
            // Mostrar usuario conectado en StatusStrip si existe el control
            try
            {
                toolStripStatusLabel.Text = $"Estado: Conectado | Usuario: {Capa_Controlador_Seguridad.Cls_Usuario_Conectado.sNombreUsuario}";
            }
            catch
            {
                // Si no existe toolStripStatusLabel en este formulario, ignorar.
            }
        }

        // --- Control de formularios hijos MDI ---
        private void CerrarFormulariosHijos()
        {
            foreach (Form childForm in this.MdiChildren)
            {
                childForm.Close();
            }
        }

        private void ShowNewForm(object sender, EventArgs e)
        {
            CerrarFormulariosHijos();
            Form childForm = new Form();
            childForm.MdiParent = this;
            childForm.Text = "Ventana " + iIChildFormNumber++;
            childForm.Show();
        }

        // --- Handlers adaptados para abrir formularios como hijos MDI ---

        private void polizaContableToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
        }

        private void mantenimientoHabitacionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
         
        }

        private void tipoHabitacionesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
        }

        private void serviciosCuartosToolStripMenuItem_Click(object sender, EventArgs e)
        {
       
        }

        private void huespedesToolStripMenuItem_Click(object sender, EventArgs e)
        {
       
        }

        private void reservaToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void checkInToolStripMenuItem_Click_1(object sender, EventArgs e)
        {
            
        }

        private void salonesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CerrarFormulariosHijos();

        }

        private void implosionYExplosionToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void mantenimientoHoteleriaToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void ordenDeProduccionToolStripMenuItem_Click(object sender, EventArgs e)
        {
           
        }

        private void produccionHoteleriaToolStripMenuItem_Click(object sender, EventArgs e)
        {
           
        }

        private void actualizaciónEstadiaToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
        }

        private void asignacionServiciosAHabitacionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            
        }

        private void areaToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            
        }

        private void checkOutToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }


        private void pagoToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void foliosToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void reservacionDeSalonesToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void reservacionALaCartaToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void recetasToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void ordenesDeCompraToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void cierreDiarioToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void promocionesToolStripMenuItem_Click(object sender, EventArgs e)
        {

        }

        private void parcialToolStripMenuItem_Click(object sender, EventArgs e)
        {
            CerrarFormulariosHijos();
            Parcial formulario = new Parcial();
            formulario.MdiParent = this;
            formulario.Show();
        }
    }
}