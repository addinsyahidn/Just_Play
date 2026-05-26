#include <iostream>
#include <vector>
#include <fstream>
#include "playlist.h"
using json = nlohmann::json;
//kodingan logika playlist (belum final)
/*yang harus diperbaiki dan ditambah:
-url,genre,dll kalo bisa masukin ke bank lagu
-buat json satu lagi untuk nyimpan vector playlist jadi ga ilang pas keluar
-fungsi untuk hapus lagu dari playlist
-fungsi untuk nambah objek baru dari class Playlist untuk buat playlist baru
-jangan lupa buat linked list untuk play otomatis musik di playlist*/

std::vector<Playlist>semuaPlaylist;

Playlist::Playlist(const std::string& nama){
    std::ifstream bank_lagu("bank_lagu.json");
    bank_lagu >> bank;
    bank_lagu.close();
    this->nama=nama;
    
}

void Playlist::tambah_playlist(const std::string& nama_playlist){
    std::ofstream file("daftar_playlist.json");
    current=lagu.end();
    playlist[nama_playlist];
    file << playlist;  
    file.close();

    Playlist p(nama_playlist);
    semuaPlaylist.push_back(p);
}

void Playlist::tambah_lagu(const std::string& nama_playlist, const song& x){
    std::ofstream file("daftar_playlist.json");
    for (Playlist& p:semuaPlaylist){
        if (p.nama==nama_playlist){
            for (const song& y : p.lagu){
                if (y.kode==x.kode){return;}
            }
            p.lagu.push_back(x);
            current=p.lagu.begin();

            playlist[nama_playlist][x.kode]["judul"]=x.judul;
            playlist[nama_playlist][x.kode]["artist"]=x.artist;
            file << playlist.dump(4);
        }
    }
    file.close();
}

void Playlist::hapus_lagu(const std::string& nama_playlist,const std::string& kode){
    for(Playlist& p:semuaPlaylist){
        if(p.nama==nama_playlist){
            for (auto it = p.lagu.begin(); it != p.lagu.end(); ++it) {
            if (it->kode == kode) {

                if (it == p.current) {
                    p.current = (std::next(it) != p.lagu.end())
                            ? std::next(it)   
                            : p.lagu.begin();   
                }

                p.lagu.erase(it);  

                playlist[nama_playlist].erase(kode);
                std::ofstream file("daftar_playlist.json");
                file << playlist.dump(4);
                file.close();
                return;
                }
            }
        }
    }
}

song* Playlist::sekarang(){
    if(lagu.empty()||current==lagu.end()) return nullptr;
    return &(*current);
}

song* Playlist::next(){
    if(lagu.empty()) return nullptr;

    ++current;
    if(current == lagu.end()) current=lagu.begin();
    return &(*current);
}

song* Playlist::prev(){
    if(lagu.empty()) return nullptr;

    if(current == lagu.begin()) current=lagu.end();
    --current;
    return &(*current);
}