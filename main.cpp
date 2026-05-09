#include <iostream>
#include <string>
#include <cctype>
#include <fstream>

#include "custom\json.hpp"

using namespace std;
using json = nlohmann::json;

struct Musik {
    string path, judul, artis;
    char genre;
    bool favorit;

    Musik(string p, string j, string a, char g, bool f = false) : path(p), judul(j), artis(a), genre(g), favorit(f) {}

    void tampilkanInfo() {
        cout << "----------------------------------------\n" << 
             "Judul: " << judul << "\n" <<
             "Artis: " << artis << "\n" <<
             "Genre: " << (genre == 'P' ? "Pop" : genre == 'R' ? "Rock" : "Jazz") << "\n" <<
             "Favorit: " << (favorit ? "Ya" : "Tidak") << "\n";
    }
};

struct playlist {
    vector<Musik> lagu;
};

string keKecil(string teks) {
    for (char &c : teks)
        c = tolower(c);
    return teks;
}

void muatLagu(vector<Musik>& playlist) {
    ifstream file("laguTersimpan.json");
    
    if (!file.is_open()) {
        cout << "[Info] Belum ada data tersimpan. Memulai playlist baru.\n";
        return; 
    }

    try {
        json j_list;
        file >> j_list;

        for (const auto& item : j_list) {
            string g_str = item["genre"];
            char g_char = g_str.empty() ? '?' : g_str[0];

            playlist.push_back(Musik(
                item["path"],
                item["judul"],
                item["artis"],
                g_char,
                item["favorit"]
            ));
        }
        cout << "[Selesai] Berhasil memuat " << playlist.size() << " lagu.\n";
    } catch (...) {
        cout << "[Error] File data rusak!\n";
    }

    file.close();
}

void simpanLagu(const vector<Musik>& playlist) {
    json j_list = json::array();

    for (const auto& m : playlist) {
        j_list.push_back({
            {"path", m.path},
            {"judul", m.judul},
            {"artis", m.artis},
            {"genre", string(1, m.genre)},
            {"favorit", m.favorit}
        });
    }

    ofstream file("laguTersimpan.json");
    file << j_list.dump(4);
}

int main() {
    vector<Musik> playlist;
    char opsi;

    muatLagu(playlist);

    for (;;) {
        system("cls");
        cout << "1. Simpan lagu\n2. Tampilkan lagu\n3. Cari lagu\nPilih opsi (1/2/3): "; cin >> opsi;
    
        if (opsi == '1') {
            for (;;) {
                string path, judul, artis;
                char genre;
                bool favorit;

                cout << "Masukkan path lagu: "; cin >> path;
                cout << "Masukkan judul lagu: "; getline(cin >> ws, judul);
                cout << "Masukkan artis lagu: "; getline(cin >> ws, artis);
                cout << "Masukkan genre lagu (P/R/J): "; cin >> genre;
                cout << "Apakah ini lagu favorit? (1 untuk ya, 0 untuk tidak): "; cin >> favorit;

                playlist.push_back(Musik(path, judul, artis, genre, favorit));

                char lanjut;
                cout << "Tambah lagu lagi? (y/n): "; cin >> lanjut;
                if (tolower(lanjut) != 'y') break;
            }
            simpanLagu(playlist);
            cout << "Playlist berhasil disimpan" << endl;
        } else if (opsi == '2') {
            system("cls");
            for (auto& m : playlist)
                m.tampilkanInfo();
        } else if (opsi == '3') {
            system("cls");
            string cari;
            cout << "Masukkan judul lagu yang dicari: ";
            getline(cin >> ws, cari);
        
            bool ditemukan = false;
            for (auto& m : playlist) {
                if (keKecil(m.judul).find(keKecil(cari)) != string::npos) {
                    m.tampilkanInfo();
                    ditemukan = true;
                }
            }
            if (!ditemukan) cout << "Lagu tidak ditemukan.\n";
        } else 
        cout << "Opsi tidak valid. Silakan pilih 1, 2, atau 3.\n";

    cout << "Apakah ingin keluar? (y/n): "; cin >> opsi;
    if (tolower(opsi) == 'y') break;
    }
    

    return 0;
}

