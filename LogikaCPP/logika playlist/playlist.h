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
    public:
    Playlist();

    void tambah(std::string& kode);
    void hapus(std::string& kode);

    song* next();
    song* prev();
    song* sekarang();
    const std::list<song>& getAll() const;

    std::list<song>playlist;
    std::list<song>::iterator current;
    json bank;
    json data_playlist;

    void load();
};