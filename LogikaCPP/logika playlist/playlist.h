#pragma once
#include <string>
#include <list>
#include "json.hpp"
using json = nlohmann::json;

struct song{
    std::string kode;
    std::string judul;
    std::string artist;
};

class Playlist{
    private:
    std::list<song>lagu;
    std::list<song>::iterator current;
    json bank;
    json playlist;

    public:
    std::string nama;
    Playlist(const std::string& nama);

    void tambah_lagu(const std::string& nama,const song& x);
    void hapus_lagu(const std::string& nama,const std::string& kode);
    void tambah_playlist(const std::string& nama);

    song* next();
    song* prev();
    song* sekarang();
    
    void tampil() const;
    int Size() const;

    const std::list<song>& getAll() const {return lagu;}
};