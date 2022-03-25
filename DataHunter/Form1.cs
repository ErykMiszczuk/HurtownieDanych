﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
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
        private string filePathString = "D:\\Magisterka\\HurtownieDanych\\dane\\db_small\\ZALog2003.09.30.txt";
        private int numberOfLines = 0;
        public Form1()
        {
            InitializeComponent();
            filePath.Text = filePathString;
            numOfLinesLabel.Text = $"Liczba wierszy: {numberOfLines}";
        }

        private void loadFileButton_Click(object sender, EventArgs e)
        {
            OdczytajPlik(filePathString);
        }

        private void OdczytajPlik(string nazwa)
        {
            listBox1.Items.Clear();
            listBox2.Items.Clear();
            listBox3.Items.Clear();
            listBox4.Items.Clear();
            listBox5.Items.Clear();
            listBox6.Items.Clear();
            listBox7.Items.Clear();
            numberOfLines = 0;
            numOfLinesLabel.Text = $"Liczba wierszy: {numberOfLines}";
            //otwarcie pliku
            try
            {
                var reader = new StreamReader(filePath.Text);
                while(!reader.EndOfStream)
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
            numOfLinesLabel.Text = $"Liczba wierszy: {numberOfLines}";
        }

        private void PrzetwarzanieLinii(string line, char separator = ',')
        {
            string[] separatedValues = line.Split(separator);
            int columnCount = 6;
            if (separatedValues.Length == columnCount)
            {
                listBox7.Items.Add(line);
                string typ = separatedValues[0];
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
    }
}