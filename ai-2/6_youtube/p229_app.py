import yt_dlp

def get_youtube_video_info(video_url):
    ydl_opts = {
        'cookies' : './data/cookies.txt',
        'noplaylist': True,
        'quiet': True,
        'no_warnings':True
    }
    
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        video_info = ydl.extract_info(video_url, download=False)
        video_id = video_info.get('id')
        title = video_info.get('title')
        upload_date = video_info.get('upload_date')
        channel = video_info.get('channel')
        duration = video_info.get('duration_string')
        
    return video_id, title, upload_date, channel, duration

video_url = 'https://www.youtube.com/watch?v=pSJrML-TTmI'
print(get_youtube_video_info(video_url))