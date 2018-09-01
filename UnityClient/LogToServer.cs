using System;
using System.Collections;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using UnityEngine;

namespace SGF.Network.UdpLog {
    public class LogToServer {

        private static IPAddress GroupAddress = IPAddress.Parse("192.168.2.4");

        private static int GroupPort = 12345;
        private static UdpClient sender;
        private static IPEndPoint groupEP;
        private static string Prefix = ">";

        public static void Send(string message) {

            sender = new UdpClient();

            groupEP = new IPEndPoint(GroupAddress, GroupPort);

            message = Prefix + GetTime() + message;

            try {

                byte[] bytes = Encoding.ASCII.GetBytes(message);

                sender.Send(bytes, bytes.Length, groupEP);

                sender.Close();

            } catch(Exception e) {

            }
        }

        private static string GetTime() {

            string str = "";

            DateTime now = DateTime.Now;
            str = now.ToString("HH:mm:ss.fff") + " ";
            str = "[" + str + "]" + ": ";
            return str;
        }
    }
}