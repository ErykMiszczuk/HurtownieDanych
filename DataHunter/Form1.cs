using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace DataHunter
{
    public partial class Form1 : Form
    {
        private string filePathString = "D:\\Magisterka\\HurtownieDanych\\dane\\db";
        private int numberOfLines = 0;
        private int numberOfFiles = 0;

        SqlConnection connection;

        public Form1()
        {
            InitializeComponent();
            filePath.Text = filePathString;
            numOfLinesLabel.Text = $"Wiersze: {numberOfLines}";
            numOfFilesLabel.Text = $"Pliki: {numberOfFiles}";
        }

        private void loadFileButton_Click(object sender, EventArgs e)
        {
            OdczytajPlik(filePathString);
        }

        private void OdczytajPlik(string nazwa)
        {
            numOfLinesLabel.Text = $"Wiersze: {numberOfLines}";
            numOfFilesLabel.Text = $"Pliki: {numberOfFiles}";
            //otwarcie pliku
            try
            {
                var reader = new StreamReader(nazwa);
                numberOfFiles++;
                while (!reader.EndOfStream)
                {
                    string line = reader.ReadLine();
                    PrzetwarzanieLinii(line);
                    numberOfLines++;
                }
            }
            catch (FileNotFoundException ex)
            {
                MessageBox.Show($"File not found.\n\nError message: {ex.Message}\n\n" +
                $"Details:\n\n{ex.StackTrace}");
            }
            numOfLinesLabel.Text = $"Wiersze: {numberOfLines}";
            numOfFilesLabel.Text = $"Pliki: {numberOfFiles}";
        }

        private void OtworzPoloczenie()
        {
            // Well since it is a uni project why not play with very bad practices since no one cares about you code anyway and it should just work (restricted by Bethesda)
            // Looks like error about connecting to database is still a thing
            // sigh Why we dont use excel from begging?
            // Hell yeah - error was caused by typo in database name, now im getting diffrent type of error
            //string connectionString = "Data Source=(local);Initial Catalog=HurtowniaLab;Integrated Security=False";
            //string connectionString = "Server = (local); Database = HurtowniaLab; Trusted_Connection = False; MultipleActiveResultSets = True; Integrated Security = True";
            //"Server=***;Initial Catalog=***;Persist Security Info=False;User  ID=***;Password=***;MultipleActiveResultSets=False;Encrypt=False;TrustServerCertificate=False;Connection Timeout=30;"
            string connectionString = "Initial Catalog = HurtowniaLab;server=(local);User Id = DataHunterUser; Password = Q@wertyuiop; Persist Security Info=False;MultipleActiveResultSets=False;Encrypt=False;TrustServerCertificate=True;Connection Timeout=30;";
            connection = new SqlConnection(connectionString);
            connection.Open();
        }

        private void ZmaknijPoloczenie()
        {
            connection.Close();
        }

        private void ZapisDoBazy(string typ, string data, string czas, string adresWejsciowy, string adresWyjsciowy, string protokol)
        {
            string commandText = "INSERT into ZoneAlarmLog(Zdarzenie, Data, Czas, Source, Destination, Transport) values (@typ, @data, @czas, @adresWejsciowy, @adresWyjsciowy, @protokol)";
            SqlCommand command = new SqlCommand(commandText, connection);
            DateTime dateTime;
            DateTime.TryParse(data, out dateTime);
            DateTime time;
            string xd = czas.Split(" ")[0];
            DateTime.TryParse(xd, out time);
            command.Parameters.Add("@typ", SqlDbType.VarChar).Value = typ;
            command.Parameters.Add("@data", SqlDbType.DateTime).Value = dateTime;
            command.Parameters.Add("@czas", SqlDbType.DateTime).Value = time;
            command.Parameters.Add("@adresWejsciowy", SqlDbType.VarChar).Value = adresWejsciowy;
            command.Parameters.Add("@adresWyjsciowy", SqlDbType.VarChar).Value = adresWyjsciowy;
            command.Parameters.Add("@protokol", SqlDbType.VarChar).Value = protokol;
            try
            {
                command.ExecuteNonQuery();
            } 
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void PrzetwarzanieLinii(string line, char separator = ',')
        {
            string[] separatedValues = line.Split(separator);
            int columnCount = 6;
            if (separatedValues.Length == columnCount)
            {
                string typ = separatedValues[0];
                if (typ != "type")
                {
                    listBox7.Items.Add(line);
                    string data = separatedValues[1];
                    string czas = separatedValues[2];
                    string source = separatedValues[3];
                    string destination = separatedValues[4];
                    string transport = separatedValues[5];
                    listBox1.Items.Add(typ);
                    listBox2.Items.Add(data);
                    listBox3.Items.Add(czas);
                    listBox4.Items.Add(source);
                    listBox5.Items.Add(destination);
                    listBox6.Items.Add(transport);
                    ZapisDoBazy(typ, data, czas, source, destination, transport);
                }
            }
        }

        private OpenFileDialog openFileDialog1;

        public void OpenFileDialogForm()
        {
            openFileDialog1 = new OpenFileDialog();
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                filePathString = openFileDialog1.FileName;
                filePath.Text = filePathString;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            OpenFileDialogForm();
        }

        private void oProgramieToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show(@"𝙈𝙖𝙙𝙚 𝙬𝙞𝙩𝙝 𝙡𝙤𝙫𝙚 𝙗𝙮 𝙀𝙧𝙮𝙠 𝙈𝙞𝙨𝙯𝙘𝙯𝙪𝙠 𝙖𝙣𝙙 𝙋𝙞𝙤𝙩𝙧 𝙆𝙧𝙯𝙚𝙨𝙯𝙤𝙬𝙨𝙠𝙞
ᴉʞsʍozsǝzɹꓘ ɹʇoᴉԀ puɐ ʞnzɔzsᴉꟽ ʞʎɹƎ ʎq ǝʌoʅ ɥʇᴉʍ ǝpɐꟽ
🅼🅰🅳🅴 🆆🅸🆃🅷 🅻🅾🆅🅴 🅱🆈 🅴🆁🆈🅺 🅼🅸🆂🆉🅲🆉🆄🅺 🅰🅽🅳 🅿🅸🅾🆃🆁 🅺🆁🆉🅴🆂🆉🅾🆆🆂🅺🅸
爪闩ᗪ🝗 山讠七卄 ㇄ㄖᐯ🝗 ⻏丫 㠪尺丫长 爪讠丂Ⲍ⼕Ⲍㄩ长 闩𝓝ᗪ 尸讠ㄖ七尺 长尺Ⲍ🝗丂Ⲍㄖ山丂长讠");
        }

        private void WyszukajPliki(string path)
        {
            OtworzPoloczenie();
            IEnumerable<string> filePaths = Directory.EnumerateFiles(filePathString, "*.txt");
            foreach (string f in filePaths)
            {
                //Przetwarzaj kazdy plik. Jego nazwa jest w zmiennej f
                OdczytajPlik(f);
            }
            ZmaknijPoloczenie();
        }

        private void searchForFiles_Click(object sender, EventArgs e)
        {
            if (filePathString.Length > 0)
            {
                WyszukajPliki(filePathString);
            } 
        }
    }
}
