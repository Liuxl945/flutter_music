

class CreateSong {
  static Map createSong(musicData){
    return {
      'id': musicData['songid'],
      'mid': musicData['songmid'],
      'singer':fillterSinger(musicData['singer']),
      'album':musicData['albumname'],
      'dration':musicData['interval'],
      'name':musicData['songname'],
      'image':'http://y.gtimg.cn/music/photo_new/T002R300x300M000${musicData['albummid']}.jpg?max_age=2592000',
      'url':'http://ws.stream.qqmusic.qq.com/${musicData['songid']}.m4a?fromtag=46'
    };
  }


  static String fillterSinger(List singer){
    final ret = [];
    if(singer == null){
      return '';
    }
    singer.forEach((s) => ret.add(s['name']));
    return ret.join('/');
  }
}



