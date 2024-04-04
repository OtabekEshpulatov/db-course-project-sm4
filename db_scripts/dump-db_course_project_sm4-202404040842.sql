--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-04-04 08:42:47

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 76662)
-- Name: denormalized_model; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA denormalized_model;


ALTER SCHEMA denormalized_model OWNER TO postgres;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 242 (class 1255 OID 50722)
-- Name: random_string(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.random_string(length integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
    chars  text[]  := '{0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z}';
    result text    := '';
    i      integer := 0;
begin
    if length < 0 then
        raise exception 'Given length cannot be less than 0';
    end if;
    for i in 1..length
        loop
            result := result || chars[1 + random() * (array_length(chars, 1) - 1)];
        end loop;
    return result;
end;
$$;


ALTER FUNCTION public.random_string(length integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 76684)
-- Name: albums; Type: TABLE; Schema: denormalized_model; Owner: postgres
--

CREATE TABLE denormalized_model.albums (
    album_id character varying(255) NOT NULL,
    album_name character varying(255)
);


ALTER TABLE denormalized_model.albums OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 76670)
-- Name: artists; Type: TABLE; Schema: denormalized_model; Owner: postgres
--

CREATE TABLE denormalized_model.artists (
    artist_id character varying(255) NOT NULL,
    artist_name character varying(255),
    genre_id character varying(255),
    artist_popularity integer
);


ALTER TABLE denormalized_model.artists OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 76691)
-- Name: genres; Type: TABLE; Schema: denormalized_model; Owner: postgres
--

CREATE TABLE denormalized_model.genres (
    genre_id character varying(255) NOT NULL,
    genre_name character varying(255)
);


ALTER TABLE denormalized_model.genres OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 76677)
-- Name: playlists; Type: TABLE; Schema: denormalized_model; Owner: postgres
--

CREATE TABLE denormalized_model.playlists (
    playlist_id character varying(255) NOT NULL,
    playlist_url character varying(255),
    year_ integer
);


ALTER TABLE denormalized_model.playlists OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 76663)
-- Name: tracks; Type: TABLE; Schema: denormalized_model; Owner: postgres
--

CREATE TABLE denormalized_model.tracks (
    track_id character varying(255) NOT NULL,
    track_name character varying(255),
    track_popularity integer,
    album_id character varying(255),
    artist_id character varying(255),
    playlist_id character varying(255),
    duration_ms integer,
    time_signature integer,
    danceability double precision,
    energy double precision,
    key_ integer,
    loudness double precision,
    mode_ integer,
    speechiness double precision,
    acousticness double precision,
    instrumentalness double precision,
    liveness double precision,
    valence double precision,
    tempo double precision
);


ALTER TABLE denormalized_model.tracks OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 75942)
-- Name: album_tracks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.album_tracks (
    album_id character varying(255) NOT NULL,
    track_id character varying(255) NOT NULL
);


ALTER TABLE public.album_tracks OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 75918)
-- Name: albums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.albums (
    album_id character varying(255) NOT NULL,
    album_name character varying(255)
);


ALTER TABLE public.albums OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 75925)
-- Name: artist_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artist_genres (
    artist_id character varying(255) NOT NULL,
    genre_id character varying(255) NOT NULL
);


ALTER TABLE public.artist_genres OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 75887)
-- Name: artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artists (
    artist_id character varying(255) NOT NULL,
    artist_name character varying(255),
    artist_popularity integer
);


ALTER TABLE public.artists OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 75911)
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genre_id character varying(255) NOT NULL,
    genre_name character varying(255)
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 75894)
-- Name: playlist_tracks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlist_tracks (
    playlist_id character varying(255) NOT NULL,
    track_id character varying(255) NOT NULL
);


ALTER TABLE public.playlist_tracks OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 75873)
-- Name: playlists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlists (
    playlist_id character varying(255) NOT NULL,
    year_ integer,
    playlist_url character varying(255)
);


ALTER TABLE public.playlists OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16441)
-- Name: playlists_data; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playlists_data (
    playlist_url character varying(255),
    year_ integer,
    track_id character varying(255),
    track_name character varying(255),
    track_popularity integer,
    album character varying(255),
    artist_id character varying(255),
    artist_name character varying(255),
    artist_genres character varying(255),
    artist_popularity integer,
    danceability double precision,
    energy double precision,
    key_ integer,
    loudness double precision,
    mode_ integer,
    speechiness double precision,
    acousticness double precision,
    instrumentalness double precision,
    liveness double precision,
    valence double precision,
    tempo double precision,
    duration_ms integer,
    time_signature integer
);


ALTER TABLE public.playlists_data OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 75959)
-- Name: track_artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.track_artists (
    track_id character varying(255) NOT NULL,
    artist_id character varying(255) NOT NULL
);


ALTER TABLE public.track_artists OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 75880)
-- Name: tracks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracks (
    track_id character varying(255) NOT NULL,
    track_name character varying(255),
    track_popularity integer,
    key_ integer,
    duration_ms integer,
    time_signature integer,
    danceability double precision,
    energy double precision,
    loudness double precision,
    mode_ integer,
    speechiness double precision,
    liveness double precision,
    valence double precision,
    tempo double precision,
    instrumentalness double precision,
    acousticness double precision
);


ALTER TABLE public.tracks OWNER TO postgres;

--
-- TOC entry 4887 (class 0 OID 76684)
-- Dependencies: 229
-- Data for Name: albums; Type: TABLE DATA; Schema: denormalized_model; Owner: postgres
--

COPY denormalized_model.albums (album_id, album_name) FROM stdin;
O7yCVxgo6ZfGREbFS1owST	#willpower (Deluxe)
KQ9WFNuwGmFvDDXd0dPzWu	Dreamland (+ Bonus Levels)
TjvgMoPjZK5Tm3xmZTAqXD	Raymond v Raymond (Expanded Edition)
kfT5U5CGtZvPjdGRckVWRT	Gangnam Style
afIxZZuQBEov6r847Gzr32	No More Idols
EJGs08wTDIlOEu3UQxrAyq	Silhouettes
kBVviPYomJId6YL7O3WFXn	THE ANXIETY
rxJaVhmhN5Bo8yNPAvqTYp	Won't Go Quietly
I9Co1JiseRX08xDrLMmMhK	I'll Be There
GDJWkBS3fxHHWvGajeXf8L	AM
OhyCRR8AAeIniOkxEEUChH	Purpose (Deluxe)
lzdr4hJer1Ofl7x9Vg8F5Z	Science & Faith
jsitC3iDAYkJ7IOglTFvC5	More
O1ngSY5PZKltRIjq8odNfd	BORN PINK
B4faG1yY2t5b3Uinq4kfqv	This Is What You Came For
eqky6vmVnM4IOXObHs1FHG	The 2nd Law
UOLEFHUQ1b8gl5AjQdbdJQ	The Days / Nights
PfGnntldazb9OUI3emzkUE	Speak Now
w8zab6XjGbjPkPxAMo5mM9	Late Nights: The Album
K941V577nQ3yxGOssbbV50	Happiness Begins
8xjeSVf4DCcxe7BasZB4FL	beerbongs & bentleys
mlRlxxucEEcTn8Zkwfj5a2	MONTERO
K2JLq6nAkDEcpPGthcfpF2	Ugly is Beautiful: Shorter, Thicker & Uglier (Deluxe)
yz7aUB4fNV1SdBHPocNiEN	Ghost Stories
FUcQ40iN1mBIRMBTDdATqW	Easy On Me
m7UhQ0V2gnLNUouSGZuaJQ	Animal (Expanded Edition)
QGEQ3t5p8mPcQJJDRjq8Si	Wherever You Will Go
XH35ObLD4cAnI1dGxRXQAx	Sorry For Party Rocking
JkA4nuYwDW1nyZjqdbicXh	The Incredible Machine
tg4DjtBHNnTt9f5SVVzCM8	Rainbow
DStNHUtDTTED7mKqcQ59DE	All I Want Is You
vbnRDDwMRARMMjIB2c3Qxx	California 37
5udkiavO1L1Ql71gthvgby	24K Magic
B2exUPK9T5kOL16qwoU2gA	Nothing but the Beat 2.0
Uaxq3DxO6YLhCi9gkbBTK8	Encore
TRgPl4vtsHMa7s6GHBlKUy	Left and Right (Feat. Jung Kook of BTS)
qWl8CEfq2ZgdhdcsLChqSJ	Million Voices
5y2DIj3hRAb4kqukHLlGw6	To Be Loved
D1WK9ih865OnSBzZPvLpVz	Please Excuse Me for Being Antisocial
MrAPjitwjDPsSMKcFaz5wU	Unorthodox Jukebox
2Rl1LsoIrMvYVRhQj9Nsdp	In A Perfect World (Expanded Edition)
14LKOnKDKl4of348SlyER1	TRUE
RIPbjpJVp4LWeFaQwvifUu	Sorry For Party Rocking (Deluxe Version)
qf46gSnCtdiswRzehPxBb9	THE E.N.D. (THE ENERGY NEVER DIES)
05bAUqt1t1ZnwrBSJUOLZT	Norman Fucking Rockwell!
Lx9E3YScDN73wJzMn0VRJe	Divinely Uninspired To A Hellish Extent
MMj6tlEaqaAAtONpeGdLBz	Evolve
ZJY1p5Vyg3rBHCIJ11csYn	Sweet Talker (Deluxe Version)
rDGf6ffcpANtuKNkvKa7xy	Shoot For The Stars Aim For The Moon
feKDSQUbLKICSZJQ8onRnP	Avril Lavigne (Expanded Edition)
qnOpU5ZLOMdPo6rKb2ktK1	The Twilight Saga: Breaking Dawn - Part 1 (Original Motion Picture Soundtrack)
hu8UtKhLXZbnZLB4oXxfuK	Right Place Right Time (Expanded Edition)
Oyhx8KSPSNUpA1Z7Yql4oh	Yours Truly
ui0ZFt8M0HnB9ufuHssm0m	Blinding Lights
pojqEe5KA7rxlrOToGU9Xi	I Decided.
HYjYonlWP1jRVKnUxQTbGb	Pink Venom
itSDqOtn4MS7QnPDDFVe9c	25
ANrsGkxST7pRQWjUDaaK8R	Take Me Home (Expanded Edition)
1Ru5FYEzNIKNM7ByfDjvdT	Ã· (Deluxe)
VG5k6ec1Emeiu3f3H9nDjK	Chapters
1lWEQkbaJXdisnwHwanXTO	Talk That Talk
y5sxQInj8A2fL2FsLtAk4b	Dynamite
fkrdol9gOidN8J4Q4M3nGW	Midnights
jOcM1YXlJMJdBFBZjGOM6A	At Night, Alone.
0eCU9CHjzV0H2px0ykCgCO	Blown Away
EgZyDWbjtqmnjg1xAnaZev	Back from the Edge
CcdOs1XlSziFjLo3GFqT3Q	Donda
hVOZtWaUxalQtToAxoOWPx	Barbra Streisand
yLgwhAFmxOb9Pf54YC18kk	ARDIPITHECUS
wQdosoiodfAqZsij5MWFoj	Summer Of Love
GYFLlFaEjPeTYA67df5YNh	Raised Under Grey Skies (Deluxe)
SSv2vWLpaH8oLYAzORt9Gc	STAY DANGEROUS
GFaFksbZM1HkNLKOcgyOTh	Troubadour
yWvd7fahChwMerfh17getm	Born To Die â€“ Paradise Edition (Special Version)
8m1tZbEnGgBAYJHrD9Z9n9	Panini
RCDfBYhqsIcei29jJ5XUA3	Need to Know
xFh85SC04epawID4MyRnYg	Toosie Slide
Ml5cO85RH0Xl8MbGzsmB1N	Homerun
3mTB6fdrTmBctFwrHxXmF9	Queen Of The Clouds
M62GAHp8DW01MkDVWerlbq	Recovery
5NE7eqCekyTIiv0bU4elX1	Night Shades
hByTd9bAfXmQ93POTJXQTD	Streets Of Gold
lYG8tLZpeVwMxndjxSulDe	Believe (Deluxe Edition)
CtMHnFYKnlLVMZMJrdzvab	Bombs Away
qQrxVMu98SUnQb1GteSarL	Experiment Extended
4gU0hJTbPQuG9gDlYrcqB5	Layers
TSY3wLwOoZ2vxnXtd6XQxm	No.6 Collaborations Project
4mFIBTKIN3ncuY9geXJp31	Watch The Throne
gy2TH09GSEAvAFcPLOLWR6	SR3MM
mBW0t8OTI13cfu6QGgWDpO	Lover
A4oVEYX3Fgepv2NmY2JAVt	21
tX9B1X5tUSe0Vo6ZC1NUwV	Where the Light Is
ScCeg1AcIW2Dqpo8p8sRvA	Settle (Deluxe)
EzIBRHlZVwVdHwVo2sAJWB	Circles
vk68LIqlyOoM0W3tijKxYs	The World From The Side Of The Moon
K4V28eLNYoUklG3KYINEmk	Hurry Up, We're Dreaming
TGcqk3M7RDvxWWYLfZWPW3	In Case You Didn't Know
YEDP2Zao3uyqExotpuQXjt	The Hobbit: The Desolation of Smaug (Original Motion Picture Soundtrack)
y26OjaCm5xGkEllTjqnkI0	Stereo Typical
fbgo2VmM0aYOB59uS5aJWV	18 Months
G4FL3sxSvcGZwWUslg6ReT	WANT (Deluxe)
5WTRyrgd7TcTXUGfut79fO	The Fame Monster (Deluxe Edition)
QKiHO8PXsxZn8zsxZMz9rc	x (Deluxe Edition)
0XH4ou2qfnmx2p3135bars	Don't Let Me Down
TJLNdIPReZFoj2z4xC6jGr	Un Verano Sin Ti
eEemh7JJDWHXLTlGgcIbvr	True Colors
1lqnHSIfwwGuVK6f8tyGVd	Peace Is The Mission (Extended)
RaQUVeRvV9RFNJZMPyisFb	We Love You Tecca
qFcMbu76A6zVBJ0QZynDbs	The Truth About Love
nMjQmVgLliURKSFzs1vACs	The Thrill Of It All (Special Edition)
iAft5A3mX8Y1lxDanCJxZi	Wild Ones
oVY5eQ5EDi1gRZp3cM24Yp	Red Pill Blues (Deluxe)
LotvOKuFl91BpsqnAcFcGl	Teenage Dream: The Complete Confection
vSIUBbUUbiFXLlWQ2a4rH7	After Hours (Deluxe)
9XP31CaBKqVFrfbPVM4GxG	Pink Friday ... Roman Reloaded
81m49NLePQpOCfY4KI7pKJ	reputation
xzVeMt5udwpTLA2CmvTyna	Playing In The Shadows
hi3PywrKYfGVWMVb0hVn6O	About Damn Time
uXAn01sEKucbx8jdYgs5vC	bloom
QPJKhrkNIJjCpuZrCntEBY	Harry's House
1GRaLygoEdn4QrbxgMDqiH	Future History (Deluxe Edition)
1VQu2bCA0syWiEGV1dcDxC	Thousand Miles
lnTkJz46nWCWhpTKoELM2o	First Class
WSx1yfmFnbNWbN4PoDTLNW	Camila
pftRBjrY01ajuOBfy7x7RR	MAMIII
sxxcTaedFrEBsF0BICuFPy	Fortune (Expanded Edition)
mExcmIQRoJ5tbpVA9Ym5y1	Pray for the Wicked
Wwul1C732vLOM3YlQlcMJe	Hoodie SZN
XL4QEuvZTUlmyNigmFPvs3	Fetty Wap (Deluxe)
GoZRTt8NnfK2jxnfqufbUI	Battle Of The Sexes (Deluxe)
h88zi8oQCzrfOeP9OoeGRe	RENAISSANCE
wSZrg2L1j48eG1dGw0hlVq	Paramore
09mA6vMx1zYyUhuvpfv056	The Element Of Freedom
xzGjyw2L7PclvClluKQSrh	Unapologetic (Edited Version)
rEjj5noxgRHDXwN31NOuF9	Views
1emBPKN1KDyxLMFuXfisEe	human
WtKSmRFwq1YGrQymSrqaxp	Hollywood's Bleeding
kjTW4EhTW8g0j9x4KPsPVV	Certified Hitmaker
yzjCXlHQWVSYhI3AF5KBdT	In the Name of Love
cwHApq2OwaJAoHciFR1isS	Kaleidoscope Dream
hsjhvIGhKASPzjxTgMH184	What A Time To Be Alive
Pb4JMl8kOeG4DXDvFsbsFi	INDUSTRY BABY (feat. Jack Harlow)
JLe1XZ7GmA07M1xpmHvyJj	Strange Clouds
5kfmcehxWSzWiVRRjRn3zG	Hounds of Love (2018 Remaster)
Vb3nt9CpuWZr22HGfLHL6y	LP1
mbFXMOi5zNPQSDT5MlhIMM	Only Human (Deluxe)
T7NxzTTggdT3gtq7RbDuVN	FOUR (Deluxe)
I42pCTvXJYF9TJ1jle9uXH	Shock Value II
aVjUrDKgxT8d8DhukT8OaK	Pure Heroine
mioV6HHCbvcUoYxefkOGHc	For You
3i38MFcKyAnvyeIa0I1txv	Electronic Earth (Expanded Edition)
HTZ6iJihPth59V4bcupVGO	Get Lucky (Radio Edit) [feat. Pharrell Williams and Nile Rodgers]
ZEWxHP66vxAahBlDBopew8	Ready (Deluxe)
PS8ZM5J057W6EpoJKKOOQh	The Bones of What You Believe
sXF5w1SSO7BOUBh4oeTXl2	WHEN WE ALL FALL ASLEEP, WHERE DO WE GO?
rJ8rKtBEaM6ZHGwFoNmwhL	Mr. Morale & The Big Steppers
HCRcGt6BUiu9LlC1yfI2M4	THE NIGHTDAY
SXKSIHAEaqcllq4sspQEHI	Handwritten
nB7aI6VhCqpFOcwARgVx95	Cheese
5A42tC20fyhLnN2Q3XvYgE	Whatever
Uhv3IxT8ac793dkZQAjeSh	My Head Is An Animal
pc6ttdC1zPQmFXN6tOp7MP	Picture Show
avHL55XdULYRbi7pc24Uog	V
hQ1DnvWyq9wnE6Og4Uvfr2	Wanted on Voyage (Expanded Edition)
WRAW5S89ol8as3SX1trIYE	MIDDLE CHILD
yeNusMSn44IStFkwLLdTNq	See You Again (feat. Charlie Puth)
6rztDuATqT1hqyHpeulkSI	BREAK MY SOUL
hkmp2IVS5IU4ZbInZC8r8E	Billionaire (feat. Bruno Mars)
zXXgTXKNfU5TFD348hU5wC	Own The Night
C4OHIqLyBufUHm7d8VVytu	Earned It (Fifty Shades Of Grey) [From The "Fifty Shades Of Grey" Soundtrack]
LN38h8kksPxGb9KMfV9dJt	I Love You.
oklCYUa2mBJA3nq2Y2sNDn	Sweetener
jnI1rPljcfCki1mwl68QYc	Narrated For You
DOksD6YNbDUFm4mq9gtSBS	Can't Be Tamed
PcT1EPz4a3KNfY9iSDDLvA	For Your Entertainment
HAcyWGuH1Ch26uRLOPLWbE	Te Felicito
5y0bDXN9bf9tbkd72WZSbB	My House
UBlJ7ZeeAQwPEeiVhTJA7f	Laugh Now Cry Later (feat. Lil Durk)
mSCd3tK6a9A0ZJkn0PNrgt	Electra Heart (Deluxe)
i1a3XP4M9oQdN7YwLyvNbL	Talk Dirty
ItOtP3GqqsZ9hO21w0RKHR	Lift Your Spirit
Yo4CiC2sLfRvSSJKVWj82L	i am > i was
2kxbRH0Uah0OQnltYTwqgZ	Doo-Wops & Hooligans
SKZyDF66bl5uEXFdL14Wq8	Native
fWxzm3LslYwy8VBuuHkON9	Quevedo: Bzrp Music Sessions, Vol. 52
xEJ8tNEmGveY9g9UfKwVct	The Awakening
ImOenLh1uEEejt7GOQp5zW	Mylo Xyloto
WnNBkQMHY0nHaR7xGMXNV2	Don't You Worry Child
9VBwBhONRYmFTjoS84qEIM	Bangerz (Deluxe Version)
exF1qMShRdmaDTdvOVB9BT	Hyperion
7VdQTsonRGH4oe7iTJXX5G	Roses (Imanbek Remix)
jKOw9QREER77NNFxM3aXVR	This Is Me
qzjKn6b9XVF0WShYzSkgAo	I Am Not A Human Being II (Deluxe)
sSFkuXpkDpBZPUlAPdlANZ	Heaven & Hell
rAr0wWEAlhy4j8vNdxOyrw	my future
tkQF4Bcmh9ytLD6b73Jz4Y	7 EP
Veo9OcOWKxRCCTh7pFDKm0	Blurryface
M1PDjVsVPSxjqDYksT9GA3	Monster
hMJi3w7mbPhmDXO4Mllw6b	Here I Am (Deluxe Version)
f4zKlk4yTm8FM2YrgpZBsV	Uptown Special
D76Ubp5dg1VtzpZsenP22g	Shirt
4AZbzBrTKlLO4EwEfYshZP	Bon Iver
k44YnYQDALbUTKnfqrw1Rs	Lift Me Up (From Black Panther: Wakanda Forever - Music From and Inspired By)
LjWfylLxGDRA5VnjhLCBkm	Save Your Tears (Remix)
Us7PErcBOp7KxKMAfAvIkX	We No Speak Americano
6F4SloVvfD5Dc4sMFVmY5M	Never Been Better (Expanded Edition)
DLpnimNWMVvoSVIcZo99vj	Jungle Rules
evNI7LJKF5hsJy1POUwaQS	The Heist
tHapRMl6Sd4dfLdsgKbfs2	Global Warming: Meltdown (Deluxe Version)
XVIxRoUeucGvDOaSkh4ZwZ	Hot Pink
zc2fqZvKJWwaseCGTIHPjD	Walk The Moon
XuPFuHysdMjwv8Iu9568Uc	thank u, next
kPz9RlLEkOgX5mNwkv0BS8	Honestly, Nevermind
a08tldRUjMYfFApgu7tuBt	TAKE TIME
jigQYZRG2pWIkSrpm068jn	Who's That Chick?
emCDmCsjbrH8WC2D3Qm4U7	Tourist History
gSv7qTs8eStrHWORg5hYWq	Black Panther The Album Music From And Inspired By
QNuiqGtNXLsy08bRj50abu	F.A.M.E. (Expanded Edition)
Nrga2Ot6f9oSe0pdN54WaM	Envolver
29sRiZo2KJyxveON9iEUcT	Industry Plant
kA31sEW2pWHlJrIbmojmKa	Fine Line
eqMeD7j7bFidg4DycLuRu1	Long Way Down (Deluxe)
cFB18eEGbRNU8XdoFXtYBY	Doja
7bFiUSt3TpvpzPlt2Nt3cu	Cannibal (Expanded Edition)
SgkHoIMsTYrKlkvWXc3uLT	An Awesome Wave
tLH5k4hITUqa2vMlJ8kqrf	The 20/20 Experience - 2 of 2 (Deluxe)
vadGh32RPfmGgXgVDuvVaA	Unholy (feat. Kim Petras)
PoR7IBAE6GMuTNMWtq4Y2N	Dick (feat. Doja Cat)
ACYbRJ2CwobghFSijBlMbp	Astronaut In The Ocean
HtV5W9zq946ik1fWri27mh	T R A P S O U L
VIFdrPq5rp0E4AMbRsPhNa	Illuminate
HQvngT6gmiHngziPYrggbh	A Head Full of Dreams
LiXuGJE3IZx6wluOIsLmES	Unbroken
ZelCwRi4p9qHEru9QnDCMi	Kiss (Deluxe)
l9RS6OpmaT1fjQghbTNbjb	Mood (feat. iann dior)
gtwdIQz5p2IQRMCNcuPuUZ	Love In The Future (Expanded Edition)
WISE6xmS5ARCPYnk1oYsKk	Gold Dust
RNaK5VPqa1HX4XjqNUxcVf	Kaleidoscope Heart
DDDRgCngHduf4ZcIVgZeiB	Butter
1RBvSmcI9Vb5SZvQxT5EOQ	Chosen
AaMOSu3E3DOhDwTN2UjQeX	Blonde
v858bIrHx2xJn8q67vRS8s	DS4EVER
Wd2zsPWac3xINaibmNl05I	Good Days
35cikXHHKHaFvIalZZonbq	everything i wanted
4SPvfqOkFTrAcl2CW3sTwd	5
Eip5OsdTNeXizV4v6qU72R	Delirium (Deluxe)
ikhmhB4Q9U2EHzwTCGB7tp	Coexist
sm6SW9eXP9ziQSAXxiAdYD	Certified Lover Boy
mo729wukfvVSH2AjaA5CwA	One (Your Name)
OR4ULWr1g3kXH6uOrvpNe1	good kid, m.A.A.d city
vIxSJkLp4IrMoBlkP9YZoB	Eenie Meenie EP
TQVZvYPr9GUjqcv7gIVYew	Grateful
doPGwSUx5FdVcIefJv58SM	Levitating (feat. DaBaby)
F5UM2SnLkH0ySd08KbzhPi	Passion, Pain & Pleasure (Deluxe Version)
WA8Exu53HfVCvGqU1Kz0fr	The Wanted (Special Edition)
1mbH9U7RhYZgALbPOeNd1a	Thank Me Later
QXMrsyu17ghvbLa4hLSdE6	Super Freaky Girl
E3dHnYJCqOd871PkZLV9px	Up All Night
q69nlgYe2EDdf7CZUfwIuy	One Love (Deluxe)
24dEITbt61Jlluhm2IauKp	Bobby Tarantino II
3CQwlqS0IrFyJqsSwmxL9W	abcdefu
CdqGklcc9HWxibcFUI6eOE	Todo De Ti
nuVKfXQ8vbvFRU9eq7qfUf	Night Visions
0C4KIWtMQEPWb6y85RoFRN	Battle Studies
JNAhPOQM69cvaaDsNGkZNt	I Ainâ€™t Worried (Music From The Motion Picture "Top Gun: Maverick")
7um1fHKjXG26KPF4oE6PS9	Save Me, San Francisco (Golden Gate Edition)
9Zp669b3CjPBb7VuSKQrDE	Justice
KDIGkNG694DeELip5VX7JW	Gemini Rights
jdvZsuG3il71XS0eeHJmlE	R.E.D. (Deluxe Edition)
hNMm9cGL2SgdkoeZr0QqAA	Take Care (Deluxe)
F6S5gbLagjHutcSnMyxnbX	Rare
lyh9dhdY7SFvLeiUnkFX2d	folklore
Vm4vNAZPz2gaOgA2AmHGqt	As It Was
KtrCTSJhbbpviHk8XFoJOE	My Love
uyTzUQk55xvwquRlUoHNfc	Lasers
xhC6tcM42ulhDUOtMnT2Tg	Midnight Memories (Deluxe)
uosfX9zpJByYEPgsuzkfH3	Overexposed (Deluxe)
f4FOUbugWrhDPurM39XEwx	ANTI (Deluxe)
RASyPkhsdLDco9RSYEufbo	777
B1l1c1kijmZsKluOBjiLMw	Teatro d'ira - Vol. I
HGWMZZtvNmADnk0XbDW5oB	Mercy
f1GOmd2yu5vAj5n9dOu4Nd	Teenage Dream
9ByWgmy0wGnW83XMMqKIM4	The 20/20 Experience (Deluxe Version)
q9Pj1cGCCbeehT9c9gswKt	Birdy
iQz5Hn5sSVoxaty4ShaRnT	Happier Than Ever
sla8XwqUbMQyNtasS4HQhT	The Band Perry
PcOL2N8jDroVXvlWnEi8fQ	Making Mirrors
kWTu8vPXjhMONiTWqtIfLp	Kid Krow
ApKUCnrZX8mCPqWJDxsDmI	Rated R
aBi3wyQwTCV9uABO9HpEXV	Chapter One
PhWiBZouTZ1ZAo6nQgEDSV	La La La
kh17ptYU8O3m5tIuh6jqh1	Encanto (Original Motion Picture Soundtrack)
C5s9wwJwNyhYWobotXxF4P	Rolling Papers
aN1PmNMxfb9FRNhYouFfu1	Love Is a Four Letter Word (Deluxe Edition)
hKjQPi3h4dYfCusLglkKlF	Sick Boy
Km8FhoBBZYo6BZaG3WP2Zk	Boyfriend
Lbx5pN5KCnnni67Zvkro4u	Here's To The Good Times
ibkYLnbNzNgsJCPKFHjYiJ	Jason Derulo
TgMoI8Qo8RIyKalAghZMeG	X (Expanded Edition)
lfgJolbOPS5xAbW8QoY03w	Because the Internet
mvNJXaToliDuU7NWXOthAO	Random Access Memories
qQOSra1GSEEeF36URg4nTg	SOUR
7CBUtgqTxsm7PP98FuOQlA	Nothing Was The Same
hB611jp9MKsnPtBxlz8hp5	Disc-Overy
F0tBSOBor3SSYUAmEWjZC6	Wiped Out!
tsLRJWilHmItpwLIFUOagH	Come Into My World
7ayKa2UThGp8JRt2ykqMEr	Red (Taylor's Version)
qHyQbijU1HMpmEskyLIHuG	Famous Cryp
HU5rH7TCxDXu3NyGh1HzMV	Dirty Computer
3Dyptw8ES7q2eGB7fTSTnr	I like it when you sleep, for you are so beautiful yet so unaware of it
8MHxceyBSewF52BlJAWvIJ	STAY (with Justin Bieber)
VEkGohaAwJAyKX8U1WFMlp	Oh, What A Life
wGB2kDeEdP4RREJxhSWdDc	Indigo (Extended)
q3kuZ3zSioln50YVrFf0fE	DESPECHÃ
4JqoJTtUn1zmf5kl8lHHJM	Giant (with Rag'n'Bone Man)
JZ5MrfdrNtzLMNSaN9NIwQ	Title (Deluxe)
dmuRZRc6OUKy8J9WSzp3Bu	Reload (Vocal Version / Radio Edit)
rf2DGU6NxaArbeoGLRM9BW	Pink Friday ... Roman Reloaded (Deluxe)
ifAbu3IaL0MPRtSw1xZbox	Rockabye (feat. Sean Paul & Anne-Marie)
HytghV1QSNDuRYJhYFirDG	Lukas Graham
fi1D6XkwhrY3Bu1OHVb35m	Halcyon Nights
mUPVmjivXrykyiqMP0pbRT	nothings ever good enough
sDdieEC8vk3NJZbBnB6pnD	More Life
thOmKbAM1UNqD98AArXlDu	Tell Me I'm Pretty
S9vRTJwSRyAuivIMvRjCed	Hot Girl Summer (feat. Nicki Minaj & Ty Dolla $ign)
Su1n5UP2lqqVL81CSGTK1V	Take The Crown (Deluxe Edition)
2pHMSrxrKZRsxRL40p3vkB	In The Lonely Hour
JBRPlkZhM1kRTwXJ2Q3yYK	Without Me
gAcHi1rckOBp87qNxdeKBf	Blurred Lines
ca3Mrw8kcFXttv6qC7QRIZ	Tha Carter IV (Complete Edition)
mL95zwFFg8UxiryBp35p1p	Party Girl
Y2543SqLZGdiCNRtHLrlix	Brighter Days
fLaEHBY2dgmJqGhAchgL7v	good kid, m.A.A.d city (Deluxe)
Ec8fJT1xN7mY6BkuUVHEiU	Levels
MZbGnPU1lZpfvvBeWJJqQt	PRISM (Deluxe)
L3Z4rmw6iBK2qbromMSbLC	Replay
VaIT9VYZ0c0hLm2peBEgSf	Tribute
ClkHvEHx4OXGFajwkQKdjr	No Brainer
CiEHZKcpR6NJk7VIXi2LKn	Need U (100%) (feat. A*M*E) [Remixes]
bfugUjb4KAemuMqzw5aK4H	We The Best Forever
oMasAYdrJSlv5TzCr84S5O	G I R L
L7FGA7iZNxphb8lrXys1zV	deja vu
T2XVW8W9ytnKghnxrLcYHf	The Kickback
BexOdwGjRBGwRVgbZUrrUq	A Perfect Contradiction (Outsiders' Expanded Edition)
uQ3Mbu3t63W7V6b1EdHi5e	MONTERO (Call Me By Your Name)
RDrHV8poCD11Wu6hoYOKX5	One Day / Reckoning Song (Wankelmut Remix)
ZkppOZInxmljFSbe4EjwwV	Different World
7fPaPtZG8KuFDhUPEoSp7w	EP1
IniTpg8lC2b99Nv8ZGaNQ6	Cheap Thrills (feat. Sean Paul)
79OmYA5dWPLo2AXXliIkjF	Scorpion
VkFPm1RMxdOTrPHZWZrfXi	MKTO
OsFKQGXX5Ro0jXSaocFUCq	Letters (Deluxe Edition)
k7wxWybRpL7gLINXf37xIf	Birds In The Trap Sing McKnight
OrsimaVJJStUp2OmS2BCMx	No Hands (feat. Roscoe Dash & Wale)
DYc82k41IVcP5Yy58r8lsY	VIDA
ZbqVF9MLeVevnhGngRASoK	THIS IS... ICONA POP
eJSJ3m4nmyK3EX8PGoKtuj	Heathens
lX3fgePMdqwd4DETy543Jq	Positions
8Z7m4KPre67LA5c9DfQs4E	High Expectations
g987bkRnnjjYcXDbO1TQ5R	we fell in love in october / October Passed Me By
eXklcDPagskemdr1wixxl8	Sweeter
QjHrUA52omUZepJoiryOAl	Currents
e8YBqPOh3y2MUTpQcPW3LA	Hands All Over (Deluxe)
sT64qB1ytY9VsuVawpLGWm	Night Visions (Deluxe)
3DYhAdvFvIeZ3X9mHs3xvd	B.o.B Presents: The Adventures of Bobby Ray
SIA2OElYUyIfysFudwiyVF	Post to Be (feat. Chris Brown & Jhene Aiko)
1NuTHGjWBPCO7XauMEOp7a	good 4 u
lgT12R1oOMVVfckUZDxY4g	Bad Habits
oNKt8h5YYfQr2klpFMAW22	Born This Way (Special Edition)
9aU6jEovwmNfv0jlsXQaU8	Don't Kill the Magic
g8pIqGxNEDNdK6VlLOUhmH	Some Nights
FgBtlRNFolgC2Ya091tV5H	Free Spirit
rWs8X7tBbjSuw3JUipkXQK	Shawn Mendes (Deluxe)
BgWuuVKTDLGmW1vO6cxZbL	Is There Anybody Out There?
bQHa6CvPPHL5X3FnPqLCa2	Skyfall
7oBsjwjveiVsqbwCQQlm4C	Bangarang EP
yqbRlCgtWdvyC6yivZW1Mt	Glimpse of Us
LENNAEkFWREDdZkPGiC7I7	Last Night On Earth
FSScrD2sBMDenVsRr5yjPV	Motion
ExbrjCkHarShBwLwtPlzGc	In A Tidal Wave Of Mystery (Deluxe Edition)
KEKE2WLyR2k5GP8ESQNHyE	I Need A Doctor
mxygbXBRF9NvDnVjaxNN47	Kiss Me More (feat. SZA)
KQEMNSXft8tqXcD4fRWrCU	DNCE
HSYOaZv3rWMTSSfG1wopcG	Habits & Contradictions
uTK4FATArVi7vVsUkKNcrZ	The Lady Killer
fFKLuyVmwQntfT7wk2vSis	I Don't Mind (feat. Juicy J)
TwfLuc2ppst9FqDxlyqVgI	Closer
xVue1X991JHOWYx2cJNd3b	PROVENZA
9Wt4REtMdHDCq8OxuJztAw	One Kiss (with Dua Lipa)
OZnhY94gp1peCrK8xrLYMC	death bed (coffee for your head)
zVozFPnILLZ0J5sb2QNNGH	The Rokstarr Hits Collection
ZqU1jM3YpUxbB9KnuMvEIq	Tuesday (feat. Danelle Sandoval)
oX5Dgc2qWPZyNIC8prm7FB	Body Talk
q0a6LQWSQyZ48hwtSEPZgk	Euphoria
VZAmsMVpnJpn8YIM5jeJ05	LALISA
5bNA4ljkzVbY4a7COY6boT	positions
pffwrcdv6mYS8kGprm5r2t	Illuminate (Deluxe)
N88lxVcPKBXOzrcCXN3v1g	DAMN.
03Vw0cC606OOtfd9LF0hNF	Hands All Over
7hCVyTtVM8GSd059e3ZFHl	VHS
HGFqAgFZbdLRx2HmhYGTJf	drivers license
tzWujAKTKJjDRvKipmbgQf	A Town Called Paradise (Deluxe)
CtReaEYhkIUiPsT2y1zlph	Leave The Door Open
4Q7yRqnNIg5n7ReHTtMgd4	2010s Hits
SJoqpkBhtP1wMQZajwAdEp	Sweetest Pie
Brk5mVPpW3Ewl2FE20a2Bc	Starboy
aGAA4uuQLhbePEGimlvC2j	LIVING THINGS
qchmZl5JXgYaZbr7fVZcQy	The Lockdown Sessions
OV44y9bc1t3sSenruWbuCM	A Night At The Opera (Deluxe Remastered Version)
gHqFUMY18q4QDyFgfpdOdt	My Everything (Deluxe)
\.


--
-- TOC entry 4885 (class 0 OID 76670)
-- Dependencies: 227
-- Data for Name: artists; Type: TABLE DATA; Schema: denormalized_model; Owner: postgres
--

COPY denormalized_model.artists (artist_id, artist_name, genre_id, artist_popularity) FROM stdin;
085pc2PYOi8bGKj0PNjekA	will.i.am	2LqnIQ8brNKkq5UpYasS3M	71
4yvcSjfu4PC0CYQyLy4wSq	Glass Animals	rk5tGP58hdo4pxkbh8q86J	74
23zg3TcAtWQy7J6upgbUnj	USHER	paHyw6nLLQP1js37lYmvxD	77
2dd5mrQZvg6SmahdgVKDzh	PSY	cSaPAuw3Pbj9YYbPOwC9w1	62
3jNkaOXasoc7RsxdchvEVq	Chase & Status	Caw5218qJm8ANBXTb6oaDx	67
1vCWHaC5f2uS3yhpwWbIA6	Avicii	p347GOssFGeRsh2UDHcz0X	79
64H8UqGLbJFHwKtGxiV8OP	THE ANXIETY	5Yr7onU6UVhG1VSU41Nm4r	57
6Vh6UDWfu9PUSXSzAaB3CW	Example	xJmSkIp1Q4Dl8pDzOfxVDx	56
4ScCswdRlyA23odg9thgIO	Jess Glynne	8h1nry3IY96ZTSOwuHMUZR	70
7Ln80lUS6He07XvHI8qqHH	Arctic Monkeys	lfnwzkeovyEIpy2q0s329x	84
1uNFoZAHBGtllmzznpCI3s	Justin Bieber	wm8hn89gVWDs3sSLr2K7Zu	87
3AQRLZ9PuTAozP28Skbq8V	The Script	2LqnIQ8brNKkq5UpYasS3M	71
41MozSoPIsD1dJM0CLPjZF	BLACKPINK	DcNk8lp9KZ055xRuGYWXXR	83
7CajNmpbOovFoOoasH2HaY	Calvin Harris	DfGFE1USWx7GEiEFiGFsuE	84
12Chz98pHFMPJEknJQMWvI	Muse	AkD0RYLVh3masDRAmNER7a	73
06HL4z0CvFAxyc27GXpf02	Taylor Swift	2LqnIQ8brNKkq5UpYasS3M	100
3KV3p5EY4AvKxOlhGHORLg	Jeremih	Ag6mEJFMRpkqeVkwTpdGdv	71
7gOdHgIoIKoe4i9Tta6qdD	Jonas Brothers	2LqnIQ8brNKkq5UpYasS3M	77
246dkjvS1zLTtiykXe5h60	Post Malone	bUhO3s169C99vASWosayYh	89
7jVv8c5Fj3E9VhNjxT4snq	Lil Nas X	4Bu7iQsKfKCrmqikvXowwd	76
6TLwD7HPWuiOzvXEa3oCNe	Oliver Tree	rPPWJB9c7yAToT7rFpgm2f	72
4gzpq5DPGxSnKTe4SA8HAU	Coldplay	2LqnIQ8brNKkq5UpYasS3M	86
4dpARuHxo51G3z768sgnrY	Adele	2LqnIQ8brNKkq5UpYasS3M	83
6LqNN22kT3074XbTVUrhzX	Kesha	KX8AIg1eUdlOT4NrGhk35P	74
0qk8MxMzgnfFECvDO3cc0X	Charlene Soraia	TE6nPFmStCTQOAlbpYbDc5	39
3sgFRtyBnxXD5ESfmbK4dl	LMFAO	2LqnIQ8brNKkq5UpYasS3M	65
0hYxQe3AK5jBPCr5MumLHD	Sugarland	z98WlS2KpBloy4ohjZZA2G	55
360IAlyVv4PCEVjgyMZrxK	Miguel	paHyw6nLLQP1js37lYmvxD	77
3FUY2gzHeIiaesXtOAdB7A	Train	qy8fE1PrAelfZ29K13ZSEG	71
0du5cEVh5yTK9QJze8zA0C	Bruno Mars	KX8AIg1eUdlOT4NrGhk35P	86
1Cs0zKBU1kc0i8ypK3B9ai	David Guetta	2LqnIQ8brNKkq5UpYasS3M	86
540vIaP2JwjQb9dm3aArA4	DJ Snake	eWamSWFq3Eak5J9dE5SQIF	76
6VuMaDnrHyPL1p4EHjYLi7	Charlie Puth	U2YMYZk71WSt7QDHHl5BMx	80
5fahUm8t5c0GIdeTq0ZaG8	Otto Knows	p347GOssFGeRsh2UDHcz0X	59
1GxkXlMwML1oSg5eLPiAz3	Michael BublÃ©	G6WqxqvB3oEBm7ti8lUvnS	71
757aE44tKEUQEqRuT6GnEB	Roddy Ricch	V7w4ohCNxr1Ddc3hKRHDWw	76
4BxCuXFJrSWGi1KHcVqaU4	Kodaline	WDMAEHHMMKmH3PDpnQVVog	67
1yxSLGMDHlW21z4YXirZDS	Black Eyed Peas	2LqnIQ8brNKkq5UpYasS3M	78
00FQb4jTyendYWaN8pK0wa	Lana Del Rey	2LqnIQ8brNKkq5UpYasS3M	89
4GNC7GD6oZMSxPGyXy4MNB	Lewis Capaldi	8h1nry3IY96ZTSOwuHMUZR	79
53XhwfbYqKCa1cC15pYq2q	Imagine Dragons	nIGGJGaPtlfLiaeQ0DUMhT	86
2gsggkzM5R49q6jpPvazou	Jessie J	2LqnIQ8brNKkq5UpYasS3M	69
0eDvMgVFoNV3TpwtrVCoTj	Pop Smoke	V7w4ohCNxr1Ddc3hKRHDWw	79
0p4nmQO2msCgU4IF37Wi3j	Avril Lavigne	2LqnIQ8brNKkq5UpYasS3M	73
3whuHq0yGx60atvA2RCVRW	Olly Murs	2LqnIQ8brNKkq5UpYasS3M	63
66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	2LqnIQ8brNKkq5UpYasS3M	87
1Xyo4u8uXC1ZmMpatF05PJ	The Weeknd	wm8hn89gVWDs3sSLr2K7Zu	94
0c173mlxpT3dSFRgMO8XPh	Big Sean	V7w4ohCNxr1Ddc3hKRHDWw	75
4AK6F7OLvEQ5QYCBNiQWHq	One Direction	CQFwQ9CVGrmSl7IhgEPJxI	82
6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	2ClyZecLJceYYdLli7c9Pa	87
0B3N0ZINFWvizfa8bKiz4v	James TW	LpC51HwpGMjBuJsqrdk6PC	62
5pKCCKE2ajJHZ9KAiaK11H	Rihanna	8k2RTdUrFX1cbjDsRNERHV	87
3Nrfpe0tUJi4K4DXYWgMUX	BTS	DcNk8lp9KZ055xRuGYWXXR	87
2KsP6tYLJlTBvSUxnwlVWa	Mike Posner	p347GOssFGeRsh2UDHcz0X	68
4xFUf1FHVy696Q1JQZMTRj	Carrie Underwood	n8VMb4nyFdFHY8Zz0ik1uE	70
4IWBUUAFIplrNtaOHcJPRM	James Arthur	8h1nry3IY96ZTSOwuHMUZR	80
5K4W6rqBFWDnAN6FQUkS6x	Kanye West	ITUee9sTXyqtVUFSluX7Xd	89
0q8J3Yj810t5cpAYEJ7gxt	Duck Sauce	MaMDqlKoEEwjYAqLjJQNMm	50
3rWZHrfrsPBxVy692yAIxF	WILLOW	rZCmSCdlE4mdC3rZnkQI8I	69
7n2wHs1TKAczGzO7Dd2rGr	Shawn Mendes	2LqnIQ8brNKkq5UpYasS3M	81
4kYGAK2zu9EAomwj3hXkXy	JP Cooper	8h1nry3IY96ZTSOwuHMUZR	64
0A0FS04o6zMoto8OKPsDwY	YG	MEqeqHl7UI8lyedJMux3Wj	72
7pGyQZx9thVa8GxMBeXscB	K'NAAN	ufaJetRQmV06BtOolWkGQO	59
5cj0lLjcoR7YOSnhnX0Po5	Doja Cat	KX8AIg1eUdlOT4NrGhk35P	86
3TVXtAsR1Inumwj472S9r4	Drake	V7w4ohCNxr1Ddc3hKRHDWw	94
3vQ0GE3mI0dAaxIMYe5g7z	Paulo Londra	7OTFfc8tiNmSCXXbwPg1Yu	74
4NHQUGzhtTLFvgF5SZesLK	Tove Lo	fHr2y58b2e2XiM9tGbGpvQ	72
7dGJo4pcD2V6oG8kP0tJRR	Eminem	V7w4ohCNxr1Ddc3hKRHDWw	88
2aYJ5LAta2ScCdfLhKgZOY	Cobra Starship	rZCmSCdlE4mdC3rZnkQI8I	55
0FWzNDaEu9jdgcYTbcOa4F	3OH!3	KX8AIg1eUdlOT4NrGhk35P	60
6VxCmtR7S3yz4vnzsJqhSV	Sheppard	UrSGGyAt0d2pI5Lh7pnfNC	60
3oSJ7TBVCWMDMiYjXNiCKE	Kane Brown	K5fCj9fHKVxf4ddjn16JB8	72
7keGfmQR4X5w0two1xKZ7d	Kungs	1MmI2gY2e2xo6j1GOwS52A	71
3nFkdlSjzX9mRTtwJOzDYB	JAY-Z	YoRnYuRATplwTA2WHadVjS	82
7iZtZyCzp3LItcw1wtPI3D	Rae Sremmurd	2xqpPLoyyO6rnkbKwtr1WK	70
4ETSs924pXMzjIeD6E9b4u	Surfaces	YUW1dEljdN3HULeSkRiOef	65
6nS5roXSAGhTGr34W6n7Et	Disclosure	1MmI2gY2e2xo6j1GOwS52A	70
4LLpKhyESsyAXpc4laK94U	Mac Miller	V7w4ohCNxr1Ddc3hKRHDWw	81
6p5JxpTc7USNnBnLzctyd4	Phillip Phillips	YfroEA85GouAxakcl98NId	59
63MQldklfxkjYDoUE4Tppz	M83	gRUsub3KAT3LzKfepJ3wxC	69
2ajhZ7EA6Dec0kaWiKCApF	Rizzle Kicks	1Qn6xdLSrQ7FLHkjyU0L4G	49
1HY2Jd0NmPuamShAr6KMms	Lady Gaga	2LqnIQ8brNKkq5UpYasS3M	83
69GGBxA162lTqCwzJG5jLp	The Chainsmokers	olqVcznfeC6c5LCW33m8Ix	78
4q3ewBCX7sLwd24euuV69X	Bad Bunny	ktrk3k6tCTZNNrlISwX5kO	94
2qxJFvFYMEDqd7ui6kSAcq	Zedd	2LqnIQ8brNKkq5UpYasS3M	73
738wLrAtLtCtFOLvQBXOXp	Major Lazer	2LqnIQ8brNKkq5UpYasS3M	73
4Ga1P7PMIsmqEZqhYZQgDo	Lil Tecca	pjblhQJB45QunspXS6ZAOA	76
1KCSPY1glIKqW2TotWuXOR	P!nk	2LqnIQ8brNKkq5UpYasS3M	79
2wY79sveU1sp5g7SokKOiI	Sam Smith	2LqnIQ8brNKkq5UpYasS3M	83
0jnsk9HBra6NMjO2oANoPY	Flo Rida	LQZm0woEpsP2lZtzqyfO3K	76
04gDigrS5kc9YWfZHwBETP	Maroon 5	2LqnIQ8brNKkq5UpYasS3M	83
6jJ0s89eD6GaHleKKya26X	Katy Perry	2LqnIQ8brNKkq5UpYasS3M	82
0hCNtLu0JehylgoiP8L4Gh	Nicki Minaj	V7w4ohCNxr1Ddc3hKRHDWw	86
56oDRnqbIiwx4mymNEv7dS	Lizzo	2LqnIQ8brNKkq5UpYasS3M	74
6TIYQ3jFPwQSRmorSezPxX	Machine Gun Kelly	LQZm0woEpsP2lZtzqyfO3K	75
6KImCVD70vtIoJWnq6nGn3	Harry Styles	2LqnIQ8brNKkq5UpYasS3M	85
07YZf4WDAMNwqr4jfgOZ8y	Jason Derulo	KX8AIg1eUdlOT4NrGhk35P	77
2tIP7SsRs7vjIcLrU85W8J	The Kid LAROI	9cvCd1Hdq7wVO4rypEPeCu	78
2LIk90788K0zvyj2JJVwkJ	Jack Harlow	bNWEjL606f7gSiJdxiC8St	77
4nDoRrQiYLoBzwC5BhVJzF	Camila Cabello	2LqnIQ8brNKkq5UpYasS3M	78
4obzFoKoKRHIphyHzJ35G3	Becky G	ktrk3k6tCTZNNrlISwX5kO	77
7bXgB6jMjp9ATFy66eO08Z	Chris Brown	paHyw6nLLQP1js37lYmvxD	84
20JZFwl6HVl6yg8a4H3ZqK	Panic! At The Disco	2LqnIQ8brNKkq5UpYasS3M	75
31W5EY0aAly4Qieq6OFu6I	A Boogie Wit da Hoodie	pjblhQJB45QunspXS6ZAOA	79
6PXS4YHDkKvl1wkIl4V8DL	Fetty Wap	LQZm0woEpsP2lZtzqyfO3K	68
3ipn9JLAPI5GUEo4y4jcoi	Ludacris	V7w4ohCNxr1Ddc3hKRHDWw	74
6vWDO969PvNqNYHIOW5v0m	BeyoncÃ©	2LqnIQ8brNKkq5UpYasS3M	85
74XFHRwlV6OrjEM0A2NCMF	Paramore	pKhTWOvK3Y6IeyDnci4KDu	77
3DiDSECUqqY1AuBP8qtaIa	Alicia Keys	paHyw6nLLQP1js37lYmvxD	75
7H55rcKCfwqkyDFH9wpKM6	Christina Perri	2LqnIQ8brNKkq5UpYasS3M	69
5zctI4wO9XSKS8XwcnqEHk	Lil Mosey	AhaE5fYg9kfiPHde54Q6tD	67
60d24wfXkVzDSfLS6hyCjZ	Martin Garrix	1MmI2gY2e2xo6j1GOwS52A	74
5ndkK3dpZLKtBklKjxNQwT	B.o.B	zRxPoppovbdFtrtQUZJMDT	71
1aSxMhuvixZ8h9dK9jIDwL	Kate Bush	syBGcuT9jWrPfBa7Vh1AsO	67
5pUo3fmmHT8bhCyHE52hA6	Liam Payne	2LqnIQ8brNKkq5UpYasS3M	61
6ydoSd3N2mwgwBHtF6K7eX	Calum Scott	2LqnIQ8brNKkq5UpYasS3M	74
5Y5TRrQiqgUO4S36tzjIRZ	Timbaland	KX8AIg1eUdlOT4NrGhk35P	75
163tK9Wjr9P9DmM0AVK7lm	Lorde	uGPcY5hn2lMGTL6wmWuN7l	74
0C8ZW7ezQVs4URX5aX7Kqx	Selena Gomez	2LqnIQ8brNKkq5UpYasS3M	83
2feDdbD5araYcm6JhFHHw7	Labrinth	AQJy0cICgcJ7OAwLkr6Mtr	77
4tZwfgrHOc3mvqYlEYSvVi	Daft Punk	nIGGJGaPtlfLiaeQ0DUMhT	79
2iojnBLj0qIMiKPvVhLnsH	Trey Songz	KX8AIg1eUdlOT4NrGhk35P	67
3CjlHNtplJyTf9npxaPl5w	CHVRCHES	iDVo27DQcN9JLSI8enf6vi	61
6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	jnszrK69fmB7DuSbBUYOcz	88
2YZyLoL8N0Wb9xBt1NhZWg	Kendrick Lamar	4BcJaCA3fGBwot6p3xC1Hn	86
28j8lBWDdDSHSSt5oPlsX2	ZHU	YxOOM3R5eecR5nKXaAW0Xz	62
5j4HeCoUlzhfWtjAfM1acR	Stromae	LdVObxEvZiuZuVSXueOZ1P	69
6jTnHxhb6cDCaCu4rdvsQ0	Hot Chelle Rae	CgIfe4pLQAEvcyID6h5Ujr	54
4dwdTW1Lfiq0cM8nBAqIIz	Of Monsters and Men	d51gUfq0plLEythN72HJoH	66
0RpddSzUHfncUWNJXKOsjy	Neon Trees	qy8fE1PrAelfZ29K13ZSEG	63
2ysnwxxNtSgbb9t1m2Ur4j	George Ezra	TE6nPFmStCTQOAlbpYbDc5	72
6l3HvQ5sa6mXTsMTB19rO5	J. Cole	4BcJaCA3fGBwot6p3xC1Hn	84
137W8MRPWKqSmrBGDBFSop	Wiz Khalifa	5x6O4mJLMhXsbI8aUucv2B	79
7o9Nl7K1Al6NNAHX6jn6iG	Travie McCoy	LQZm0woEpsP2lZtzqyfO3K	60
32WkQRZEVKSzVAAYqukAEA	Lady A	n8VMb4nyFdFHY8Zz0ik1uE	65
77SW9BnxLY8rJ0RciFqkHh	The Neighbourhood	whRMEhdeuqs0iaMhxx5Smb	81
5IH6FPUwQTxPSXurCrcIov	Alec Benjamin	IG4smdaVC84wz7gwPOEyG4	74
5YGY8feqx7naU7z4HrwZM6	Miley Cyrus	2LqnIQ8brNKkq5UpYasS3M	85
6prmLEyn4LfHlD9NnXWlf7	Adam Lambert	rZCmSCdlE4mdC3rZnkQI8I	59
0EmeFodog0BfCgMzAIvKQp	Shakira	2LqnIQ8brNKkq5UpYasS3M	85
6CwfuxIqcltXDGjfZsMd9A	MARINA	rk5tGP58hdo4pxkbh8q86J	70
0id62QV2SZZfvBn9xpmuCl	Aloe Blacc	8mNfH1L6k6exhWHFjQdfNo	63
1URnnhqYAYcrqrcwql10ft	21 Savage	V7w4ohCNxr1Ddc3hKRHDWw	88
5Pwc4xIPtQLFEnJriah9YJ	OneRepublic	MJiWVH1dy7BR2XrCZS1Hpj	81
716NhGYqD1jl2wI1Qkgq36	Bizarrap	xQwb2SWGETlHt8ipkkMjVx	83
3LpLGlgRS1IKPPwElnpW35	James Morrison	qy8fE1PrAelfZ29K13ZSEG	60
1h6Cn3P4NGzXbaXidqURXs	Swedish House Mafia	p347GOssFGeRsh2UDHcz0X	74
3hteYQFiMFbJY7wS0xDymP	Gesaffelstein	24fGvv8QRXLovtu5VbP2gy	71
0H39MdGGX6dbnnQPt6NQkZ	SAINt JHN	KlPR5t4cPejE6UYRLskAtg	67
7HV2RI2qNug4EcQqLbCAKS	Keala Settle	WN8qrP0ZGTM6fYVliKUCYH	61
55Aa2cqylxrFIXC767Z865	Lil Wayne	aVqVL6GHgXDeQA4Pq7us70	84
4npEfmQ6YuiwW1GpUmaq3F	Ava Max	2LqnIQ8brNKkq5UpYasS3M	78
3YQKmKGau1PzlVlkL1iodx	Twenty One Pilots	2LqnIQ8brNKkq5UpYasS3M	78
3AuMNF8rQAKOzjYppFNAoB	Kelly Rowland	paHyw6nLLQP1js37lYmvxD	66
3hv9jJF3adDNsBSIQDqcjp	Mark Ronson	8mNfH1L6k6exhWHFjQdfNo	72
7tYKF4w9nC0nq9CsPZTHyP	SZA	2LqnIQ8brNKkq5UpYasS3M	87
4LEiUm1SRbFMgfqnQTwUbQ	Bon Iver	mpui95W8Gpqp9pChPu2Kkw	74
4KkHjCe8ouh8C2P9LPoD4F	Yolanda Be Cool	ovnmTdhAsBPp0XT7dVhu0r	51
6vXTefBL93Dj5IqAWq6OTv	French Montana	V7w4ohCNxr1Ddc3hKRHDWw	72
5BcAKTbp20cv7tC5VqPFoC	Macklemore & Ryan Lewis	gFnsYxq1x22UUZsL9fWUnW	72
0TnOYISbd1XYRBk9myaseg	Pitbull	KX8AIg1eUdlOT4NrGhk35P	81
6DIS6PRrLS3wbnZsf7vYic	WALK THE MOON	Da1EKMQQa8bTR2b82MY7ag	67
4fxd5Ee7UefO4CUXgwJ7IP	Giveon	paHyw6nLLQP1js37lYmvxD	75
536BYVgOnRky0xjsPT96zl	Two Door Cinema Club	whRMEhdeuqs0iaMhxx5Smb	67
7FNnA9vBm6EKceENgCGRMb	Anitta	hCgKRkQTDZo2XHydo4eeOm	76
6ASri4ePR7RlsvIQgWPJpS	iann dior	pjblhQJB45QunspXS6ZAOA	70
2txHhyCwHjUEpJjWrEyqyX	Tom Odell	xJL83wL7lphcryKvMy8DWS	73
5H4yInM5zmHqpKIoMNAx4r	Central Cee	o9GycCqBH9WmBqxLQBg3PA	82
3XHO7cRUPCLOr6jwp8vsx5	alt-J	iDVo27DQcN9JLSI8enf6vi	68
31TPClRtHm23RisEBtV3X7	Justin Timberlake	2LqnIQ8brNKkq5UpYasS3M	78
2WgfkM8S11vg4kxLgDY3F5	StarBoi3	EcsffyRILA6Ne7rauVMZLa	50
1uU7g3DNSbsu0QjSEqZtEd	Masked Wolf	9cvCd1Hdq7wVO4rypEPeCu	64
2EMAnMvWE2eb56ToJVfCWs	Bryson Tiller	V7w4ohCNxr1Ddc3hKRHDWw	77
6S2OmqARrzebs0tKUEyXyp	Demi Lovato	rZCmSCdlE4mdC3rZnkQI8I	77
6sFIWsNpZYqfjUpaCgueju	Carly Rae Jepsen	2LqnIQ8brNKkq5UpYasS3M	72
6fWVd57NKTalqvmjRd2t8Z	24kGoldn	62G7OOtJTRdi1PryEXZShG	70
5y2Xq6xcjJb2jVM54GHK3t	John Legend	RKGu0xs9uJF1u5W1psoj23	73
6r20qOqY7qDWI0PPTxVMlC	DJ Fresh	xJmSkIp1Q4Dl8pDzOfxVDx	55
2Sqr0DXoaYABbjBo9HaMkM	Sara Bareilles	rFBROMeUWoNfNR6AwyhO2N	63
0lAWpj5szCSwM4rUMHYmrr	MÃ¥neskin	2LqnIQ8brNKkq5UpYasS3M	78
2h93pZq0e7k5yf4dywlkpM	Frank Ocean	RKGu0xs9uJF1u5W1psoj23	82
2hlmm7s2ICUX0LVIhVFlZQ	Gunna	pjblhQJB45QunspXS6ZAOA	84
2gBjLmx6zQnFGQJCAQpRgw	Nelly	8TjGGi59AnSWHKHUF6Y2GS	73
0X2BH1fck6amBIoJhDVmmJ	Ellie Goulding	8h1nry3IY96ZTSOwuHMUZR	78
3iOvXCl6edW5Um0fXEBRXy	The xx	g75PC7NSeFauMtdsPtkiby	64
6S0dmVVn4udvppDhZIWxCr	Sean Kingston	uSZJVdMWfFSEGkfcmUTnn2	68
0QHgL1lAIqAw0HtD7YldmP	DJ Khaled	GlCMRz71ZgklFN1OnobcXU	74
6M2wZ9GZgrQXHCFfjv46we	Dua Lipa	2LqnIQ8brNKkq5UpYasS3M	86
2NhdGz9EDv2FeUw6udu2g1	The Wanted	2LqnIQ8brNKkq5UpYasS3M	63
4xRYI6VqpkE3UwrDrAZL8L	Logic	GlCMRz71ZgklFN1OnobcXU	73
2VSHKHBTiXWplO8lxcnUC9	GAYLE	5Yr7onU6UVhG1VSU41Nm4r	65
1mcTU81TzQhprhouKaTkpq	Rauw Alejandro	ktrk3k6tCTZNNrlISwX5kO	87
0hEurMDQu99nJRq8pTxO14	John Mayer	1esd4m69Iex1apATbeolIi	75
57vWImR43h4CaDao012Ofp	Steve Lacy	OeQbml10ezBXw9Odwqv66c	79
21E3waRsmPlU7jZsS13rcj	Ne-Yo	2LqnIQ8brNKkq5UpYasS3M	77
1dgdvbogmctybPrGEcnYf6	Route 94	PXAZ3FP5VbdGWFE9pjGVlG	55
01QTIT5P1pFP3QnnFSdsJf	Lupe Fiasco	MEqeqHl7UI8lyedJMux3Wj	64
3MdXrJWsbVzdn6fe5JYkSQ	Latto	E5O6sd9pNHsoIo8A9iZ0fV	85
2WX2uTcsvV5OnS0inACecP	Birdy	qy8fE1PrAelfZ29K13ZSEG	68
75FnCoo4FBxH5K1Rrx0k5A	The Band Perry	n8VMb4nyFdFHY8Zz0ik1uE	54
2AsusXITU8P25dlRNhcAbG	Gotye	1PMfLOqFsvN8tSveICzhNJ	65
4Uc8Dsxct0oMqx0P6i60ea	Conan Gray	5R5IjnVj1CD9OQutNosuKN	77
7nDsS0l5ZAzMedVRKPP8F1	Ella Henderson	KX8AIg1eUdlOT4NrGhk35P	72
1bT7m67vi78r2oqvxrP3X5	Naughty Boy	81ZV6b2eZnjKGZts41CQsW	58
29PgYEggDV3cDP9QYTogwv	Carolina GaitÃ¡n - La Gaita	ukfygj1uRINXFakBs6xQ54	56
4phGZZrJZRo4ElhRtViYdl	Jason Mraz	qy8fE1PrAelfZ29K13ZSEG	71
2W8yFh0Ga6Yf3jiayVxwkE	Dove Cameron	2LqnIQ8brNKkq5UpYasS3M	69
3b8QkneNDz4JHKKKlLgYZg	Florida Georgia Line	GcU1XuaOaeMu1kVMAphgXN	73
73sIBHcqh3Z3NyqHKZ7FOL	Childish Gambino	GlCMRz71ZgklFN1OnobcXU	77
1McMsnEElThX1knmY4oliG	Olivia Rodrigo	2LqnIQ8brNKkq5UpYasS3M	85
0Tob4H0FLtEONHU1MjpUEp	Tinie Tempah	KX8AIg1eUdlOT4NrGhk35P	64
0BmLNz4nSLfoWYW1cYsElL	Alexandra Stan	HjEUIly1GABqcA3Zpn73vD	59
3Fl1V19tmjt57oBdxXKAjJ	Blueface	62G7OOtJTRdi1PryEXZShG	65
6ueGR6SWhUJfvEhqkvMsVs	Janelle MonÃ¡e	zRxPoppovbdFtrtQUZJMDT	67
3mIj9lX2MWuHmhNCA7LSCW	The 1975	nIGGJGaPtlfLiaeQ0DUMhT	75
0MlOPi3zIDMVrfA9R04Fe3	American Authors	Da1EKMQQa8bTR2b82MY7ag	64
7ltDVBr6mKbRvohxheJ9h1	ROSALÃA	Na6i9qIZwUBjh0Ov9tLFw7	81
6JL8zeS1NmiOftqZTRgdTz	Meghan Trainor	2LqnIQ8brNKkq5UpYasS3M	75
6hyMWrxGBsOx6sWcVj1DqP	Sebastian Ingrosso	1MmI2gY2e2xo6j1GOwS52A	60
6MDME20pz9RveH9rEXvrOM	Clean Bandit	xJmSkIp1Q4Dl8pDzOfxVDx	72
25u4wHJWxCA9vO0CzxAbK7	Lukas Graham	LNGQsYWJ5Dx7TzYpr6M0gZ	69
26T3LtbuGT1Fu9m0eRq5X3	Cage The Elephant	whRMEhdeuqs0iaMhxx5Smb	71
181bsRPaVXVlUKXrxwZfHK	Megan Thee Stallion	2LqnIQ8brNKkq5UpYasS3M	75
2HcwFjNelS49kFbfvMxQYw	Robbie Williams	2wkHFHGy2fJvAzKS8ppqgL	69
26VFTg2z8YR0cCuwLzESi2	Halsey	olqVcznfeC6c5LCW33m8Ix	80
0ZrpamOxcZybMHGg1AYtHP	Robin Thicke	KX8AIg1eUdlOT4NrGhk35P	61
1XLWox9w1Yvbodui0SRhUQ	StaySolidRocky	pjblhQJB45QunspXS6ZAOA	57
1IueXOQyABrMOprrzwQJWN	Sigala	xJmSkIp1Q4Dl8pDzOfxVDx	69
5tKXB9uuebKE34yowVaU3C	Iyaz	rZCmSCdlE4mdC3rZnkQI8I	63
34v5MVKeQnIo0CWYMbbrPf	John Newman	KX8AIg1eUdlOT4NrGhk35P	67
61lyPtntblHJvA7FMMhi7E	Duke Dumont	PXAZ3FP5VbdGWFE9pjGVlG	63
2RdwBSPQiwcmiDo9kixcl8	Pharrell Williams	KX8AIg1eUdlOT4NrGhk35P	77
1EeArivTpzLNCqubV95255	Cali Swag District	LQZm0woEpsP2lZtzqyfO3K	49
4fwuXg6XQHfdlOdmw36OHa	Paloma Faith	12XRUtBZVdLgcba8y2Be0o	65
7t51dSX8ZkKC7VoKRd0lME	Asaf Avidan	evoqUqYGvypPFnAVgc8Ehb	56
7vk5e3vY1uw9plTHJAMwjN	Alan Walker	YxOOM3R5eecR5nKXaAW0Xz	79
5WUlDfRSoLAfcVSX1WnrxN	Sia	5wqS8b6SV9Y7XcLuJNFjpg	81
2l35CQqtYRh3d8ZIiBep4v	MKTO	rZCmSCdlE4mdC3rZnkQI8I	64
3906URNmNa1VCXEeiJ3DSH	Matt Cardle	E5t7R5wCxfwLPsV2bBh4Au	29
0Y5tJX1MQlPlqiwlOH1tJY	Travis Scott	KlPR5t4cPejE6UYRLskAtg	93
6f4XkbvYlXMH0QgVRzW0sM	Waka Flocka Flame	LQZm0woEpsP2lZtzqyfO3K	64
4V8Sr092TqfHkfAA5fXXqG	Luis Fonsi	61Hf3FSCEBZj8KEw66ngAQ	72
1VBflYyxBhnDc9uVib98rw	Icona Pop	WjxdlV5uG0qXEqnazAq6D6	65
1MIVXf74SZHmTIp4V4paH4	Mabel	8h1nry3IY96ZTSOwuHMUZR	65
3uwAm6vQy7kWPS2bciKWx9	girl in red	rk5tGP58hdo4pxkbh8q86J	72
5DYAABs8rkY9VhwtENoQCz	Gavin DeGraw	qy8fE1PrAelfZ29K13ZSEG	59
5INjqkS1o8h1imAzPqGZBb	Tame Impala	Da1EKMQQa8bTR2b82MY7ag	78
0f5nVCcR06GX8Qikz0COtT	Omarion	KX8AIg1eUdlOT4NrGhk35P	59
0DxeaLnv6SyYk2DOqkLO8c	MAGIC!	2LqnIQ8brNKkq5UpYasS3M	65
5nCi3BB41mBaMH9gfr6Su0	fun.	FS3g1jguh01C3PFkxEDLIK	65
6LuN9FCkKOj5PcnpouEgny	Khalid	DinotCxIRVhJe6W4CDECJi	82
5xKp3UyavIBUsGy3DQdXeF	A Great Big World	qy8fE1PrAelfZ29K13ZSEG	59
5he5w2lnU9x7JFhnwcekXX	Skrillex	7qOyvybcAUPfPJt4DD9cQT	75
3MZsBdqDrRTJihTHQrO6Dq	Joji	U2YMYZk71WSt7QDHHl5BMx	79
0aeLcja6hKzb7Uz2ou7ulP	Noah And The Whale	d51gUfq0plLEythN72HJoH	49
4gwpcMTbLWtBUlOijbVpuu	Capital Cities	uGPcY5hn2lMGTL6wmWuN7l	64
6DPYiyq5kWVQS4RGwxzPC7	Dr. Dre	V7w4ohCNxr1Ddc3hKRHDWw	78
6T5tfhQCknKG4UnH90qGnz	DNCE	2LqnIQ8brNKkq5UpYasS3M	67
5IcR3N7QB1j6KBL8eImZ8m	ScHoolboy Q	5x6O4mJLMhXsbI8aUucv2B	70
5nLYd9ST4Cnwy6NHaCxbj8	CeeLo Green	zRxPoppovbdFtrtQUZJMDT	63
790FomKkXshlbRYZFtlgla	KAROL G	9w3uqSLrhbvdSfLQ57uLuU	90
6bmlMHgSheBauioMgKv2tn	Powfu	34YJrUJWsk5DlJx1LC4gF3	67
6MF9fzBmfXghAz953czmBC	Taio Cruz	LQZm0woEpsP2lZtzqyfO3K	67
4ON1ruy5ijE7ZPQthbrkgI	Burak Yeter	YxOOM3R5eecR5nKXaAW0Xz	55
6UE7nl9mha6s8z0wFQFIZ2	Robyn	fHr2y58b2e2XiM9tGbGpvQ	58
7qG3b048QCHVRO5Pv1T5lw	Enrique Iglesias	KX8AIg1eUdlOT4NrGhk35P	75
5L1lO4eRHmJ7a0Q6csE5cT	LISA	DcNk8lp9KZ055xRuGYWXXR	77
3NPpFNZtSTHheNBaWC82rB	X Ambassadors	UU8QVhTYWa1uxpC479zrDd	69
2o5jDhtHVPhrJdv3cEQ99Z	TiÃ«sto	PXAZ3FP5VbdGWFE9pjGVlG	82
6XyY86QOPPrYVGvF9ch6wz	Linkin Park	6Tvm7rH1PZAbcPbdSKK0AG	83
3PhoLpVuITZKcymswpck5b	Elton John	NQeLsgsYpwYBX4aApn5Upx	81
1dfeR4HaWDbWqFHLkxsg1d	Queen	ZB3H6hTaQPKi1pfxVvOebG	82
\.


--
-- TOC entry 4888 (class 0 OID 76691)
-- Dependencies: 230
-- Data for Name: genres; Type: TABLE DATA; Schema: denormalized_model; Owner: postgres
--

COPY denormalized_model.genres (genre_id, genre_name) FROM stdin;
2LqnIQ8brNKkq5UpYasS3M	pop
rk5tGP58hdo4pxkbh8q86J	pov: indie
paHyw6nLLQP1js37lYmvxD	r&b
cSaPAuw3Pbj9YYbPOwC9w1	k-rap
Caw5218qJm8ANBXTb6oaDx	drum and bass
p347GOssFGeRsh2UDHcz0X	pop dance
5Yr7onU6UVhG1VSU41Nm4r	modern alternative pop
xJmSkIp1Q4Dl8pDzOfxVDx	uk dance
8h1nry3IY96ZTSOwuHMUZR	uk pop
lfnwzkeovyEIpy2q0s329x	sheffield indie
wm8hn89gVWDs3sSLr2K7Zu	canadian pop
pA6b3IJ3XfGvlhbFms2vpW	contemporary r&b
DcNk8lp9KZ055xRuGYWXXR	k-pop
DfGFE1USWx7GEiEFiGFsuE	progressive house
AkD0RYLVh3masDRAmNER7a	permanent wave
1MmI2gY2e2xo6j1GOwS52A	edm
Ag6mEJFMRpkqeVkwTpdGdv	urban contemporary
bUhO3s169C99vASWosayYh	dfw rap
4Bu7iQsKfKCrmqikvXowwd	lgbtq+ hip hop
rPPWJB9c7yAToT7rFpgm2f	alternative hip hop
KX8AIg1eUdlOT4NrGhk35P	dance pop
TE6nPFmStCTQOAlbpYbDc5	neo-singer-songwriter
z98WlS2KpBloy4ohjZZA2G	country dawn
qy8fE1PrAelfZ29K13ZSEG	neo mellow
eWamSWFq3Eak5J9dE5SQIF	electronic trap
U2YMYZk71WSt7QDHHl5BMx	viral pop
G6WqxqvB3oEBm7ti8lUvnS	lounge
V7w4ohCNxr1Ddc3hKRHDWw	rap
WDMAEHHMMKmH3PDpnQVVog	irish pop
LQZm0woEpsP2lZtzqyfO3K	pop rap
nIGGJGaPtlfLiaeQ0DUMhT	rock
CQFwQ9CVGrmSl7IhgEPJxI	boy band
2ClyZecLJceYYdLli7c9Pa	singer-songwriter pop
LpC51HwpGMjBuJsqrdk6PC	british singer-songwriter
8k2RTdUrFX1cbjDsRNERHV	barbadian pop
n8VMb4nyFdFHY8Zz0ik1uE	contemporary country
ITUee9sTXyqtVUFSluX7Xd	chicago rap
MaMDqlKoEEwjYAqLjJQNMm	disco house
rZCmSCdlE4mdC3rZnkQI8I	post-teen pop
MEqeqHl7UI8lyedJMux3Wj	southern hip hop
ufaJetRQmV06BtOolWkGQO	reggae fusion
7OTFfc8tiNmSCXXbwPg1Yu	trap argentino
fHr2y58b2e2XiM9tGbGpvQ	swedish pop
UrSGGyAt0d2pI5Lh7pnfNC	australian indie
K5fCj9fHKVxf4ddjn16JB8	country road
YoRnYuRATplwTA2WHadVjS	east coast hip hop
2xqpPLoyyO6rnkbKwtr1WK	mississippi hip hop
YUW1dEljdN3HULeSkRiOef	bedroom soul
YfroEA85GouAxakcl98NId	folk-pop
gRUsub3KAT3LzKfepJ3wxC	french shoegaze
E5t7R5wCxfwLPsV2bBh4Au	talent show
1Qn6xdLSrQ7FLHkjyU0L4G	uk hip hop
olqVcznfeC6c5LCW33m8Ix	electropop
ktrk3k6tCTZNNrlISwX5kO	trap latino
pjblhQJB45QunspXS6ZAOA	melodic rap
PXAZ3FP5VbdGWFE9pjGVlG	house
9cvCd1Hdq7wVO4rypEPeCu	australian hip hop
bNWEjL606f7gSiJdxiC8St	deep underground hip hop
pKhTWOvK3Y6IeyDnci4KDu	pop punk
AhaE5fYg9kfiPHde54Q6tD	rap conscient
zRxPoppovbdFtrtQUZJMDT	atl hip hop
syBGcuT9jWrPfBa7Vh1AsO	art rock
uGPcY5hn2lMGTL6wmWuN7l	metropopolis
AQJy0cICgcJ7OAwLkr6Mtr	indie poptimism
iDVo27DQcN9JLSI8enf6vi	indietronica
jnszrK69fmB7DuSbBUYOcz	art pop
4BcJaCA3fGBwot6p3xC1Hn	conscious hip hop
YxOOM3R5eecR5nKXaAW0Xz	electro house
LdVObxEvZiuZuVSXueOZ1P	belgian pop
CgIfe4pLQAEvcyID6h5Ujr	neon pop punk
d51gUfq0plLEythN72HJoH	stomp and holler
5x6O4mJLMhXsbI8aUucv2B	trap
KV11b7otLS9PvWDLTW8cAQ	canadian contemporary r&b
whRMEhdeuqs0iaMhxx5Smb	modern alternative rock
IG4smdaVC84wz7gwPOEyG4	alt z
8mNfH1L6k6exhWHFjQdfNo	pop soul
MJiWVH1dy7BR2XrCZS1Hpj	piano rock
xQwb2SWGETlHt8ipkkMjVx	pop venezolano
24fGvv8QRXLovtu5VbP2gy	dark clubbing
KlPR5t4cPejE6UYRLskAtg	slap house
WN8qrP0ZGTM6fYVliKUCYH	show tunes
aVqVL6GHgXDeQA4Pq7us70	new orleans rap
mpui95W8Gpqp9pChPu2Kkw	chamber pop
ovnmTdhAsBPp0XT7dVhu0r	australian house
gFnsYxq1x22UUZsL9fWUnW	seattle hip hop
Da1EKMQQa8bTR2b82MY7ag	modern rock
KExNJCTjwIr6n4eWyeg9pe	west coast rap
hCgKRkQTDZo2XHydo4eeOm	funk pop
xJL83wL7lphcryKvMy8DWS	chill pop
o9GycCqBH9WmBqxLQBg3PA	melodic drill
EcsffyRILA6Ne7rauVMZLa	viral rap
odvwbwzsetIHXknwT5HEJP	canadian hip hop
62G7OOtJTRdi1PryEXZShG	cali rap
RKGu0xs9uJF1u5W1psoj23	neo soul
rFBROMeUWoNfNR6AwyhO2N	pop rock
8TjGGi59AnSWHKHUF6Y2GS	st louis rap
g75PC7NSeFauMtdsPtkiby	downtempo
CqvAnCq2v4Q0aMk9ytWTMp	progressive electro house
uSZJVdMWfFSEGkfcmUTnn2	miami hip hop
GlCMRz71ZgklFN1OnobcXU	hip hop
1esd4m69Iex1apATbeolIi	singer-songwriter
OeQbml10ezBXw9Odwqv66c	afrofuturism
E5O6sd9pNHsoIo8A9iZ0fV	trap queen
1PMfLOqFsvN8tSveICzhNJ	australian pop
5R5IjnVj1CD9OQutNosuKN	bedroom pop
81ZV6b2eZnjKGZts41CQsW	uk contemporary r&b
ukfygj1uRINXFakBs6xQ54	movie tunes
GcU1XuaOaeMu1kVMAphgXN	modern country rock
HjEUIly1GABqcA3Zpn73vD	romanian pop
xSyoi3lZsvwVVqvY9CA42l	garage rock
Na6i9qIZwUBjh0Ov9tLFw7	r&b en espanol
VxQtETZVbYFskEUTsdsDKL	hip pop
LNGQsYWJ5Dx7TzYpr6M0gZ	scandipop
2wkHFHGy2fJvAzKS8ppqgL	dance rock
12XRUtBZVdLgcba8y2Be0o	british soul
evoqUqYGvypPFnAVgc8Ehb	israeli rock
5wqS8b6SV9Y7XcLuJNFjpg	australian dance
61Hf3FSCEBZj8KEw66ngAQ	puerto rican pop
WjxdlV5uG0qXEqnazAq6D6	swedish synthpop
9w3uqSLrhbvdSfLQ57uLuU	urbano latino
FS3g1jguh01C3PFkxEDLIK	baroque pop
DinotCxIRVhJe6W4CDECJi	pop r&b
7qOyvybcAUPfPJt4DD9cQT	complextro
34YJrUJWsk5DlJx1LC4gF3	sad rap
UU8QVhTYWa1uxpC479zrDd	stomp pop
6Tvm7rH1PZAbcPbdSKK0AG	rap metal
NQeLsgsYpwYBX4aApn5Upx	mellow gold
ZB3H6hTaQPKi1pfxVvOebG	glam rock
\.


--
-- TOC entry 4886 (class 0 OID 76677)
-- Dependencies: 228
-- Data for Name: playlists; Type: TABLE DATA; Schema: denormalized_model; Owner: postgres
--

COPY denormalized_model.playlists (playlist_id, playlist_url, year_) FROM stdin;
h9t7HfmUClwEKkUc7f34jH	https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013
pZxQbhuIGcA5v4a4eMVxDI	https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022
Z3d7ZvFizjczhqkQnb7RXg	https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010
hYKylhpPiH1VPodagRTNzu	https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012
wOvFE37RYJBq423MAkmUPr	https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011
pcclfKySeZMYGS2V6uxNLn	https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021
Jp4YMIf936KasPLNEymvB3	https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018
dRZrPqTJ2iw75iSpHG7KnI	https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016
9wnrC2T34VLxtL7vdC8hVE	https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015
KUBSaE6ulYu49hAg7vmNAR	https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014
QlNM9gC3Z9AwcKBBdmOIUm	https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019
LgCTGYUwup3J1TSMRyObZA	https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017
ndfd917VUIq2bOQToxPcqS	https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020
\.


--
-- TOC entry 4884 (class 0 OID 76663)
-- Dependencies: 226
-- Data for Name: tracks; Type: TABLE DATA; Schema: denormalized_model; Owner: postgres
--

COPY denormalized_model.tracks (track_id, track_name, track_popularity, album_id, artist_id, playlist_id, duration_ms, time_signature, danceability, energy, key_, loudness, mode_, speechiness, acousticness, instrumentalness, liveness, valence, tempo) FROM stdin;
01TuObJVd7owWchVRuQbQw	#thatPOWER	68	O7yCVxgo6ZfGREbFS1owST	085pc2PYOi8bGKj0PNjekA	h9t7HfmUClwEKkUc7f34jH	279507	4	0.797	0.608	6	-6.096	0	0.0584	0.00112	7.66e-05	0.0748	0.402	127.999
02MWAaffLxlfxAUY7c5dvx	Heat Waves	40	KQ9WFNuwGmFvDDXd0dPzWu	4yvcSjfu4PC0CYQyLy4wSq	pZxQbhuIGcA5v4a4eMVxDI	238805	4	0.761	0.525	11	-6.9	1	0.0944	0.44	6.7e-06	0.0921	0.531	80.87
030OCtLMrljNhp8OWHBWW3	Hey Daddy (Daddy's Home)	67	TjvgMoPjZK5Tm3xmZTAqXD	23zg3TcAtWQy7J6upgbUnj	Z3d7ZvFizjczhqkQnb7RXg	224093	4	0.59	0.698	11	-4.262	1	0.0286	0.000176	0	0.107	0.352	95.975
03UrZgTINDqvnUMbbIMhql	Gangnam Style	76	kfT5U5CGtZvPjdGRckVWRT	2dd5mrQZvg6SmahdgVKDzh	hYKylhpPiH1VPodagRTNzu	219493	4	0.727	0.937	11	-2.871	0	0.286	0.00417	0	0.091	0.749	132.067
04OxTCLGgDKfO0MMA2lcxv	Blind Faith	63	afIxZZuQBEov6r847Gzr32	3jNkaOXasoc7RsxdchvEVq	wOvFE37RYJBq423MAkmUPr	233667	4	0.45	0.846	9	-4.712	0	0.0472	0.00523	0	0.228	0.402	140.042
06h3McKzmxS8Bx58USHiMq	Silhouettes - Original Radio Edit	67	EJGs08wTDIlOEu3UQxrAyq	1vCWHaC5f2uS3yhpwWbIA6	hYKylhpPiH1VPodagRTNzu	211880	4	0.605	0.8	5	-6.235	0	0.0545	0.155	0.0562	0.121	0.836	128.074
07MDkzWARZaLEdKxo6yArG	Meet Me At Our Spot	78	kBVviPYomJId6YL7O3WFXn	64H8UqGLbJFHwKtGxiV8OP	pcclfKySeZMYGS2V6uxNLn	162680	4	0.773	0.47	2	-7.93	1	0.0299	0.0153	0.000193	0.0851	0.399	94.995
07WEDHF2YwVgYuBugi2ECO	Kickstarts	65	rxJaVhmhN5Bo8yNPAvqTYp	6Vh6UDWfu9PUSXSzAaB3CW	Z3d7ZvFizjczhqkQnb7RXg	181827	4	0.61	0.836	5	-4.455	1	0.0573	0.00374	0	0.358	0.657	126.056
083Qf6hn6sFL6xiOHlZUyn	I'll Be There	65	I9Co1JiseRX08xDrLMmMhK	4ScCswdRlyA23odg9thgIO	Jp4YMIf936KasPLNEymvB3	193924	4	0.623	0.851	7	-3.111	1	0.0409	0.0228	0	0.12	0.4	100.063
086myS9r57YsLbJpU0TgK9	Why'd You Only Call Me When You're High?	89	GDJWkBS3fxHHWvGajeXf8L	7Ln80lUS6He07XvHI8qqHH	h9t7HfmUClwEKkUc7f34jH	161124	4	0.691	0.631	2	-6.478	1	0.0368	0.0483	1.13e-05	0.104	0.8	92.004
09CtPGIpYB4BrO8qb1RGsF	Sorry	83	OhyCRR8AAeIniOkxEEUChH	1uNFoZAHBGtllmzznpCI3s	dRZrPqTJ2iw75iSpHG7KnI	200787	4	0.654	0.76	0	-3.669	0	0.045	0.0797	0	0.299	0.41	99.945
09ZcYBGFX16X8GMDrvqQwt	For the First Time	62	lzdr4hJer1Ofl7x9Vg8F5Z	3AQRLZ9PuTAozP28Skbq8V	Z3d7ZvFizjczhqkQnb7RXg	252853	4	0.396	0.629	9	-4.78	1	0.0287	0.0328	0	0.183	0.358	173.794
0aBKFfdyOD1Ttvgv0cfjjJ	More - RedOne Jimmy Joker Remix	72	jsitC3iDAYkJ7IOglTFvC5	23zg3TcAtWQy7J6upgbUnj	wOvFE37RYJBq423MAkmUPr	219987	4	0.551	0.893	7	-2.628	1	0.0543	0.00166	0	0.348	0.794	125.083
0ARKW62l9uWIDYMZTUmJHF	Shut Down	76	O1ngSY5PZKltRIjq8odNfd	41MozSoPIsD1dJM0CLPjZF	pZxQbhuIGcA5v4a4eMVxDI	175889	3	0.82	0.686	0	-5.102	1	0.038	0.00412	0	0.184	0.668	110.058
0azC730Exh71aQlOt9Zj3y	This Is What You Came For	85	B4faG1yY2t5b3Uinq4kfqv	7CajNmpbOovFoOoasH2HaY	dRZrPqTJ2iw75iSpHG7KnI	222160	4	0.631	0.927	9	-2.787	0	0.0332	0.199	0.119	0.148	0.465	123.962
0c4IEciLCDdXEhhKxj4ThA	Madness	70	eqky6vmVnM4IOXObHs1FHG	12Chz98pHFMPJEknJQMWvI	hYKylhpPiH1VPodagRTNzu	281040	4	0.502	0.417	10	-7.665	1	0.0718	0.127	0.00419	0.106	0.218	180.301
0ct6r3EGTcMLPtrXHDvVjc	The Nights	88	UOLEFHUQ1b8gl5AjQdbdJQ	1vCWHaC5f2uS3yhpwWbIA6	9wnrC2T34VLxtL7vdC8hVE	176658	4	0.527	0.835	6	-5.298	1	0.0433	0.0166	0	0.249	0.654	125.983
0dBW6ZsW8skfvoRfgeerBF	Mine	66	PfGnntldazb9OUI3emzkUE	06HL4z0CvFAxyc27GXpf02	Z3d7ZvFizjczhqkQnb7RXg	230707	4	0.624	0.757	7	-2.94	1	0.0296	0.00265	1.87e-06	0.189	0.658	121.07
0Dc7J9VPV4eOInoxUiZrsL	Don't Tell 'Em	75	w8zab6XjGbjPkPxAMo5mM9	3KV3p5EY4AvKxOlhGHORLg	KUBSaE6ulYu49hAg7vmNAR	266840	4	0.856	0.527	2	-5.225	1	0.0997	0.392	0	0.11	0.386	98.052
0DiDStADDVh3SvAsoJAFMk	Only Human	74	K941V577nQ3yxGOssbbV50	7gOdHgIoIKoe4i9Tta6qdD	QlNM9gC3Z9AwcKBBdmOIUm	183000	4	0.795	0.496	0	-5.883	1	0.0722	0.108	0	0.0645	0.874	94.01
0e7ipj03S05BNilyu5bRzt	rockstar (feat. 21 Savage)	86	8xjeSVf4DCcxe7BasZB4FL	246dkjvS1zLTtiykXe5h60	Jp4YMIf936KasPLNEymvB3	218147	4	0.585	0.52	5	-6.136	0	0.0712	0.124	7.01e-05	0.131	0.129	159.801
0e8nrvls4Qqv5Rfa2UhqmO	THATS WHAT I WANT	84	mlRlxxucEEcTn8Zkwfj5a2	7jVv8c5Fj3E9VhNjxT4snq	pZxQbhuIGcA5v4a4eMVxDI	143901	4	0.737	0.846	1	-4.51	0	0.22	0.00614	0	0.0486	0.546	87.981
0eu4C55hL6x29mmeAjytzC	Life Goes On	77	K2JLq6nAkDEcpPGthcfpF2	6TLwD7HPWuiOzvXEa3oCNe	pcclfKySeZMYGS2V6uxNLn	161803	4	0.7	0.49	0	-5.187	1	0.076	0.186	0	0.117	0.569	79.982
0FDzzruyVECATHXKHFs9eJ	A Sky Full of Stars	87	yz7aUB4fNV1SdBHPocNiEN	4gzpq5DPGxSnKTe4SA8HAU	KUBSaE6ulYu49hAg7vmNAR	267867	4	0.545	0.675	6	-6.474	1	0.0279	0.00617	0.00197	0.209	0.162	124.97
0gplL1WMoJ6iYaPgMCL0gX	Easy On Me	84	FUcQ40iN1mBIRMBTDdATqW	4dpARuHxo51G3z768sgnrY	pcclfKySeZMYGS2V6uxNLn	224695	4	0.604	0.366	5	-7.519	1	0.0282	0.578	0	0.133	0.13	141.981
0HPD5WQqrq7wPWR7P7Dw1i	TiK ToK	84	m7UhQ0V2gnLNUouSGZuaJQ	6LqNN22kT3074XbTVUrhzX	Z3d7ZvFizjczhqkQnb7RXg	199693	4	0.755	0.837	2	-2.718	0	0.142	0.0991	0	0.289	0.714	120.028
0IF7bHzCXCZoKNog5vBC4g	Wherever You Will Go	60	QGEQ3t5p8mPcQJJDRjq8Si	0qk8MxMzgnfFECvDO3cc0X	wOvFE37RYJBq423MAkmUPr	197577	4	0.597	0.115	9	-9.217	1	0.0334	0.82	0.000215	0.111	0.128	111.202
0IkKz2J93C94Ei4BvDop7P	Party Rock Anthem	71	XH35ObLD4cAnI1dGxRXQAx	3sgFRtyBnxXD5ESfmbK4dl	wOvFE37RYJBq423MAkmUPr	262173	4	0.75	0.727	5	-4.21	0	0.142	0.0189	0	0.266	0.359	129.993
0JcKdUGNR7zI4jJDLyYXbi	Stuck Like Glue	67	JkA4nuYwDW1nyZjqdbicXh	0hYxQe3AK5jBPCr5MumLHD	Z3d7ZvFizjczhqkQnb7RXg	247587	4	0.702	0.795	1	-4.764	1	0.0568	0.329	0	0.0505	0.836	83.961
0jdny0dhgjUwoIp5GkqEaA	Praying	71	tg4DjtBHNnTt9f5SVVzCM8	6LqNN22kT3074XbTVUrhzX	LgCTGYUwup3J1TSMRyObZA	230267	4	0.543	0.39	10	-7.202	1	0.0322	0.489	0	0.111	0.303	73.415
0JXXNGljqupsJaZsgSbMZV	Sure Thing	89	DStNHUtDTTED7mKqcQ59DE	360IAlyVv4PCEVjgyMZrxK	wOvFE37RYJBq423MAkmUPr	195373	4	0.684	0.607	11	-8.127	0	0.1	0.0267	0.000307	0.191	0.498	81.001
0KAiuUOrLTIkzkpfpn9jb9	Drive By	80	vbnRDDwMRARMMjIB2c3Qxx	3FUY2gzHeIiaesXtOAdB7A	hYKylhpPiH1VPodagRTNzu	195973	4	0.765	0.837	1	-3.113	0	0.032	0.00107	1.06e-05	0.0801	0.721	122.028
0KKkJNfGyhkQ5aFogxQAPU	That's What I Like	88	5udkiavO1L1Ql71gthvgby	0du5cEVh5yTK9QJze8zA0C	LgCTGYUwup3J1TSMRyObZA	206693	4	0.853	0.56	1	-4.961	1	0.0406	0.013	0	0.0944	0.86	134.066
0lHAMNU8RGiIObScrsRgmP	Titanium (feat. Sia)	72	B2exUPK9T5kOL16qwoU2gA	1Cs0zKBU1kc0i8ypK3B9ai	hYKylhpPiH1VPodagRTNzu	245040	4	0.604	0.788	0	-3.673	0	0.103	0.0678	0.153	0.127	0.301	126.06
0lYBSQXN6rCTvUZvg9S0lU	Let Me Love You	86	Uaxq3DxO6YLhCi9gkbBTK8	540vIaP2JwjQb9dm3aArA4	dRZrPqTJ2iw75iSpHG7KnI	205947	4	0.649	0.716	8	-5.371	1	0.0349	0.0863	2.63e-05	0.135	0.163	99.988
0mBP9X2gPCuapvpZ7TGDk3	Left and Right (Feat. Jung Kook of BTS)	81	TRgPl4vtsHMa7s6GHBlKUy	6VuMaDnrHyPL1p4EHjYLi7	pZxQbhuIGcA5v4a4eMVxDI	154487	4	0.881	0.592	2	-4.898	1	0.0324	0.619	1.32e-05	0.0901	0.719	101.058
0MOiv7WTXCqvm89lVCf9C8	Million Voices - Radio Edit	70	qWl8CEfq2ZgdhdcsLChqSJ	5fahUm8t5c0GIdeTq0ZaG8	hYKylhpPiH1VPodagRTNzu	192867	4	0.582	0.894	8	-6.298	1	0.041	0.0022	0.0223	0.0664	0.0694	125.946
0mvkwaZMP2gAy2ApQLtZRv	It's a Beautiful Day	69	5y2DIj3hRAb4kqukHLlGw6	1GxkXlMwML1oSg5eLPiAz3	h9t7HfmUClwEKkUc7f34jH	199267	4	0.532	0.795	1	-3.979	1	0.0358	0.0559	0	0.295	0.78	143.837
0nbXyq5TXYPCO7pr3N8S4I	The Box	83	D1WK9ih865OnSBzZPvLpVz	757aE44tKEUQEqRuT6GnEB	ndfd917VUIq2bOQToxPcqS	196653	4	0.896	0.586	10	-6.687	0	0.0559	0.104	0	0.79	0.642	116.971
0nJW01T7XtvILxQgC5J7Wh	When I Was Your Man	89	MrAPjitwjDPsSMKcFaz5wU	0du5cEVh5yTK9QJze8zA0C	h9t7HfmUClwEKkUc7f34jH	213827	4	0.612	0.28	0	-8.648	1	0.0434	0.932	0	0.088	0.387	72.795
0NlGoUyOJSuSHmngoibVAs	All I Want	82	2Rl1LsoIrMvYVRhQj9Nsdp	4BxCuXFJrSWGi1KHcVqaU4	h9t7HfmUClwEKkUc7f34jH	305747	3	0.188	0.411	0	-9.733	1	0.0484	0.174	0.153	0.0843	0.159	187.376
0nrRP2bk19rLc0orkWPQk2	Wake Me Up	88	14LKOnKDKl4of348SlyER1	1vCWHaC5f2uS3yhpwWbIA6	h9t7HfmUClwEKkUc7f34jH	247427	4	0.532	0.783	2	-5.697	1	0.0523	0.0038	0.0012	0.161	0.643	124.08
0obBFrPYkSoBJbvHfUIhkv	Sexy And I Know It	66	RIPbjpJVp4LWeFaQwvifUu	3sgFRtyBnxXD5ESfmbK4dl	hYKylhpPiH1VPodagRTNzu	199480	4	0.707	0.861	7	-4.225	1	0.316	0.1	0	0.191	0.795	130.021
0oJMv049q8hEkes9w0L1J4	Imma Be	68	qf46gSnCtdiswRzehPxBb9	1yxSLGMDHlW21z4YXirZDS	Z3d7ZvFizjczhqkQnb7RXg	257560	4	0.597	0.517	0	-6.963	1	0.366	0.179	0	0.307	0.413	92.035
0Oqc0kKFsQ6MhFOLBNZIGX	Doin' Time	84	05bAUqt1t1ZnwrBSJUOLZT	00FQb4jTyendYWaN8pK0wa	QlNM9gC3Z9AwcKBBdmOIUm	202193	4	0.641	0.559	7	-11.132	0	0.0355	0.404	0.00402	0.0937	0.523	144.982
0pEkK8MqbmGSX7fT8WLMbR	Grace	73	Lx9E3YScDN73wJzMn0VRJe	4GNC7GD6oZMSxPGyXy4MNB	QlNM9gC3Z9AwcKBBdmOIUm	185658	4	0.722	0.565	4	-5.848	1	0.0335	0.435	0	0.165	0.488	104.483
0pqnGHJpmpxLKifKRmU6WP	Believer	90	MMj6tlEaqaAAtONpeGdLBz	53XhwfbYqKCa1cC15pYq2q	LgCTGYUwup3J1TSMRyObZA	204347	4	0.776	0.78	10	-4.374	0	0.128	0.0622	0	0.081	0.666	124.949
0puf9yIluy9W0vpMEUoAnN	Bang Bang	81	ZJY1p5Vyg3rBHCIJ11csYn	2gsggkzM5R49q6jpPvazou	KUBSaE6ulYu49hAg7vmNAR	199387	4	0.706	0.786	0	-3.417	0	0.091	0.26	0	0.38	0.751	150.028
0PvFJmanyNQMseIFrU708S	For The Night (feat. Lil Baby & DaBaby)	80	rDGf6ffcpANtuKNkvKa7xy	0eDvMgVFoNV3TpwtrVCoTj	ndfd917VUIq2bOQToxPcqS	190476	4	0.823	0.586	6	-6.606	0	0.2	0.114	0	0.193	0.347	125.971
0qwcGscxUHGZTgq0zcaqk1	Here's to Never Growing Up	70	feKDSQUbLKICSZJQ8onRnP	0p4nmQO2msCgU4IF37Wi3j	h9t7HfmUClwEKkUc7f34jH	214320	4	0.482	0.873	0	-3.145	1	0.0853	0.0111	0	0.409	0.737	165.084
0RUGuh2uSNFJpGMSsD1F5C	It Will Rain	71	qnOpU5ZLOMdPo6rKb2ktK1	0du5cEVh5yTK9QJze8zA0C	hYKylhpPiH1VPodagRTNzu	257720	4	0.576	0.835	2	-6.826	1	0.0486	0.337	0	0.082	0.476	150.017
0s0JMUkb2WCxIJsRB3G7Hd	Dear Darlin'	61	hu8UtKhLXZbnZLB4oXxfuK	3whuHq0yGx60atvA2RCVRW	h9t7HfmUClwEKkUc7f34jH	206373	4	0.512	0.828	11	-4.672	0	0.0454	0.00627	8.73e-06	0.119	0.34	124.021
0S4RKPbRDA72tvKwVdXQqe	The Way	70	Oyhx8KSPSNUpA1Z7Yql4oh	66CXWjxzNUsdJxJ2JdwvnR	h9t7HfmUClwEKkUc7f34jH	227027	4	0.645	0.878	5	-3.208	0	0.113	0.294	0	0.076	0.862	82.324
0sf12qNH5qcw8qpgymFOqD	Blinding Lights	19	ui0ZFt8M0HnB9ufuHssm0m	1Xyo4u8uXC1ZmMpatF05PJ	ndfd917VUIq2bOQToxPcqS	201573	4	0.513	0.796	1	-4.075	1	0.0629	0.00147	0.000209	0.0938	0.345	171.017
0SGkqnVQo9KPytSri1H6cF	Bounce Back	71	pojqEe5KA7rxlrOToGU9Xi	0c173mlxpT3dSFRgMO8XPh	LgCTGYUwup3J1TSMRyObZA	222360	4	0.78	0.575	1	-5.628	0	0.139	0.106	0	0.129	0.273	81.502
0skYUMpS0AcbpjcGsAbRGj	Pink Venom	73	HYjYonlWP1jRVKnUxQTbGb	41MozSoPIsD1dJM0CLPjZF	pZxQbhuIGcA5v4a4eMVxDI	186964	4	0.798	0.697	0	-7.139	1	0.0891	0.0202	0	0.259	0.745	90.031
0t7fVeEJxO2Xi4H2K5Svc9	Send My Love (To Your New Lover)	76	itSDqOtn4MS7QnPDDFVe9c	4dpARuHxo51G3z768sgnrY	dRZrPqTJ2iw75iSpHG7KnI	223079	4	0.688	0.533	6	-8.363	0	0.0865	0.0355	3.48e-06	0.172	0.567	164.069
0TAmnCzOtqRfvA38DDLTjj	Little Things	76	ANrsGkxST7pRQWjUDaaK8R	4AK6F7OLvEQ5QYCBNiQWHq	hYKylhpPiH1VPodagRTNzu	219040	4	0.709	0.22	7	-11.856	1	0.0327	0.811	0	0.175	0.53	110.076
0tgVpDi06FyKpA1z0VMD4v	Perfect	90	1Ru5FYEzNIKNM7ByfDjvdT	6eUKZXaKkcviH0Ku9w2n3V	LgCTGYUwup3J1TSMRyObZA	263400	3	0.599	0.448	8	-6.312	1	0.0232	0.163	0	0.106	0.168	95.05
0TXNKTzawI6VgLoA9UauRp	When You Love Someone	74	VG5k6ec1Emeiu3f3H9nDjK	0B3N0ZINFWvizfa8bKiz4v	dRZrPqTJ2iw75iSpHG7KnI	216560	4	0.681	0.453	7	-6.09	1	0.0278	0.263	0	0.0543	0.348	125.772
0U10zFw4GlBacOy9VDGfGL	We Found Love	82	1lWEQkbaJXdisnwHwanXTO	5pKCCKE2ajJHZ9KAiaK11H	hYKylhpPiH1VPodagRTNzu	215227	4	0.735	0.766	1	-4.485	1	0.0383	0.025	0.00138	0.108	0.6	127.985
0v1x6rN6JHRapa03JElljE	Dynamite	0	y5sxQInj8A2fL2FsLtAk4b	3Nrfpe0tUJi4K4DXYWgMUX	ndfd917VUIq2bOQToxPcqS	199054	4	0.746	0.765	6	-4.41	0	0.0993	0.0112	0	0.0936	0.737	114.044
0V3wPSX9ygBnCm8psDIegu	Anti-Hero	93	fkrdol9gOidN8J4Q4M3nGW	06HL4z0CvFAxyc27GXpf02	pZxQbhuIGcA5v4a4eMVxDI	200690	4	0.637	0.643	4	-6.571	1	0.0519	0.13	1.8e-06	0.142	0.533	97.008
0vbtURX4qv1l7besfwmnD8	I Took A Pill In Ibiza - Seeb Remix	81	jOcM1YXlJMJdBFBZjGOM6A	2KsP6tYLJlTBvSUxnwlVWa	dRZrPqTJ2iw75iSpHG7KnI	197933	4	0.664	0.714	7	-6.645	0	0.111	0.0353	8.42e-06	0.0843	0.71	101.969
0vFMQi8ZnOM2y8cuReZTZ2	Blown Away	65	0eCU9CHjzV0H2px0ykCgCO	4xFUf1FHVy696Q1JQZMTRj	hYKylhpPiH1VPodagRTNzu	240133	4	0.531	0.843	9	-2.569	0	0.0429	0.0909	0	0.0283	0.392	136.991
0VhgEqMTNZwYL1ARDLLNCX	Can I Be Him	81	EgZyDWbjtqmnjg1xAnaZev	4IWBUUAFIplrNtaOHcJPRM	dRZrPqTJ2iw75iSpHG7KnI	246880	4	0.696	0.543	11	-6.164	1	0.0489	0.308	0	0.0939	0.479	107.969
0WCiI0ddWiu5F2kSHgfw5S	Take It Off	70	m7UhQ0V2gnLNUouSGZuaJQ	6LqNN22kT3074XbTVUrhzX	Z3d7ZvFizjczhqkQnb7RXg	215200	4	0.729	0.675	5	-5.292	0	0.0286	4.14e-05	0.00126	0.0867	0.74	125.036
0WSEq9Ko4kFPt8yo3ICd6T	Praise God	78	CcdOs1XlSziFjLo3GFqT3Q	5K4W6rqBFWDnAN6FQUkS6x	pcclfKySeZMYGS2V6uxNLn	226653	4	0.798	0.545	1	-6.466	1	0.168	0.00904	9.48e-05	0.258	0.212	118.029
0XvjOhwCnXXFOSlBbV9jPN	Barbra Streisand - Radio Edit	46	hVOZtWaUxalQtToAxoOWPx	0q8J3Yj810t5cpAYEJ7gxt	Z3d7ZvFizjczhqkQnb7RXg	196533	4	0.769	0.922	1	-1.966	1	0.108	0.000939	0.197	0.233	0.506	127.965
0y60itmpH0aPKsFiGxmtnh	Wait a Minute!	81	yLgwhAFmxOb9Pf54YC18kk	3rWZHrfrsPBxVy692yAIxF	dRZrPqTJ2iw75iSpHG7KnI	196520	4	0.764	0.705	3	-5.279	0	0.0278	0.0371	1.94e-05	0.0943	0.672	101.003
0z8hI3OPS8ADPWtoCjjLl6	Summer of Love (Shawn Mendes & Tainy)	77	wQdosoiodfAqZsij5MWFoj	7n2wHs1TKAczGzO7Dd2rGr	pcclfKySeZMYGS2V6uxNLn	184104	4	0.776	0.808	11	-4.501	1	0.117	0.0297	0.000127	0.103	0.494	123.988
0zbzrhfVS9S2TszW3wLQZ7	September Song	71	GYFLlFaEjPeTYA67df5YNh	4kYGAK2zu9EAomwj3hXkXy	LgCTGYUwup3J1TSMRyObZA	220291	4	0.614	0.615	0	-6.7	0	0.0444	0.054	0	0.0921	0.374	95.941
0ZNrc4kNeQYD9koZ3KvCsy	BIG BANK (feat. 2 Chainz, Big Sean, Nicki Minaj)	66	SSv2vWLpaH8oLYAzORt9Gc	0A0FS04o6zMoto8OKPsDwY	Jp4YMIf936KasPLNEymvB3	237240	4	0.745	0.346	1	-7.709	1	0.331	0.00552	0	0.0881	0.112	203.911
0zREtnLmVnt8KUJZZbSdla	Wavin' Flag	61	GFaFksbZM1HkNLKOcgyOTh	7pGyQZx9thVa8GxMBeXscB	Z3d7ZvFizjczhqkQnb7RXg	220520	4	0.625	0.699	0	-6.416	1	0.0729	0.13	0	0.238	0.717	75.974
0ZyfiFudK9Si2n2G9RkiWj	Ride	66	yWvd7fahChwMerfh17getm	00FQb4jTyendYWaN8pK0wa	hYKylhpPiH1VPodagRTNzu	289080	4	0.373	0.686	0	-5.52	1	0.034	0.128	1.96e-06	0.383	0.189	93.763
1000nHvUdawXuUHgBod4Wv	Panini	72	8m1tZbEnGgBAYJHrD9Z9n9	7jVv8c5Fj3E9VhNjxT4snq	QlNM9gC3Z9AwcKBBdmOIUm	114893	4	0.703	0.594	5	-6.146	0	0.0752	0.342	0	0.123	0.475	153.848
10hcDov7xmcRviA8jLwEaI	Need to Know	63	RCDfBYhqsIcei29jJ5XUA3	5cj0lLjcoR7YOSnhnX0Po5	pcclfKySeZMYGS2V6uxNLn	210560	4	0.664	0.609	1	-6.509	1	0.0707	0.304	0	0.0926	0.194	130.041
127QTOFJsJQp5LbJbu3A1y	Toosie Slide	74	xFh85SC04epawID4MyRnYg	3TVXtAsR1Inumwj472S9r4	ndfd917VUIq2bOQToxPcqS	247059	4	0.834	0.454	1	-9.75	0	0.201	0.321	6.15e-06	0.114	0.837	81.618
132ALUzVLmqYB4UsBj5qD6	Adan y Eva	74	Ml5cO85RH0Xl8MbGzsmB1N	3vQ0GE3mI0dAaxIMYe5g7z	QlNM9gC3Z9AwcKBBdmOIUm	256972	4	0.767	0.709	1	-4.47	1	0.336	0.323	0	0.0745	0.72	171.993
14OxJlLdcHNpgsm4DRwDOB	Habits (Stay High)	75	3mTB6fdrTmBctFwrHxXmF9	4NHQUGzhtTLFvgF5SZesLK	KUBSaE6ulYu49hAg7vmNAR	209160	4	0.729	0.65	5	-3.539	1	0.0313	0.0702	6.69e-05	0.0829	0.347	110.02
15JINEqzVMv3SvJTAXAKED	Love The Way You Lie	85	M62GAHp8DW01MkDVWerlbq	7dGJo4pcD2V6oG8kP0tJRR	Z3d7ZvFizjczhqkQnb7RXg	263373	4	0.749	0.925	10	-5.034	1	0.227	0.241	0	0.52	0.641	86.989
16Of7eeW44kt0a1M0nitHM	You Make Me Feel... (feat. Sabi)	72	5NE7eqCekyTIiv0bU4elX1	2aYJ5LAta2ScCdfLhKgZOY	wOvFE37RYJBq423MAkmUPr	215693	4	0.668	0.857	7	-2.944	0	0.0535	0.0191	6.71e-06	0.0385	0.748	131.959
17tDv8WA8IhqE8qzuQn707	My First Kiss (feat. Ke$ha)	64	hByTd9bAfXmQ93POTJXQTD	0FWzNDaEu9jdgcYTbcOa4F	Z3d7ZvFizjczhqkQnb7RXg	192440	4	0.682	0.889	0	-4.166	1	0.0804	0.00564	0	0.36	0.827	138.021
190jyVPHYjAqEaOGmMzdyk	Beauty And A Beat	83	lYG8tLZpeVwMxndjxSulDe	1uNFoZAHBGtllmzznpCI3s	h9t7HfmUClwEKkUc7f34jH	227987	4	0.602	0.843	0	-4.831	1	0.0593	0.000688	5.27e-05	0.0682	0.526	128.003
19cL3SOKpwnwoKkII7U3Wh	Geronimo	68	CtMHnFYKnlLVMZMJrdzvab	6VxCmtR7S3yz4vnzsJqhSV	9wnrC2T34VLxtL7vdC8hVE	218228	4	0.705	0.78	7	-6.267	1	0.0805	0.456	0.00152	0.115	0.457	142.028
19kUPdKTp85q9RZNwaXM15	Good as You	67	qQrxVMu98SUnQb1GteSarL	3oSJ7TBVCWMDMiYjXNiCKE	QlNM9gC3Z9AwcKBBdmOIUm	192053	4	0.626	0.516	8	-6.05	1	0.0388	0.4	0	0.142	0.769	153.653
1A8j067qyiNwQnZT0bzUpZ	This Girl (Kungs Vs. Cookin' On 3 Burners)	81	4gU0hJTbPQuG9gDlYrcqB5	7keGfmQR4X5w0two1xKZ7d	dRZrPqTJ2iw75iSpHG7KnI	195547	4	0.792	0.717	0	-4.759	0	0.0393	0.0927	3.59e-05	0.226	0.466	121.985
1AI7UPw3fgwAFkvAlZWhE0	Take Me Back to London (feat. Stormzy)	66	TSY3wLwOoZ2vxnXtd6XQxm	6eUKZXaKkcviH0Ku9w2n3V	QlNM9gC3Z9AwcKBBdmOIUm	189733	4	0.885	0.762	8	-5.513	0	0.216	0.219	0	0.162	0.605	138.058
1auxYwYrFRqZP7t3s7w4um	Ni**as In Paris	77	4mFIBTKIN3ncuY9geXJp31	3nFkdlSjzX9mRTtwJOzDYB	hYKylhpPiH1VPodagRTNzu	219333	4	0.789	0.858	1	-5.542	1	0.311	0.127	0	0.349	0.775	140.022
1bM50INir8voAkVoKuvEUI	OMG (feat. will.i.am)	76	TjvgMoPjZK5Tm3xmZTAqXD	23zg3TcAtWQy7J6upgbUnj	Z3d7ZvFizjczhqkQnb7RXg	269493	4	0.781	0.745	4	-5.81	0	0.0332	0.198	1.14e-05	0.36	0.326	129.998
1BuZAIO8WZpavWVbbq3Lci	Powerglide (feat. Juicy J) - From SR3MM	66	gy2TH09GSEAvAFcPLOLWR6	7iZtZyCzp3LItcw1wtPI3D	Jp4YMIf936KasPLNEymvB3	332301	4	0.713	0.831	1	-4.75	0	0.15	0.0168	0	0.118	0.584	173.948
1BxfuPKGuaTgP7aM0Bbdwr	Cruel Summer	100	mBW0t8OTI13cfu6QGgWDpO	06HL4z0CvFAxyc27GXpf02	QlNM9gC3Z9AwcKBBdmOIUm	178427	4	0.552	0.702	9	-5.707	1	0.157	0.117	2.06e-05	0.105	0.564	169.994
1c8gk2PeTE04A1pIDH9YMk	Rolling in the Deep	82	A4oVEYX3Fgepv2NmY2JAVt	4dpARuHxo51G3z768sgnrY	wOvFE37RYJBq423MAkmUPr	228093	4	0.73	0.769	8	-5.114	1	0.0298	0.138	0	0.0473	0.507	104.948
1Cv1YLb4q0RzL6pybtaMLo	Sunday Best	77	tX9B1X5tUSe0Vo6ZC1NUwV	4ETSs924pXMzjIeD6E9b4u	ndfd917VUIq2bOQToxPcqS	158571	4	0.878	0.525	5	-6.832	1	0.0578	0.183	0	0.0714	0.694	112.022
1dGr1c8CrMLDpV6mPbImSI	Lover	91	mBW0t8OTI13cfu6QGgWDpO	06HL4z0CvFAxyc27GXpf02	QlNM9gC3Z9AwcKBBdmOIUm	221307	4	0.359	0.543	7	-7.582	1	0.0919	0.492	1.58e-05	0.118	0.453	68.534
1DunhgeZSEgWiIYbHqXl0c	Latch	73	ScCeg1AcIW2Dqpo8p8sRvA	6nS5roXSAGhTGr34W6n7Et	hYKylhpPiH1VPodagRTNzu	255867	4	0.729	0.735	1	-5.455	1	0.0919	0.0178	0.000193	0.089	0.544	121.986
1DWZUa5Mzf2BwzpHtgbHPY	Good News	74	EzIBRHlZVwVdHwVo2sAJWB	4LLpKhyESsyAXpc4laK94U	ndfd917VUIq2bOQToxPcqS	342040	4	0.794	0.32	1	-12.92	0	0.173	0.853	0.134	0.112	0.241	174.088
1EAgPzRbK9YmdOESSMUm6P	Home	73	vk68LIqlyOoM0W3tijKxYs	6p5JxpTc7USNnBnLzctyd4	hYKylhpPiH1VPodagRTNzu	210173	4	0.606	0.826	0	-6.04	1	0.0307	0.0256	1.56e-05	0.117	0.322	121.04
1eyzqe2QqGZUmfcPZtrIyt	Midnight City	74	K4V28eLNYoUklG3KYINEmk	63MQldklfxkjYDoUE4Tppz	wOvFE37RYJBq423MAkmUPr	241440	4	0.526	0.712	11	-6.525	0	0.0356	0.0161	0	0.179	0.32	105.009
1f8UCzB3RqIgNkW7QIiIeP	Heart Skips a Beat (feat. Rizzle Kicks)	63	TGcqk3M7RDvxWWYLfZWPW3	3whuHq0yGx60atvA2RCVRW	wOvFE37RYJBq423MAkmUPr	202267	4	0.843	0.881	9	-3.951	1	0.0581	0.14	0	0.0765	0.876	110.621
1fu5IQSRgPxJL2OTP7FVLW	I See Fire	62	YEDP2Zao3uyqExotpuQXjt	6eUKZXaKkcviH0Ku9w2n3V	KUBSaE6ulYu49hAg7vmNAR	300747	4	0.633	0.0519	10	-21.107	0	0.0365	0.562	0	0.097	0.204	76.034
1Fxp4LBWsNC58NwnGAXJld	Down With The Trumpets	60	y26OjaCm5xGkEllTjqnkI0	2ajhZ7EA6Dec0kaWiKCApF	wOvFE37RYJBq423MAkmUPr	186851	4	0.753	0.88	4	-4.689	0	0.0806	0.087	0	0.24	0.794	115.057
1gihuPhrLraKYrJMAEONyc	Feel So Close - Radio Edit	83	fbgo2VmM0aYOB59uS5aJWV	7CajNmpbOovFoOoasH2HaY	hYKylhpPiH1VPodagRTNzu	206413	4	0.707	0.924	7	-2.842	1	0.031	0.000972	0.00703	0.204	0.919	127.937
1hBM2D1ULT3aeKuddSwPsK	STARSTRUKK (feat. Katy Perry)	66	G4FL3sxSvcGZwWUslg6ReT	0FWzNDaEu9jdgcYTbcOa4F	Z3d7ZvFizjczhqkQnb7RXg	202667	4	0.607	0.805	11	-5.579	0	0.0608	0.00175	0	0.231	0.232	139.894
1HHeOs6zRdF8Ck58easiAY	Alejandro	74	5WTRyrgd7TcTXUGfut79fO	1HY2Jd0NmPuamShAr6KMms	Z3d7ZvFizjczhqkQnb7RXg	274213	4	0.623	0.793	11	-6.63	0	0.0462	0.000397	0.0015	0.375	0.36	98.998
1HNkqx9Ahdgi1Ixy2xkKkL	Photograph	87	QKiHO8PXsxZn8zsxZMz9rc	6eUKZXaKkcviH0Ku9w2n3V	KUBSaE6ulYu49hAg7vmNAR	258987	4	0.614	0.379	4	-10.48	1	0.0476	0.607	0.000464	0.0986	0.201	107.989
1i1fxkWeaMmKEB4T7zqbzK	Don't Let Me Down	82	0XH4ou2qfnmx2p3135bars	69GGBxA162lTqCwzJG5jLp	dRZrPqTJ2iw75iSpHG7KnI	208373	4	0.532	0.869	11	-5.094	1	0.172	0.157	0.00508	0.136	0.422	159.803
1IHWl5LamUGEuP4ozKQSXZ	TitÃ­ Me PreguntÃ³	88	TJLNdIPReZFoj2z4xC6jGr	4q3ewBCX7sLwd24euuV69X	pZxQbhuIGcA5v4a4eMVxDI	243717	4	0.65	0.715	5	-5.198	0	0.253	0.0993	0.000291	0.126	0.187	106.672
1JDIArrcepzWDTAWXdGYmP	I Want You To Know	68	eEemh7JJDWHXLTlGgcIbvr	2qxJFvFYMEDqd7ui6kSAcq	9wnrC2T34VLxtL7vdC8hVE	240000	4	0.58	0.846	9	-2.876	0	0.0573	0.00537	6.62e-06	0.145	0.366	129.998
1KtD0xaLAikgIt5tPbteZQ	Thinking About You (feat. Ayah Marar)	69	fbgo2VmM0aYOB59uS5aJWV	7CajNmpbOovFoOoasH2HaY	h9t7HfmUClwEKkUc7f34jH	247933	4	0.725	0.874	0	-3.715	0	0.0396	0.00262	0.000412	0.0958	0.748	127.985
1Lim1Py7xBgbAkAys3AGAG	Lean On	77	1lqnHSIfwwGuVK6f8tyGVd	738wLrAtLtCtFOLvQBXOXp	9wnrC2T34VLxtL7vdC8hVE	176561	4	0.723	0.809	7	-3.081	0	0.0625	0.00346	0.00123	0.565	0.274	98.007
1lOe9qE0vR9zwWQAOk6CoO	Ransom	82	RaQUVeRvV9RFNJZMPyisFb	4Ga1P7PMIsmqEZqhYZQgDo	QlNM9gC3Z9AwcKBBdmOIUm	131240	4	0.745	0.642	7	-6.257	0	0.287	0.0204	0	0.0658	0.226	179.974
1mKXFLRA179hdOWQBwUk9e	Just Give Me a Reason (feat. Nate Ruess)	84	qFcMbu76A6zVBJ0QZynDbs	1KCSPY1glIKqW2TotWuXOR	h9t7HfmUClwEKkUc7f34jH	242733	4	0.778	0.547	2	-7.273	1	0.0489	0.346	0.000302	0.132	0.441	95.002
1mXVgsBdtIVeCLJnSnmtdV	Too Good At Goodbyes	86	nMjQmVgLliURKSFzs1vACs	2wY79sveU1sp5g7SokKOiI	LgCTGYUwup3J1TSMRyObZA	201000	4	0.681	0.372	5	-8.237	1	0.0432	0.64	0	0.169	0.476	91.873
1NpW5kyvO4XrNJ3rnfcNy3	Wild Ones (feat. Sia)	80	iAft5A3mX8Y1lxDanCJxZi	0jnsk9HBra6NMjO2oANoPY	hYKylhpPiH1VPodagRTNzu	232947	4	0.608	0.86	5	-5.324	0	0.0554	0.0991	0	0.262	0.437	127.075
1nueTG77MzNkJTKQ0ZdGzT	Don't Wanna Know (feat. Kendrick Lamar)	65	oVY5eQ5EDi1gRZp3cM24Yp	04gDigrS5kc9YWfZHwBETP	LgCTGYUwup3J1TSMRyObZA	214265	4	0.783	0.61	7	-6.124	1	0.0696	0.343	0	0.0983	0.418	100.047
1nZzRJbFvCEct3uzu04ZoL	Part Of Me	76	LotvOKuFl91BpsqnAcFcGl	6jJ0s89eD6GaHleKKya26X	hYKylhpPiH1VPodagRTNzu	216160	4	0.678	0.918	5	-4.63	1	0.0355	0.000417	0	0.0744	0.769	130.028
1oFAF1hdPOickyHgbuRjyX	Save Your Tears (Remix) (with Ariana Grande) - Bonus Track	82	vSIUBbUUbiFXLlWQ2a4rH7	1Xyo4u8uXC1ZmMpatF05PJ	pZxQbhuIGcA5v4a4eMVxDI	191014	4	0.65	0.825	0	-4.645	1	0.0325	0.0215	2.44e-05	0.0936	0.593	118.091
1oHNvJVbFkexQc0BpQp7Y4	Starships	77	9XP31CaBKqVFrfbPVM4GxG	0hCNtLu0JehylgoiP8L4Gh	hYKylhpPiH1VPodagRTNzu	210627	4	0.747	0.716	11	-2.457	0	0.075	0.135	0	0.251	0.751	125.008
1oHxIPqJyvAYHy0PVrDU98	Drinking from the Bottle (feat. Tinie Tempah)	62	fbgo2VmM0aYOB59uS5aJWV	7CajNmpbOovFoOoasH2HaY	h9t7HfmUClwEKkUc7f34jH	240347	4	0.665	0.886	9	-4.175	0	0.0514	0.0469	6.24e-05	0.0525	0.53	128.062
1P17dC1amhFzptugyAO7Il	Look What You Made Me Do	86	81m49NLePQpOCfY4KI7pKJ	06HL4z0CvFAxyc27GXpf02	LgCTGYUwup3J1TSMRyObZA	211853	4	0.766	0.709	9	-6.471	0	0.123	0.204	1.41e-05	0.126	0.506	128.07
1PAYgOjp1c9rrZ2kVQg2vN	Changed the Way You Kiss Me - Radio Edit	64	xzVeMt5udwpTLA2CmvTyna	6Vh6UDWfu9PUSXSzAaB3CW	wOvFE37RYJBq423MAkmUPr	195467	4	0.578	0.857	4	-3.78	0	0.041	0.00548	0.00162	0.0948	0.188	126.979
1PckUlxKqWQs3RlWXVBLw3	About Damn Time	80	hi3PywrKYfGVWMVb0hVn6O	56oDRnqbIiwx4mymNEv7dS	pZxQbhuIGcA5v4a4eMVxDI	191822	4	0.836	0.743	10	-6.305	0	0.0656	0.0995	0	0.335	0.722	108.966
1PSBzsahR2AKwLJgx8ehBj	Bad Things (with Camila Cabello)	73	uXAn01sEKucbx8jdYgs5vC	6TIYQ3jFPwQSRmorSezPxX	LgCTGYUwup3J1TSMRyObZA	239293	4	0.697	0.691	2	-4.757	1	0.146	0.214	0	0.185	0.305	137.853
1qEmFfgcLObUfQm0j1W2CK	Late Night Talking	87	QPJKhrkNIJjCpuZrCntEBY	6KImCVD70vtIoJWnq6nGn3	pZxQbhuIGcA5v4a4eMVxDI	177955	4	0.714	0.728	10	-4.595	1	0.0468	0.298	0	0.106	0.901	114.996
1r3myKmjWoOqRip99CmSj1	Don't Wanna Go Home	64	1GRaLygoEdn4QrbxgMDqiH	07YZf4WDAMNwqr4jfgOZ8y	wOvFE37RYJBq423MAkmUPr	206080	4	0.671	0.808	2	-4.861	0	0.0652	0.02	0	0.134	0.637	121.956
1r8ZCjfrQxoy2wVaBUbpwg	Thousand Miles	77	1VQu2bCA0syWiEGV1dcDxC	2tIP7SsRs7vjIcLrU85W8J	pZxQbhuIGcA5v4a4eMVxDI	164782	4	0.376	0.657	7	-4.658	1	0.0768	0.0858	0	0.0884	0.203	80.565
1rDQ4oMwGJI7B4tovsBOxc	First Class	24	lnTkJz46nWCWhpTKoELM2o	2LIk90788K0zvyj2JJVwkJ	pZxQbhuIGcA5v4a4eMVxDI	173948	4	0.905	0.563	8	-6.135	1	0.102	0.0254	9.71e-06	0.113	0.324	106.998
1rfofaqEpACxVEHIZBJe6W	Havana (feat. Young Thug)	82	WSx1yfmFnbNWbN4PoDTLNW	4nDoRrQiYLoBzwC5BhVJzF	LgCTGYUwup3J1TSMRyObZA	217307	4	0.765	0.523	2	-4.333	1	0.03	0.184	3.56e-05	0.132	0.394	104.988
1ri9ZUkBJVFUdgwzCnfcYs	MAMIII	78	pftRBjrY01ajuOBfy7x7RR	4obzFoKoKRHIphyHzJ35G3	pZxQbhuIGcA5v4a4eMVxDI	226088	4	0.843	0.7	4	-3.563	0	0.0803	0.0934	0	0.14	0.899	93.991
1RMRkCn07y2xtBip9DzwmC	Turn Up the Music	65	sxxcTaedFrEBsF0BICuFPy	7bXgB6jMjp9ATFy66eO08Z	hYKylhpPiH1VPodagRTNzu	227973	4	0.594	0.841	1	-5.792	1	0.102	0.000238	2.22e-06	0.156	0.643	129.925
1rqqCSm0Qe4I9rUvWncaom	High Hopes	82	mExcmIQRoJ5tbpVA9Ym5y1	20JZFwl6HVl6yg8a4H3ZqK	QlNM9gC3Z9AwcKBBdmOIUm	190947	4	0.579	0.904	5	-2.729	1	0.0618	0.193	0	0.064	0.681	82.014
1wJRveJZLSb1rjhnUHQiv6	Swervin (feat. 6ix9ine)	75	Wwul1C732vLOM3YlQlcMJe	31W5EY0aAly4Qieq6OFu6I	QlNM9gC3Z9AwcKBBdmOIUm	189487	4	0.581	0.662	9	-5.239	1	0.303	0.0153	0	0.111	0.434	93.023
1WoOzgvz6CgH4pX6a1RKGp	My Way (feat. Monty)	68	XL4QEuvZTUlmyNigmFPvs3	6PXS4YHDkKvl1wkIl4V8DL	9wnrC2T34VLxtL7vdC8hVE	213053	4	0.748	0.741	6	-3.103	1	0.0531	0.00419	0	0.147	0.537	128.077
1WtTLtofvcjQM3sXSMkDdX	How Low	65	GoZRTt8NnfK2jxnfqufbUI	3ipn9JLAPI5GUEo4y4jcoi	Z3d7ZvFizjczhqkQnb7RXg	201587	4	0.785	0.498	1	-6.977	1	0.0533	0.00248	1.23e-06	0.224	0.418	143.96
1xzi1Jcr7mEi9K2RfzLOqS	CUFF IT	87	h88zi8oQCzrfOeP9OoeGRe	6vWDO969PvNqNYHIOW5v0m	pZxQbhuIGcA5v4a4eMVxDI	225389	4	0.78	0.689	7	-5.668	1	0.141	0.0368	9.69e-06	0.0698	0.642	115.042
1yjY7rpaAQvKwpdUliHx0d	Still into You	83	wSZrg2L1j48eG1dGw0hlVq	74XFHRwlV6OrjEM0A2NCMF	h9t7HfmUClwEKkUc7f34jH	216013	4	0.602	0.923	5	-3.763	1	0.044	0.0098	0	0.0561	0.765	136.01
1yK9LISg5uBOOW5bT2Wm0i	Try Sleeping with a Broken Heart	63	09mA6vMx1zYyUhuvpfv056	3DiDSECUqqY1AuBP8qtaIa	Z3d7ZvFizjczhqkQnb7RXg	249013	5	0.496	0.821	5	-5.155	1	0.112	0.158	0.246	0.13	0.549	110.977
1z9kQ14XBSN0r2v6fx4IdG	Diamonds	77	xzGjyw2L7PclvClluKQSrh	5pKCCKE2ajJHZ9KAiaK11H	hYKylhpPiH1VPodagRTNzu	225147	4	0.564	0.71	11	-4.92	0	0.0461	0.00125	0	0.109	0.393	91.972
1zB4vmk8tFRmM9UULNzbLB	Thunder	88	MMj6tlEaqaAAtONpeGdLBz	53XhwfbYqKCa1cC15pYq2q	LgCTGYUwup3J1TSMRyObZA	187147	4	0.605	0.822	0	-4.833	1	0.0438	0.00671	0.134	0.147	0.288	167.997
1zi7xx7UVEFkmKfv06H8x0	One Dance	89	rEjj5noxgRHDXwN31NOuF9	3TVXtAsR1Inumwj472S9r4	dRZrPqTJ2iw75iSpHG7KnI	173987	4	0.792	0.625	1	-5.609	1	0.0536	0.00776	0.0018	0.329	0.37	103.967
1zVhMuH7agsRe6XkljIY4U	human	62	1emBPKN1KDyxLMFuXfisEe	7H55rcKCfwqkyDFH9wpKM6	h9t7HfmUClwEKkUc7f34jH	250707	4	0.439	0.489	8	-6.286	1	0.0368	0.132	0.000643	0.114	0.253	143.808
21jGcNKet2qwijlDFuPiPb	Circles	89	WtKSmRFwq1YGrQymSrqaxp	246dkjvS1zLTtiykXe5h60	QlNM9gC3Z9AwcKBBdmOIUm	215280	4	0.695	0.762	0	-3.497	1	0.0395	0.192	0.00244	0.0863	0.553	120.042
22LAwLoDA5b4AaGSkg6bKW	Blueberry Faygo	76	kjTW4EhTW8g0j9x4KPsPVV	5zctI4wO9XSKS8XwcnqEHk	ndfd917VUIq2bOQToxPcqS	162547	4	0.774	0.554	0	-7.909	1	0.0383	0.207	0	0.132	0.349	99.034
22vgEDb5hykfaTwLuskFGD	Sucker	83	K941V577nQ3yxGOssbbV50	7gOdHgIoIKoe4i9Tta6qdD	QlNM9gC3Z9AwcKBBdmOIUm	181027	4	0.842	0.734	1	-5.065	0	0.0588	0.0427	0	0.106	0.952	137.958
23L5CiUhw2jV1OIMwthR3S	In the Name of Love	82	yzjCXlHQWVSYhI3AF5KBdT	60d24wfXkVzDSfLS6hyCjZ	dRZrPqTJ2iw75iSpHG7KnI	195707	4	0.501	0.519	4	-5.88	0	0.0409	0.109	0	0.454	0.168	133.99
25cUhiAod71TIQSNicOaW3	Adorn	71	cwHApq2OwaJAoHciFR1isS	360IAlyVv4PCEVjgyMZrxK	hYKylhpPiH1VPodagRTNzu	193147	4	0.625	0.576	11	-5.693	0	0.175	0.0543	4.07e-05	0.187	0.235	179.063
27GmP9AWRs744SzKcpJsTZ	Jumpman	73	hsjhvIGhKASPzjxTgMH184	3TVXtAsR1Inumwj472S9r4	dRZrPqTJ2iw75iSpHG7KnI	205879	4	0.852	0.553	1	-7.286	1	0.187	0.0559	0	0.332	0.656	142.079
27NovPIUIRrOZoCHxABJwK	INDUSTRY BABY (feat. Jack Harlow)	82	Pb4JMl8kOeG4DXDvFsbsFi	7jVv8c5Fj3E9VhNjxT4snq	pZxQbhuIGcA5v4a4eMVxDI	212000	4	0.736	0.704	3	-7.409	0	0.0615	0.0203	0	0.0501	0.894	149.995
28GUjBGqZVcAV4PHSYzkj2	So Good	66	JLe1XZ7GmA07M1xpmHvyJj	5ndkK3dpZLKtBklKjxNQwT	hYKylhpPiH1VPodagRTNzu	213253	4	0.66	0.9	7	-5.02	1	0.14	0.0403	0	0.219	0.591	85.51
29d0nY7TzCoi22XBqDQkiP	Running Up That Hill (A Deal With God) - 2018 Remaster	28	5kfmcehxWSzWiVRRjRn3zG	1aSxMhuvixZ8h9dK9jIDwL	pZxQbhuIGcA5v4a4eMVxDI	300840	4	0.625	0.533	10	-11.903	0	0.0596	0.659	0.00266	0.0546	0.139	108.296
29JrmE89KgRyCxBIzq2Ocw	Strip That Down (feat. Quavo)	70	Vb3nt9CpuWZr22HGfLHL6y	5pUo3fmmHT8bhCyHE52hA6	LgCTGYUwup3J1TSMRyObZA	202062	4	0.873	0.495	6	-5.446	1	0.0518	0.199	0	0.0805	0.546	106.033
2BOqDYLOJBiMOXShCV1neZ	Dancing On My Own	82	mbFXMOi5zNPQSDT5MlhIMM	6ydoSd3N2mwgwBHtF6K7eX	dRZrPqTJ2iw75iSpHG7KnI	260285	4	0.681	0.174	1	-8.745	1	0.0315	0.837	3.35e-05	0.0983	0.231	112.672
2Bs4jQEGMycglOfWPBqrVG	Steal My Girl	82	T7NxzTTggdT3gtq7RbDuVN	4AK6F7OLvEQ5QYCBNiQWHq	KUBSaE6ulYu49hAg7vmNAR	228133	4	0.536	0.768	10	-5.948	0	0.0347	0.00433	0	0.114	0.545	77.217
2DHc2e5bBn4UzY0ENVFrUl	Carry Out (Featuring Justin Timberlake)	70	I42pCTvXJYF9TJ1jle9uXH	5Y5TRrQiqgUO4S36tzjIRZ	Z3d7ZvFizjczhqkQnb7RXg	232467	5	0.531	0.574	10	-6.693	0	0.113	0.114	0.0308	0.256	0.272	115.68
2dLLR6qlu5UJ5gk0dKz0h3	Royals	82	aVjUrDKgxT8d8DhukT8OaK	163tK9Wjr9P9DmM0AVK7lm	h9t7HfmUClwEKkUc7f34jH	190185	4	0.674	0.428	7	-9.504	1	0.122	0.121	0	0.132	0.337	84.878
2dRvMEW4EwySxRUtEamSfG	The Heart Wants What It Wants	61	mioV6HHCbvcUoYxefkOGHc	0C8ZW7ezQVs4URX5aX7Kqx	KUBSaE6ulYu49hAg7vmNAR	227360	4	0.616	0.789	7	-4.874	0	0.0377	0.053	0	0.142	0.621	83.066
2EcsgXlxz99UMDSPg5T8RF	Beneath Your Beautiful (feat. Emeli SandÃ©)	70	3i38MFcKyAnvyeIa0I1txv	2feDdbD5araYcm6JhFHHw7	hYKylhpPiH1VPodagRTNzu	271813	4	0.561	0.522	2	-5.857	1	0.0318	0.227	0	0.104	0.238	83.962
2Foc5Q5nqNiosCNqttzHof	Get Lucky (Radio Edit) [feat. Pharrell Williams and Nile Rodgers]	83	HTZ6iJihPth59V4bcupVGO	4tZwfgrHOc3mvqYlEYSvVi	h9t7HfmUClwEKkUc7f34jH	248413	4	0.794	0.811	6	-8.966	0	0.038	0.0426	1.07e-06	0.101	0.862	116.047
2fQ6sBFWaLv2Gxos4igHLy	Say Aah (feat. Fabolous)	65	ZEWxHP66vxAahBlDBopew8	2iojnBLj0qIMiKPvVhLnsH	Z3d7ZvFizjczhqkQnb7RXg	207547	4	0.724	0.87	1	-3.614	0	0.113	0.00453	0	0.833	0.81	93.01
2FV7Exjr70J652JcGucCtE	The Mother We Share	59	PS8ZM5J057W6EpoJKKOOQh	3CjlHNtplJyTf9npxaPl5w	h9t7HfmUClwEKkUc7f34jH	191294	4	0.45	0.677	1	-6.428	1	0.0313	0.0319	3.02e-06	0.126	0.324	174.027
2Fxmhks0bxGSBdJ92vM42m	bad guy	85	sXF5w1SSO7BOUBh4oeTXl2	6qqNVTkY8uBg9cP3Jd7DAH	QlNM9gC3Z9AwcKBBdmOIUm	194088	4	0.701	0.425	7	-10.965	1	0.375	0.328	0.13	0.1	0.562	135.128
2g6tReTlM2Akp41g0HaeXN	Die Hard	79	rJ8rKtBEaM6ZHGwFoNmwhL	2YZyLoL8N0Wb9xBt1NhZWg	pZxQbhuIGcA5v4a4eMVxDI	239027	4	0.775	0.736	1	-8.072	0	0.247	0.319	0.00116	0.127	0.362	100.988
2GQEM9JuHu30sGFvRYeCxz	Faded	62	HCRcGt6BUiu9LlC1yfI2M4	28j8lBWDdDSHSSt5oPlsX2	KUBSaE6ulYu49hAg7vmNAR	223480	4	0.867	0.477	9	-7.183	0	0.049	0.00843	0.175	0.113	0.614	124.979
2GyA33q5rti5IxkMQemRDH	I Know What You Did Last Summer	74	SXKSIHAEaqcllq4sspQEHI	7n2wHs1TKAczGzO7Dd2rGr	dRZrPqTJ2iw75iSpHG7KnI	223853	4	0.687	0.761	9	-4.582	0	0.0876	0.102	0	0.147	0.743	113.939
2GYHyAoLWpkxLVa4oYTVko	Alors on danse - Radio Edit	80	nB7aI6VhCqpFOcwARgVx95	5j4HeCoUlzhfWtjAfM1acR	Z3d7ZvFizjczhqkQnb7RXg	206067	4	0.791	0.59	1	-9.206	0	0.0793	0.0994	0.00203	0.065	0.714	119.951
2i0AUcEnsDm3dsqLrFWUCq	Tonight Tonight	73	5A42tC20fyhLnN2Q3XvYgE	6jTnHxhb6cDCaCu4rdvsQ0	wOvFE37RYJBq423MAkmUPr	200467	4	0.686	0.783	4	-4.977	1	0.119	0.0764	0	0.163	0.814	99.978
2ihCaVdNZmnHZWt0fvAM7B	Little Talks	82	Uhv3IxT8ac793dkZQAjeSh	4dwdTW1Lfiq0cM8nBAqIIz	h9t7HfmUClwEKkUc7f34jH	266600	4	0.457	0.757	1	-5.177	1	0.032	0.0206	0	0.146	0.417	102.961
2iUmqdfGZcHIhS3b9E9EWq	Everybody Talks	81	pc6ttdC1zPQmFXN6tOp7MP	0RpddSzUHfncUWNJXKOsjy	hYKylhpPiH1VPodagRTNzu	177280	4	0.471	0.924	8	-3.906	1	0.0586	0.00301	0	0.313	0.725	154.961
2iuZJX9X9P0GKaE93xcPjk	Sugar	83	avHL55XdULYRbi7pc24Uog	04gDigrS5kc9YWfZHwBETP	KUBSaE6ulYu49hAg7vmNAR	235493	4	0.748	0.788	1	-7.055	1	0.0334	0.0591	0	0.0863	0.884	120.076
2ixsaeFioXJmMgkkbd4uj1	Budapest	82	hQ1DnvWyq9wnE6Og4Uvfr2	2ysnwxxNtSgbb9t1m2Ur4j	KUBSaE6ulYu49hAg7vmNAR	200733	4	0.717	0.455	5	-8.303	1	0.0276	0.0846	0	0.11	0.389	127.812
2JvzF1RMd7lE3KmFlsyZD8	MIDDLE CHILD	84	WRAW5S89ol8as3SX1trIYE	6l3HvQ5sa6mXTsMTB19rO5	QlNM9gC3Z9AwcKBBdmOIUm	213594	4	0.837	0.364	8	-11.713	1	0.276	0.149	0	0.271	0.463	123.984
2JzZzZUQj3Qff7wapcbKjc	See You Again (feat. Charlie Puth)	85	yeNusMSn44IStFkwLLdTNq	137W8MRPWKqSmrBGDBFSop	9wnrC2T34VLxtL7vdC8hVE	229526	4	0.689	0.481	10	-7.503	1	0.0815	0.369	1.03e-06	0.0649	0.283	80.025
2KukL7UlQ8TdvpaA7bY3ZJ	BREAK MY SOUL	72	6rztDuATqT1hqyHpeulkSI	6vWDO969PvNqNYHIOW5v0m	pZxQbhuIGcA5v4a4eMVxDI	278282	4	0.687	0.887	1	-5.04	0	0.0826	0.0575	2.21e-06	0.27	0.853	114.941
2L7rZWg9RLxIwnysmxm4xk	Boyfriend	65	lYG8tLZpeVwMxndjxSulDe	1uNFoZAHBGtllmzznpCI3s	hYKylhpPiH1VPodagRTNzu	171333	4	0.717	0.55	10	-6.019	0	0.0519	0.0358	0.00198	0.126	0.331	96.979
2M9ULmQwTaTGmAdXaXpfz5	Billionaire (feat. Bruno Mars)	75	hkmp2IVS5IU4ZbInZC8r8E	7o9Nl7K1Al6NNAHX6jn6iG	Z3d7ZvFizjczhqkQnb7RXg	211160	4	0.633	0.673	6	-6.403	0	0.258	0.297	0	0.206	0.659	86.776
2NniAhAtkRACaMeYt48xlD	50 Ways to Say Goodbye	69	vbnRDDwMRARMMjIB2c3Qxx	3FUY2gzHeIiaesXtOAdB7A	hYKylhpPiH1VPodagRTNzu	247947	4	0.591	0.935	6	-2.664	1	0.0478	0.000284	0.000278	0.142	0.736	140.043
2OXidlnDThZR3zf36k6DVL	Just A Kiss	65	zXXgTXKNfU5TFD348hU5wC	32WkQRZEVKSzVAAYqukAEA	wOvFE37RYJBq423MAkmUPr	218840	4	0.593	0.639	1	-5.826	1	0.0307	0.446	0	0.0998	0.332	142.881
2PIvq1pGrUjY007X5y1UpM	Earned It (Fifty Shades Of Grey) - From The "Fifty Shades Of Grey" Soundtrack	77	C4OHIqLyBufUHm7d8VVytu	1Xyo4u8uXC1ZmMpatF05PJ	9wnrC2T34VLxtL7vdC8hVE	252227	3	0.659	0.381	2	-5.922	0	0.0304	0.385	0	0.0972	0.426	119.844
2QD4C6RRHgRNRAyrfnoeAo	Play Hard (feat. Ne-Yo & Akon)	63	B2exUPK9T5kOL16qwoU2gA	1Cs0zKBU1kc0i8ypK3B9ai	h9t7HfmUClwEKkUc7f34jH	201000	4	0.691	0.921	8	-1.702	0	0.0535	0.174	0	0.331	0.802	130.072
2QjOHCTQ1Jl3zawyYOpxh6	Sweater Weather	91	LN38h8kksPxGb9KMfV9dJt	77SW9BnxLY8rJ0RciFqkHh	h9t7HfmUClwEKkUc7f34jH	240400	4	0.612	0.807	10	-2.81	1	0.0336	0.0495	0.0177	0.101	0.398	124.053
2qT1uLXPVPzGgFOx4jtEuo	no tears left to cry	79	oklCYUa2mBJA3nq2Y2sNDn	66CXWjxzNUsdJxJ2JdwvnR	Jp4YMIf936KasPLNEymvB3	205920	4	0.699	0.713	9	-5.507	0	0.0594	0.04	3.11e-06	0.294	0.354	121.993
2qxmye6gAegTMjLKEBoR3d	Let Me Down Slowly	87	jnI1rPljcfCki1mwl68QYc	5IH6FPUwQTxPSXurCrcIov	QlNM9gC3Z9AwcKBBdmOIUm	169354	4	0.652	0.557	1	-5.714	0	0.0318	0.74	0	0.124	0.483	150.073
2r6DdaSbkbwoPzuK6NjLPn	Can't Be Tamed	67	DOksD6YNbDUFm4mq9gtSBS	5YGY8feqx7naU7z4HrwZM6	Z3d7ZvFizjczhqkQnb7RXg	168213	4	0.63	0.91	11	-2.919	0	0.144	0.0287	0	0.196	0.743	116.98
2rDwdvBma1O1eLzo29p2cr	Whataya Want from Me	64	PcT1EPz4a3KNfY9iSDDLvA	6prmLEyn4LfHlD9NnXWlf7	Z3d7ZvFizjczhqkQnb7RXg	227320	4	0.44	0.683	11	-4.732	0	0.0489	0.00706	0	0.0593	0.445	185.948
2rurDawMfoKP4uHyb2kJBt	Te Felicito	83	HAcyWGuH1Ch26uRLOPLWbE	0EmeFodog0BfCgMzAIvKQp	pZxQbhuIGcA5v4a4eMVxDI	172235	4	0.695	0.636	5	-4.654	1	0.317	0.234	0	0.081	0.575	174.14
2S5LNtRVRPbXk01yRQ14sZ	I Don't Like It, I Love It (feat. Robin Thicke & Verdine White)	68	5y0bDXN9bf9tbkd72WZSbB	0jnsk9HBra6NMjO2oANoPY	9wnrC2T34VLxtL7vdC8hVE	224258	4	0.854	0.766	9	-4.697	0	0.141	0.0242	0	0.0793	0.784	118.004
2SAqBLGA283SUiwJ3xOUVI	Laugh Now Cry Later (feat. Lil Durk)	80	UBlJ7ZeeAQwPEeiVhTJA7f	3TVXtAsR1Inumwj472S9r4	ndfd917VUIq2bOQToxPcqS	261493	4	0.761	0.518	0	-8.871	1	0.134	0.244	3.47e-05	0.107	0.522	133.976
2sEk5R8ErGIFxbZ7rX6S2S	How to Be a Heartbreaker	71	mSCd3tK6a9A0ZJkn0PNrgt	6CwfuxIqcltXDGjfZsMd9A	hYKylhpPiH1VPodagRTNzu	221493	4	0.69	0.897	11	-4.696	0	0.0506	0.0142	0	0.108	0.849	140.05
2sLwPnIP3CUVmIuHranJZU	Wiggle (feat. Snoop Dogg)	58	i1a3XP4M9oQdN7YwLyvNbL	07YZf4WDAMNwqr4jfgOZ8y	KUBSaE6ulYu49hAg7vmNAR	193296	4	0.697	0.621	9	-6.886	0	0.25	0.0802	0	0.162	0.721	81.946
2stPxcgjdSImK7Gizl8ZUN	The Man	60	ItOtP3GqqsZ9hO21w0RKHR	0id62QV2SZZfvBn9xpmuCl	KUBSaE6ulYu49hAg7vmNAR	254880	4	0.308	0.769	11	-7.256	0	0.065	0.0331	0	0.214	0.488	81.853
2t8yVaLvJ0RenpXUIAC52d	a lot	82	Yo4CiC2sLfRvSSJKVWj82L	1URnnhqYAYcrqrcwql10ft	QlNM9gC3Z9AwcKBBdmOIUm	288624	4	0.837	0.636	1	-7.643	1	0.086	0.0395	0.00125	0.342	0.274	145.972
2tJulUYLDKOg9XrtVkMgcJ	Grenade	80	2kxbRH0Uah0OQnltYTwqgZ	0du5cEVh5yTK9QJze8zA0C	wOvFE37RYJBq423MAkmUPr	222091	4	0.704	0.558	2	-7.273	0	0.0542	0.148	0	0.107	0.245	110.444
2tpWsVSb9UEmDRxAl1zhX1	Counting Stars	88	SKZyDF66bl5uEXFdL14Wq8	5Pwc4xIPtQLFEnJriah9YJ	KUBSaE6ulYu49hAg7vmNAR	257267	4	0.664	0.705	1	-4.972	0	0.0382	0.0654	0	0.118	0.477	122.016
2tTmW7RDtMQtBk7m2rYeSw	Quevedo: Bzrp Music Sessions, Vol. 52	91	fWxzm3LslYwy8VBuuHkON9	716NhGYqD1jl2wI1Qkgq36	pZxQbhuIGcA5v4a4eMVxDI	198938	4	0.621	0.782	2	-5.548	1	0.044	0.0125	0.033	0.23	0.55	128.033
2TUzU4IkfH8kcvY2MUlsd2	I Won't Let You Go	65	xEJ8tNEmGveY9g9UfKwVct	3LpLGlgRS1IKPPwElnpW35	wOvFE37RYJBq423MAkmUPr	229303	4	0.537	0.611	0	-6.427	1	0.0304	0.229	0	0.146	0.161	105.955
2U8g9wVcUu9wsg6i7sFSv8	Every Teardrop Is a Waterfall	73	ImOenLh1uEEejt7GOQp5zW	4gzpq5DPGxSnKTe4SA8HAU	wOvFE37RYJBq423MAkmUPr	240796	4	0.425	0.732	9	-6.883	1	0.0396	0.00194	0.0103	0.171	0.333	117.98
2V65y3PX4DkRhy1djlxd9p	Don't You Worry Child - Radio Edit	84	WnNBkQMHY0nHaR7xGMXNV2	1h6Cn3P4NGzXbaXidqURXs	hYKylhpPiH1VPodagRTNzu	212862	4	0.612	0.84	11	-3.145	0	0.0509	0.112	0	0.116	0.438	129.042
2vwlzO0Qp8kfEtzTsCXfyE	Wrecking Ball	82	9VBwBhONRYmFTjoS84qEIM	5YGY8feqx7naU7z4HrwZM6	h9t7HfmUClwEKkUc7f34jH	221360	4	0.53	0.422	5	-6.262	1	0.0342	0.407	0	0.107	0.349	119.964
2vXKRlJBXyOcvZYTdNeckS	Lost in the Fire (feat. The Weeknd)	85	exF1qMShRdmaDTdvOVB9BT	3hteYQFiMFbJY7wS0xDymP	QlNM9gC3Z9AwcKBBdmOIUm	202093	4	0.658	0.671	2	-12.21	1	0.0363	0.0933	0.000927	0.115	0.166	100.966
2Wo6QQD1KMDWeFkkjLqwx5	Roses - Imanbek Remix	59	7VdQTsonRGH4oe7iTJXX5G	0H39MdGGX6dbnnQPt6NQkZ	ndfd917VUIq2bOQToxPcqS	176219	4	0.785	0.721	8	-5.457	1	0.0506	0.0149	0.00432	0.285	0.894	121.962
2xGjteMU3E1tkEPVFBO08U	This Is Me	67	jKOw9QREER77NNFxM3aXVR	7HV2RI2qNug4EcQqLbCAKS	Jp4YMIf936KasPLNEymvB3	234707	4	0.284	0.704	2	-7.276	1	0.186	0.00583	0.000115	0.0424	0.1	191.702
2XHzzp1j4IfTNp1FTn7YFg	Love Me	84	qzjKn6b9XVF0WShYzSkgAo	55Aa2cqylxrFIXC767Z865	h9t7HfmUClwEKkUc7f34jH	255053	4	0.669	0.634	11	-6.476	1	0.0327	0.0125	0	0.0946	0.496	124.906
2Xnv3GntqbBH1juvUYSpHG	So Am I	73	sSFkuXpkDpBZPUlAPdlANZ	4npEfmQ6YuiwW1GpUmaq3F	QlNM9gC3Z9AwcKBBdmOIUm	183027	4	0.681	0.657	6	-4.671	1	0.0432	0.0748	0	0.353	0.628	130.089
2ygvZOXrIeVL4xZmAWJT2C	my future	73	rAr0wWEAlhy4j8vNdxOyrw	6qqNVTkY8uBg9cP3Jd7DAH	ndfd917VUIq2bOQToxPcqS	208155	4	0.444	0.309	8	-10.956	1	0.062	0.795	0.132	0.352	0.0875	104.745
2YpeDb67231RjR0MgVLzsG	Old Town Road - Remix	79	tkQF4Bcmh9ytLD6b73Jz4Y	7jVv8c5Fj3E9VhNjxT4snq	QlNM9gC3Z9AwcKBBdmOIUm	157067	4	0.878	0.619	6	-5.56	1	0.102	0.0533	0	0.113	0.639	136.041
2Z8WuEywRWYTKe1NybPQEW	Ride	85	Veo9OcOWKxRCCTh7pFDKm0	3YQKmKGau1PzlVlkL1iodx	dRZrPqTJ2iw75iSpHG7KnI	214507	4	0.645	0.713	6	-5.355	1	0.0393	0.00835	0	0.113	0.566	74.989
2Z8yfpFX0ZMavHkcIeHiO1	Monster (Shawn Mendes & Justin Bieber)	71	M1PDjVsVPSxjqDYksT9GA3	7n2wHs1TKAczGzO7Dd2rGr	ndfd917VUIq2bOQToxPcqS	178994	4	0.652	0.383	2	-7.076	0	0.0516	0.0676	0	0.0828	0.549	145.765
31zeLcKH2x3UCMHT75Gk5C	Commander	46	hMJi3w7mbPhmDXO4Mllw6b	3AuMNF8rQAKOzjYppFNAoB	Z3d7ZvFizjczhqkQnb7RXg	218107	4	0.395	0.876	11	-3.859	0	0.138	0.0173	8.46e-06	0.362	0.567	124.638
32OlwWuMpZ6b0aN2RZOeMS	Uptown Funk (feat. Bruno Mars)	85	f4zKlk4yTm8FM2YrgpZBsV	3hv9jJF3adDNsBSIQDqcjp	9wnrC2T34VLxtL7vdC8hVE	269667	4	0.856	0.609	0	-7.223	1	0.0824	0.00801	8.15e-05	0.0344	0.928	114.988
34ZAzO78a5DAVNrYIGWcPm	Shirt	73	D76Ubp5dg1VtzpZsenP22g	7tYKF4w9nC0nq9CsPZTHyP	pZxQbhuIGcA5v4a4eMVxDI	181831	4	0.824	0.453	3	-9.604	0	0.0968	0.146	0.0273	0.0896	0.552	119.959
35KiiILklye1JRRctaLUb4	Holocene	59	4AZbzBrTKlLO4EwEfYshZP	4LEiUm1SRbFMgfqnQTwUbQ	wOvFE37RYJBq423MAkmUPr	336613	4	0.374	0.304	1	-14.52	1	0.0302	0.943	0.298	0.126	0.147	147.969
35ovElsgyAtQwYPYnZJECg	Lift Me Up - From Black Panther: Wakanda Forever - Music From and Inspired By	78	k44YnYQDALbUTKnfqrw1Rs	5pKCCKE2ajJHZ9KAiaK11H	pZxQbhuIGcA5v4a4eMVxDI	196520	4	0.247	0.299	9	-6.083	1	0.0315	0.899	0	0.131	0.172	177.115
36cmM3MBMWWCFIiQ90U4J8	Bounce (feat. Kelis) - Radio Edit	64	fbgo2VmM0aYOB59uS5aJWV	7CajNmpbOovFoOoasH2HaY	wOvFE37RYJBq423MAkmUPr	222187	4	0.779	0.963	2	-2.125	0	0.0399	0.0334	0.493	0.664	0.759	127.941
37BZB0z9T8Xu7U3e65qxFy	Save Your Tears (with Ariana Grande) (Remix)	83	LjWfylLxGDRA5VnjhLCBkm	1Xyo4u8uXC1ZmMpatF05PJ	pcclfKySeZMYGS2V6uxNLn	191014	4	0.65	0.825	0	-4.645	1	0.0325	0.0215	2.44e-05	0.0936	0.593	118.091
37dYAkMa4lzRCH6kDbMT1L	We No Speak Americano (Edit)	66	Us7PErcBOp7KxKMAfAvIkX	4KkHjCe8ouh8C2P9LPoD4F	Z3d7ZvFizjczhqkQnb7RXg	157438	4	0.902	0.805	6	-5.003	1	0.0468	0.0748	0.0823	0.0914	0.745	124.985
39lS97papXAI72StGRtZBo	Wrapped Up (feat. Travie McCoy)	63	6F4SloVvfD5Dc4sMFVmY5M	3whuHq0yGx60atvA2RCVRW	KUBSaE6ulYu49hAg7vmNAR	185629	4	0.787	0.837	1	-5.419	1	0.0556	0.0926	0	0.155	0.918	122.004
3B54sVLJ402zGa6Xm4YGNe	Unforgettable	86	DLpnimNWMVvoSVIcZo99vj	6vXTefBL93Dj5IqAWq6OTv	LgCTGYUwup3J1TSMRyObZA	233902	4	0.726	0.769	6	-5.043	1	0.123	0.0293	0.0101	0.104	0.733	97.985
3bidbhpOYeV4knp8AIu8Xn	Can't Hold Us (feat. Ray Dalton)	83	evNI7LJKF5hsJy1POUwaQS	5BcAKTbp20cv7tC5VqPFoC	h9t7HfmUClwEKkUc7f34jH	258343	4	0.641	0.922	2	-4.457	1	0.0786	0.0291	0	0.0862	0.847	146.078
3cHyrEgdyYRjgJKSOiOtcS	Timber (feat. Ke$ha)	84	tHapRMl6Sd4dfLdsgKbfs2	0TnOYISbd1XYRBk9myaseg	KUBSaE6ulYu49hAg7vmNAR	204160	4	0.581	0.963	11	-4.087	1	0.0981	0.0295	0	0.139	0.788	129.992
3Dv1eDb0MEgF93GpLXlucZ	Say So	80	XVIxRoUeucGvDOaSkh4ZwZ	5cj0lLjcoR7YOSnhnX0Po5	ndfd917VUIq2bOQToxPcqS	237893	4	0.787	0.673	11	-4.583	0	0.159	0.264	3.35e-06	0.0904	0.779	110.962
3e0yTP5trHBBVvV32jwXqF	Anna Sun	65	zc2fqZvKJWwaseCGTIHPjD	6DIS6PRrLS3wbnZsf7vYic	hYKylhpPiH1VPodagRTNzu	321280	4	0.472	0.844	10	-6.578	1	0.054	0.00173	0	0.24	0.34	140.034
3e9HZxeyfWwjeyPAMmWSSQ	thank u, next	82	XuPFuHysdMjwv8Iu9568Uc	66CXWjxzNUsdJxJ2JdwvnR	QlNM9gC3Z9AwcKBBdmOIUm	207320	4	0.717	0.653	1	-5.634	1	0.0658	0.229	0	0.101	0.412	106.966
3F5CgOj3wFlRv51JsHbxhe	Jimmy Cooks (feat. 21 Savage)	89	kPz9RlLEkOgX5mNwkv0BS8	3TVXtAsR1Inumwj472S9r4	pZxQbhuIGcA5v4a4eMVxDI	218365	4	0.529	0.673	0	-4.711	1	0.175	0.000307	2.41e-06	0.093	0.366	165.921
3FAJ6O0NOHQV8Mc5Ri6ENp	Heartbreak Anniversary	82	a08tldRUjMYfFApgu7tuBt	4fxd5Ee7UefO4CUXgwJ7IP	pcclfKySeZMYGS2V6uxNLn	198371	3	0.449	0.465	0	-8.964	1	0.0791	0.524	1.02e-06	0.303	0.543	89.087
3FrX3mx8qq7SZX2NYbzDoj	Who's That Chick? (feat. Rihanna)	59	jigQYZRG2pWIkSrpm068jn	1Cs0zKBU1kc0i8ypK3B9ai	wOvFE37RYJBq423MAkmUPr	201040	4	0.675	0.601	11	-4.733	0	0.116	0.00372	0	0.0458	0.931	127.938
3GBApU0NuzH4hKZq4NOSdA	What You Know	76	emCDmCsjbrH8WC2D3Qm4U7	536BYVgOnRky0xjsPT96zl	Z3d7ZvFizjczhqkQnb7RXg	191707	4	0.563	0.739	6	-4.239	0	0.0416	0.00073	1.45e-05	0.0822	0.775	139
3GCdLUSnKSMJhs4Tj6CV3s	All The Stars (with SZA)	86	gSv7qTs8eStrHWORg5hYWq	2YZyLoL8N0Wb9xBt1NhZWg	Jp4YMIf936KasPLNEymvB3	232187	4	0.698	0.633	8	-4.946	1	0.0597	0.0605	0.000194	0.0926	0.552	96.924
3hsmbFKT5Cujb5GQjqEU39	Look At Me Now (feat. Lil' Wayne & Busta Rhymes)	74	QNuiqGtNXLsy08bRj50abu	7bXgB6jMjp9ATFy66eO08Z	wOvFE37RYJBq423MAkmUPr	222587	4	0.767	0.677	11	-6.128	0	0.184	0.0339	5.51e-06	0.144	0.538	146.155
3IAfUEeaXRX9s9UdKOJrFI	Envolver	76	Nrga2Ot6f9oSe0pdN54WaM	7FNnA9vBm6EKceENgCGRMb	pZxQbhuIGcA5v4a4eMVxDI	193806	4	0.812	0.736	4	-5.421	0	0.0833	0.152	0.00254	0.0914	0.396	91.993
3iH29NcCxYgI5shlkZrUoB	gone girl	67	29sRiZo2KJyxveON9iEUcT	6ASri4ePR7RlsvIQgWPJpS	QlNM9gC3Z9AwcKBBdmOIUm	136568	4	0.677	0.714	11	-5.637	1	0.0287	0.162	0	0.0717	0.355	94.956
3jjujdWJ72nww5eGnfs2E7	Adore You	86	kA31sEW2pWHlJrIbmojmKa	6KImCVD70vtIoJWnq6nGn3	ndfd917VUIq2bOQToxPcqS	207133	4	0.676	0.771	8	-3.675	1	0.0483	0.0237	7e-06	0.102	0.569	99.048
3JvKfv6T31zO0ini8iNItO	Another Love	91	eqMeD7j7bFidg4DycLuRu1	2txHhyCwHjUEpJjWrEyqyX	h9t7HfmUClwEKkUc7f34jH	244360	4	0.445	0.537	4	-8.532	0	0.04	0.695	1.65e-05	0.0944	0.131	122.769
3LtpKP5abr2qqjunvjlX5i	Doja	86	cFB18eEGbRNU8XdoFXtYBY	5H4yInM5zmHqpKIoMNAx4r	pZxQbhuIGcA5v4a4eMVxDI	97393	4	0.911	0.573	6	-7.43	1	0.288	0.38	0	0.403	0.972	140.04
3LUWWox8YYykohBbHUrrxd	We R Who We R	74	7bFiUSt3TpvpzPlt2Nt3cu	6LqNN22kT3074XbTVUrhzX	wOvFE37RYJBq423MAkmUPr	204760	4	0.736	0.817	8	-4.9	1	0.0407	0.00987	0.00167	0.117	0.653	119.95
3n69hLUdIsSa1WlRmjMZlW	Breezeblocks	74	SgkHoIMsTYrKlkvWXc3uLT	3XHO7cRUPCLOr6jwp8vsx5	hYKylhpPiH1VPodagRTNzu	227080	4	0.615	0.658	5	-7.299	1	0.0343	0.096	0.000911	0.205	0.293	150.093
3nB82yGjtbQFSU0JLAwLRH	Not a Bad Thing	57	tLH5k4hITUqa2vMlJ8kqrf	31TPClRtHm23RisEBtV3X7	KUBSaE6ulYu49hAg7vmNAR	688453	4	0.308	0.563	0	-9.169	1	0.0719	0.527	4.58e-06	0.134	0.109	85.901
3nqQXoyQOWXiESFLlDF1hG	Unholy (feat. Kim Petras)	87	vadGh32RPfmGgXgVDuvVaA	2wY79sveU1sp5g7SokKOiI	pZxQbhuIGcA5v4a4eMVxDI	156943	4	0.714	0.472	2	-7.375	1	0.0864	0.013	4.51e-06	0.266	0.238	131.121
3nY8AqaMNNHHLYV4380ol0	Dick (feat. Doja Cat)	71	PoR7IBAE6GMuTNMWtq4Y2N	2WgfkM8S11vg4kxLgDY3F5	pcclfKySeZMYGS2V6uxNLn	175238	4	0.647	0.608	9	-6.831	1	0.42	0.13	0	0.0584	0.474	125.994
3O8NlPh2LByMU9lSRSHedm	Controlla	75	rEjj5noxgRHDXwN31NOuF9	3TVXtAsR1Inumwj472S9r4	dRZrPqTJ2iw75iSpHG7KnI	245227	4	0.59	0.468	10	-11.083	0	0.185	0.0789	0	0.101	0.349	92.287
3Ofmpyhv5UAQ70mENzB277	Astronaut In The Ocean	77	ACYbRJ2CwobghFSijBlMbp	1uU7g3DNSbsu0QjSEqZtEd	pcclfKySeZMYGS2V6uxNLn	132780	4	0.778	0.695	4	-6.865	0	0.0913	0.175	0	0.15	0.472	149.996
3oL3XRtkP1WVbMxf7dtTdu	The One That Got Away	73	LotvOKuFl91BpsqnAcFcGl	6jJ0s89eD6GaHleKKya26X	hYKylhpPiH1VPodagRTNzu	227333	4	0.687	0.792	1	-4.023	0	0.0353	0.000802	0	0.2	0.864	133.962
3pXF1nA74528Edde4of9CC	Don't	85	HtV5W9zq946ik1fWri27mh	2EMAnMvWE2eb56ToJVfCWs	dRZrPqTJ2iw75iSpHG7KnI	198293	4	0.765	0.356	11	-5.556	0	0.195	0.223	0	0.0963	0.189	96.991
3pYDZTJM2tVBUhIRifWVzI	Blow	71	7bFiUSt3TpvpzPlt2Nt3cu	6LqNN22kT3074XbTVUrhzX	wOvFE37RYJBq423MAkmUPr	219973	4	0.753	0.729	11	-3.862	0	0.0392	0.00334	5.66e-05	0.073	0.812	120.013
3QGsuHI8jO1Rx4JWLUh9jd	Treat You Better	87	VIFdrPq5rp0E4AMbRsPhNa	7n2wHs1TKAczGzO7Dd2rGr	dRZrPqTJ2iw75iSpHG7KnI	187973	4	0.444	0.819	10	-4.078	0	0.341	0.106	0	0.107	0.747	82.695
3RiPr603aXAoi4GHyXx0uy	Hymn for the Weekend	85	HQvngT6gmiHngziPYrggbh	4gzpq5DPGxSnKTe4SA8HAU	dRZrPqTJ2iw75iSpHG7KnI	258267	4	0.491	0.693	0	-6.487	0	0.0377	0.211	6.92e-06	0.325	0.412	90.027
3rWDp9tBPQR9z6U5YyRSK4	Midnight Rain	86	fkrdol9gOidN8J4Q4M3nGW	06HL4z0CvFAxyc27GXpf02	pZxQbhuIGcA5v4a4eMVxDI	174783	4	0.643	0.363	0	-11.738	1	0.0767	0.69	5.17e-05	0.115	0.23	139.865
3sP3c86WFjOzHHnbhhZcLA	Give Your Heart a Break	72	LiXuGJE3IZx6wluOIsLmES	6S2OmqARrzebs0tKUEyXyp	hYKylhpPiH1VPodagRTNzu	205347	4	0.651	0.695	6	-3.218	1	0.0487	0.23	0	0.144	0.569	123.008
3SxiAdI8dP9AaaEz1Z24mn	Earthquake (feat. Tinie Tempah)	62	3i38MFcKyAnvyeIa0I1txv	2feDdbD5araYcm6JhFHHw7	wOvFE37RYJBq423MAkmUPr	274600	4	0.54	0.856	0	-3.966	0	0.1	0.109	0	0.276	0.258	153.071
3TGRqZ0a2l1LRblBkJoaDx	Call Me Maybe	76	ZelCwRi4p9qHEru9QnDCMi	6sFIWsNpZYqfjUpaCgueju	hYKylhpPiH1VPodagRTNzu	193400	4	0.783	0.58	7	-6.548	1	0.0408	0.0114	2.28e-06	0.108	0.66	120.021
3tjFYV6RSFtuktYl3ZtYcq	Mood (feat. iann dior)	6	l9RS6OpmaT1fjQghbTNbjb	6fWVd57NKTalqvmjRd2t8Z	ndfd917VUIq2bOQToxPcqS	140526	4	0.7	0.722	7	-3.558	0	0.0369	0.221	0	0.272	0.756	90.989
3Tu7uWBecS6GsLsL8UONKn	Don't Stop the Party (feat. TJR)	68	tHapRMl6Sd4dfLdsgKbfs2	0TnOYISbd1XYRBk9myaseg	h9t7HfmUClwEKkUc7f34jH	206120	4	0.722	0.958	4	-3.617	1	0.0912	0.00726	0	0.375	0.952	127.008
3tyPOhuVnt5zd5kGfxbCyL	Where Have You Been	74	1lWEQkbaJXdisnwHwanXTO	5pKCCKE2ajJHZ9KAiaK11H	hYKylhpPiH1VPodagRTNzu	242680	4	0.719	0.847	0	-6.34	0	0.0916	0.00201	0.0204	0.223	0.444	127.963
3U4isOIWM3VvDubwSI3y7a	All of Me	87	gtwdIQz5p2IQRMCNcuPuUZ	5y2Xq6xcjJb2jVM54GHK3t	KUBSaE6ulYu49hAg7vmNAR	269560	4	0.422	0.264	8	-7.064	1	0.0322	0.922	0	0.132	0.331	119.93
3uIGef7OSXkFdqxjFWn2o6	Gold Dust - Radio Edit	65	WISE6xmS5ARCPYnk1oYsKk	6r20qOqY7qDWI0PPTxVMlC	Z3d7ZvFizjczhqkQnb7RXg	192447	4	0.451	0.948	0	-0.74	1	0.147	0.255	0	0.392	0.295	176.985
3VA8T3rNy5V24AXxNK5u9E	King of Anything	63	RNaK5VPqa1HX4XjqNUxcVf	2Sqr0DXoaYABbjBo9HaMkM	Z3d7ZvFizjczhqkQnb7RXg	207493	4	0.676	0.762	1	-4.172	1	0.0351	0.461	0	0.0574	0.81	119.003
3VqeTFIvhxu3DIe4eZVzGq	Butter	9	DDDRgCngHduf4ZcIVgZeiB	3Nrfpe0tUJi4K4DXYWgMUX	pcclfKySeZMYGS2V6uxNLn	164442	4	0.759	0.459	8	-5.187	1	0.0948	0.00323	0	0.0906	0.695	109.997
3WD91HQDBIavSapet3ZpjG	Video Games	71	yWvd7fahChwMerfh17getm	00FQb4jTyendYWaN8pK0wa	hYKylhpPiH1VPodagRTNzu	281947	4	0.39	0.252	6	-9.666	0	0.0298	0.808	0	0.0887	0.181	122.053
3Wrjm47oTz2sjIgck11l5e	Beggin'	85	1RBvSmcI9Vb5SZvQxT5EOQ	0lAWpj5szCSwM4rUMHYmrr	pcclfKySeZMYGS2V6uxNLn	211560	4	0.714	0.8	11	-4.808	0	0.0504	0.127	0	0.359	0.589	134.002
3xKsf9qdS1CyvXSMEid6g8	Pink + White	90	AaMOSu3E3DOhDwTN2UjQeX	2h93pZq0e7k5yf4dywlkpM	dRZrPqTJ2iw75iSpHG7KnI	184516	3	0.545	0.545	9	-7.362	1	0.107	0.667	5.48e-05	0.417	0.549	159.94
3XOalgusokruzA5ZBA2Qcb	pushin P (feat. Young Thug)	77	v858bIrHx2xJn8q67vRS8s	2hlmm7s2ICUX0LVIhVFlZQ	pZxQbhuIGcA5v4a4eMVxDI	136267	1	0.773	0.422	1	-4.572	0	0.187	0.00783	0.00693	0.129	0.488	77.502
3YJJjQPAbDT7mGpX3WtQ9A	Good Days	81	Wd2zsPWac3xINaibmNl05I	7tYKF4w9nC0nq9CsPZTHyP	pcclfKySeZMYGS2V6uxNLn	279204	4	0.436	0.655	1	-8.37	0	0.0583	0.499	8.1e-06	0.688	0.412	121.002
3ZCTVFBt2Brf31RLEnCkWJ	everything i wanted	86	35cikXHHKHaFvIalZZonbq	6qqNVTkY8uBg9cP3Jd7DAH	ndfd917VUIq2bOQToxPcqS	245426	4	0.704	0.225	6	-14.454	0	0.0994	0.902	0.657	0.106	0.243	120.006
3ZdJffjzJWFimSQyxgGIxN	Just A Dream	77	4SPvfqOkFTrAcl2CW3sTwd	2gBjLmx6zQnFGQJCAQpRgw	Z3d7ZvFizjczhqkQnb7RXg	237800	4	0.531	0.752	1	-6.161	1	0.0305	0.0421	0	0.12	0.103	89.917
3zHq9ouUJQFQRf3cm1rRLu	Love Me Like You Do - From "Fifty Shades Of Grey"	80	Eip5OsdTNeXizV4v6qU72R	0X2BH1fck6amBIoJhDVmmJ	9wnrC2T34VLxtL7vdC8hVE	252534	4	0.262	0.606	8	-6.646	1	0.0484	0.247	0	0.125	0.275	189.857
3zsRP8rH1kaIAo9fmiP4El	Angels	65	ikhmhB4Q9U2EHzwTCGB7tp	3iOvXCl6edW5Um0fXEBRXy	hYKylhpPiH1VPodagRTNzu	171653	4	0.424	0.157	9	-18.141	1	0.0428	0.95	0.0593	0.101	0.342	91.537
40iJIUlhi6renaREYGeIDS	Fair Trade (with Travis Scott)	86	sm6SW9eXP9ziQSAXxiAdYD	3TVXtAsR1Inumwj472S9r4	pcclfKySeZMYGS2V6uxNLn	291175	4	0.666	0.465	1	-8.545	1	0.26	0.0503	0	0.215	0.292	167.937
41KPpw0EZCytxNkmEMJVgr	One - Radio Edit	63	mo729wukfvVSH2AjaA5CwA	1h6Cn3P4NGzXbaXidqURXs	Z3d7ZvFizjczhqkQnb7RXg	169920	4	0.802	0.781	0	-6.564	1	0.0368	0.0075	0.825	0.147	0.622	125.026
439TlnnznSiBbQbgXiBqAd	m.A.A.d city	70	OR4ULWr1g3kXH6uOrvpNe1	2YZyLoL8N0Wb9xBt1NhZWg	hYKylhpPiH1VPodagRTNzu	350120	4	0.487	0.729	2	-6.815	1	0.271	0.0538	4.07e-06	0.44	0.217	91.048
43zdsphuZLzwA9k4DJhU0I	when the party's over	85	sXF5w1SSO7BOUBh4oeTXl2	6qqNVTkY8uBg9cP3Jd7DAH	QlNM9gC3Z9AwcKBBdmOIUm	196077	4	0.367	0.111	4	-14.084	1	0.0972	0.978	3.97e-05	0.0897	0.198	82.642
45O0tUN9Bh6LH4eNxQ07AT	Eenie Meenie	67	vIxSJkLp4IrMoBlkP9YZoB	6S0dmVVn4udvppDhZIWxCr	Z3d7ZvFizjczhqkQnb7RXg	201653	4	0.734	0.639	1	-3.241	1	0.0316	0.0348	0	0.102	0.836	121.212
45XhKYRRkyeqoW3teSOkCM	Wild Thoughts (feat. Rihanna & Bryson Tiller)	70	TQVZvYPr9GUjqcv7gIVYew	0QHgL1lAIqAw0HtD7YldmP	LgCTGYUwup3J1TSMRyObZA	204664	4	0.613	0.681	8	-3.089	1	0.0778	0.0287	0	0.126	0.619	97.621
463CkQjx2Zk1yXoBuierM9	Levitating (feat. DaBaby)	75	doPGwSUx5FdVcIefJv58SM	6M2wZ9GZgrQXHCFfjv46we	pcclfKySeZMYGS2V6uxNLn	203064	4	0.702	0.825	6	-3.787	0	0.0601	0.00883	0	0.0674	0.915	102.977
4AYX69oFP3UOS1CFmV9UfO	Bottoms Up (feat. Nicki Minaj)	74	F5UM2SnLkH0ySd08KbzhPi	2iojnBLj0qIMiKPvVhLnsH	Z3d7ZvFizjczhqkQnb7RXg	242013	4	0.844	0.601	1	-5.283	1	0.157	0.0205	0	0.385	0.331	73.989
4B0JvthVoAAuygILe3n4Bs	What Do You Mean?	80	OhyCRR8AAeIniOkxEEUChH	1uNFoZAHBGtllmzznpCI3s	9wnrC2T34VLxtL7vdC8hVE	205680	4	0.845	0.567	5	-8.118	0	0.0956	0.59	0.00142	0.0811	0.793	125.02
4b4c0oH7PtrPsI86drzgFs	Chasing The Sun	70	WA8Exu53HfVCvGqU1Kz0fr	2NhdGz9EDv2FeUw6udu2g1	hYKylhpPiH1VPodagRTNzu	198800	4	0.637	0.732	7	-6.209	0	0.0965	0.244	0	0.498	0.68	128.108
4BycRneKmOs6MhYG9THsuX	Find Your Love	70	1mbH9U7RhYZgALbPOeNd1a	3TVXtAsR1Inumwj472S9r4	Z3d7ZvFizjczhqkQnb7RXg	208947	4	0.627	0.614	6	-6.006	0	0.17	0.0211	0	0.0286	0.758	96.038
4C6Uex2ILwJi9sZXRdmqXp	Super Freaky Girl	78	QXMrsyu17ghvbLa4hLSdE6	0hCNtLu0JehylgoiP8L4Gh	pZxQbhuIGcA5v4a4eMVxDI	170977	4	0.95	0.891	2	-2.653	1	0.241	0.0645	1.77e-05	0.309	0.912	133.01
4cluDES4hQEUhmXj6TXkSo	What Makes You Beautiful	86	E3dHnYJCqOd871PkZLV9px	4AK6F7OLvEQ5QYCBNiQWHq	hYKylhpPiH1VPodagRTNzu	199987	4	0.726	0.787	4	-2.494	1	0.0737	0.009	0	0.0596	0.888	124.99
4dTaAiV9xFFCxnPur9c9yL	Memories (feat. Kid Cudi)	70	q69nlgYe2EDdf7CZUfwIuy	1Cs0zKBU1kc0i8ypK3B9ai	Z3d7ZvFizjczhqkQnb7RXg	210093	4	0.561	0.87	8	-6.103	1	0.343	0.0015	2.82e-06	0.246	0.498	129.98
4EAV2cKiqKP5UPZmY6dejk	Everyday	68	24dEITbt61Jlluhm2IauKp	4xRYI6VqpkE3UwrDrAZL8L	Jp4YMIf936KasPLNEymvB3	204747	4	0.667	0.741	1	-4.099	1	0.0378	0.0425	0	0.0761	0.422	149.908
4fINc8dnfcz7AdhFYVA4i7	It Girl	71	1GRaLygoEdn4QrbxgMDqiH	07YZf4WDAMNwqr4jfgOZ8y	wOvFE37RYJBq423MAkmUPr	192200	4	0.668	0.718	1	-4.736	0	0.0605	0.0165	0	0.104	0.345	91.993
4fouWK6XVHhzl78KzQ1UjL	abcdefu	83	3CQwlqS0IrFyJqsSwmxL9W	2VSHKHBTiXWplO8lxcnUC9	pZxQbhuIGcA5v4a4eMVxDI	168602	4	0.695	0.54	4	-5.692	1	0.0493	0.299	0	0.367	0.415	121.932
4fSIb4hdOQ151TILNsSEaF	Todo De Ti	79	CdqGklcc9HWxibcFUI6eOE	1mcTU81TzQhprhouKaTkpq	pcclfKySeZMYGS2V6uxNLn	199604	4	0.78	0.718	3	-3.605	0	0.0506	0.31	0.000163	0.0932	0.342	127.949
4G8gkOterJn0Ywt6uhqbhp	Radioactive	75	nuVKfXQ8vbvFRU9eq7qfUf	53XhwfbYqKCa1cC15pYq2q	h9t7HfmUClwEKkUc7f34jH	186813	4	0.448	0.784	9	-3.686	1	0.0627	0.106	0.000108	0.668	0.236	136.245
4gbVRS8gloEluzf0GzDOFc	Maps	86	avHL55XdULYRbi7pc24Uog	04gDigrS5kc9YWfZHwBETP	KUBSaE6ulYu49hAg7vmNAR	189960	4	0.742	0.713	1	-5.522	0	0.0303	0.0205	0	0.059	0.879	120.032
4gs07VlJST4bdxGbBsXVue	Heartbreak Warfare	66	0C4KIWtMQEPWb6y85RoFRN	0hEurMDQu99nJRq8pTxO14	Z3d7ZvFizjczhqkQnb7RXg	269720	4	0.624	0.554	2	-8.113	1	0.0225	0.191	0.00131	0.299	0.311	97.031
4h9wh7iOZ0GGn8QVp4RAOB	I Ain't Worried	92	JNAhPOQM69cvaaDsNGkZNt	5Pwc4xIPtQLFEnJriah9YJ	pZxQbhuIGcA5v4a4eMVxDI	148486	4	0.704	0.797	0	-5.927	1	0.0475	0.0826	0.000745	0.0546	0.825	139.994
4HlFJV71xXKIGcU3kRyttv	Hey, Soul Sister	85	7um1fHKjXG26KPF4oE6PS9	3FUY2gzHeIiaesXtOAdB7A	Z3d7ZvFizjczhqkQnb7RXg	216773	4	0.673	0.886	1	-4.44	0	0.0431	0.185	0	0.0826	0.795	97.012
4HXOBjwv2RnLpGG4xWOO6N	Princess of China	72	ImOenLh1uEEejt7GOQp5zW	4gzpq5DPGxSnKTe4SA8HAU	hYKylhpPiH1VPodagRTNzu	239216	4	0.42	0.69	9	-6.221	0	0.0347	0.00385	0.015	0.287	0.237	85.014
4iJyoBOLtHqaGxP12qzhQI	Peaches (feat. Daniel Caesar & Giveon)	84	9Zp669b3CjPBb7VuSKQrDE	1uNFoZAHBGtllmzznpCI3s	pcclfKySeZMYGS2V6uxNLn	198082	4	0.677	0.696	0	-6.181	1	0.119	0.321	0	0.42	0.464	90.03
4k6Uh1HXdhtusDW5y8Gbvy	Bad Habit	84	KDIGkNG694DeELip5VX7JW	57vWImR43h4CaDao012Ofp	pZxQbhuIGcA5v4a4eMVxDI	232067	4	0.686	0.494	1	-7.093	1	0.0355	0.613	5.8e-05	0.402	0.7	168.946
4kte3OcW800TPvOVgrLLj8	Let Me Love You (Until You Learn To Love Yourself)	70	jdvZsuG3il71XS0eeHJmlE	21E3waRsmPlU7jZsS13rcj	hYKylhpPiH1VPodagRTNzu	251627	4	0.658	0.677	5	-6.628	1	0.0393	0.248	0	0.368	0.248	124.91
4Kz4RdRCceaA9VgTqBhBfa	The Motto	77	hNMm9cGL2SgdkoeZr0QqAA	3TVXtAsR1Inumwj472S9r4	hYKylhpPiH1VPodagRTNzu	181573	4	0.766	0.442	1	-8.558	1	0.356	0.000107	6.12e-05	0.111	0.39	201.8
4l0Mvzj72xxOpRrp6h8nHi	Lose You To Love Me	83	F6S5gbLagjHutcSnMyxnbX	0C8ZW7ezQVs4URX5aX7Kqx	QlNM9gC3Z9AwcKBBdmOIUm	206459	4	0.488	0.343	4	-8.985	1	0.0436	0.556	0	0.21	0.0978	102.819
4LEK9rD7TWIG4FCL1s27XC	cardigan	53	lyh9dhdY7SFvLeiUnkFX2d	06HL4z0CvFAxyc27GXpf02	ndfd917VUIq2bOQToxPcqS	239560	4	0.613	0.581	0	-8.588	0	0.0424	0.537	0.000345	0.25	0.551	130.033
4LRPiXqCikLlN15c3yImP7	As It Was	90	Vm4vNAZPz2gaOgA2AmHGqt	6KImCVD70vtIoJWnq6nGn3	pZxQbhuIGcA5v4a4eMVxDI	167303	4	0.52	0.731	6	-5.338	0	0.0557	0.342	0.00101	0.311	0.662	173.93
4N1MFKjziFHH4IS3RYYUrU	My Love	76	KtrCTSJhbbpviHk8XFoJOE	1dgdvbogmctybPrGEcnYf6	KUBSaE6ulYu49hAg7vmNAR	259934	4	0.813	0.616	8	-7.571	1	0.0495	0.000132	0.705	0.0658	0.744	119.977
4NTWZqvfQTlOMitlVn6tew	The Show Goes On	72	uyTzUQk55xvwquRlUoHNfc	01QTIT5P1pFP3QnnFSdsJf	wOvFE37RYJBq423MAkmUPr	239613	4	0.591	0.889	7	-3.839	1	0.115	0.0189	0	0.155	0.65	143.067
4nVBt6MZDDP6tRVdQTgxJg	Story of My Life	84	xhC6tcM42ulhDUOtMnT2Tg	4AK6F7OLvEQ5QYCBNiQWHq	KUBSaE6ulYu49hAg7vmNAR	245493	4	0.6	0.663	3	-5.802	1	0.0477	0.225	0	0.119	0.286	121.07
4P0osvTXoSYZZC2n8IFH3c	Payphone	73	uosfX9zpJByYEPgsuzkfH3	04gDigrS5kc9YWfZHwBETP	hYKylhpPiH1VPodagRTNzu	231387	4	0.739	0.756	4	-4.828	1	0.0394	0.0136	0	0.37	0.523	110.028
4pAl7FkDMNBsjykPXo91B3	Needed Me	83	f4FOUbugWrhDPurM39XEwx	5pKCCKE2ajJHZ9KAiaK11H	dRZrPqTJ2iw75iSpHG7KnI	191600	4	0.671	0.314	5	-8.091	0	0.244	0.11	0	0.0825	0.296	110.898
4pi1G1x8tl9VfdD9bL3maT	Big Energy	69	RASyPkhsdLDco9RSYEufbo	3MdXrJWsbVzdn6fe5JYkSQ	pZxQbhuIGcA5v4a4eMVxDI	172540	4	0.937	0.793	11	-4.431	0	0.115	0.0453	0	0.341	0.794	106.022
4pt5fDVTg5GhEvEtlz9dKk	I WANNA BE YOUR SLAVE	83	B1l1c1kijmZsKluOBjiLMw	0lAWpj5szCSwM4rUMHYmrr	pcclfKySeZMYGS2V6uxNLn	173347	4	0.75	0.608	1	-4.008	1	0.0387	0.00165	0	0.178	0.958	132.507
4qikXelSRKvoCqFcHLB2H2	Mercy	74	HGWMZZtvNmADnk0XbDW5oB	5K4W6rqBFWDnAN6FQUkS6x	hYKylhpPiH1VPodagRTNzu	329320	4	0.563	0.496	6	-9.381	0	0.406	0.0685	5.8e-05	0.173	0.426	139.993
4r6eNCsrZnQWJzzvFh4nlg	Firework	73	f1GOmd2yu5vAj5n9dOu4Nd	6jJ0s89eD6GaHleKKya26X	wOvFE37RYJBq423MAkmUPr	227893	4	0.638	0.832	8	-5.039	1	0.049	0.141	0	0.113	0.648	124.071
4rHZZAmHpZrA3iH5zx8frV	Mirrors	81	9ByWgmy0wGnW83XMMqKIM4	31TPClRtHm23RisEBtV3X7	h9t7HfmUClwEKkUc7f34jH	484147	4	0.574	0.512	5	-6.664	0	0.0503	0.234	0	0.0946	0.512	76.899
4RL77hMWUq35NYnPLXBpih	Skinny Love	74	q9Pj1cGCCbeehT9c9gswKt	2WX2uTcsvV5OnS0inACecP	wOvFE37RYJBq423MAkmUPr	201080	4	0.379	0.29	4	-8.485	1	0.051	0.952	0.00106	0.118	0.169	166.467
4RVwu0g32PAqgUiJoXsdF8	Happier Than Ever	88	iQz5Hn5sSVoxaty4ShaRnT	6qqNVTkY8uBg9cP3Jd7DAH	pcclfKySeZMYGS2V6uxNLn	298899	3	0.332	0.225	0	-8.697	1	0.0348	0.767	0.00349	0.128	0.297	81.055
4sOX1nhpKwFWPvoMMExi3q	Primadonna	74	mSCd3tK6a9A0ZJkn0PNrgt	6CwfuxIqcltXDGjfZsMd9A	hYKylhpPiH1VPodagRTNzu	221075	4	0.66	0.689	4	-2.671	0	0.0337	0.0884	0	0.0922	0.427	127.98
4TCL0qqKyqsMZml0G3M9IM	Telephone	75	5WTRyrgd7TcTXUGfut79fO	1HY2Jd0NmPuamShAr6KMms	Z3d7ZvFizjczhqkQnb7RXg	220640	4	0.824	0.836	3	-5.903	1	0.0404	0.00521	0.000817	0.112	0.716	122.014
4u26EevCNXMhlvE1xFBJwX	If I Die Young	69	sla8XwqUbMQyNtasS4HQhT	75FnCoo4FBxH5K1Rrx0k5A	Z3d7ZvFizjczhqkQnb7RXg	222773	4	0.606	0.497	4	-6.611	1	0.0277	0.348	0	0.275	0.362	130.739
4wCmqSrbyCgxEXROQE6vtV	Somebody That I Used To Know	77	PcOL2N8jDroVXvlWnEi8fQ	2AsusXITU8P25dlRNhcAbG	hYKylhpPiH1VPodagRTNzu	244973	4	0.864	0.495	0	-7.036	1	0.037	0.591	0.000133	0.0992	0.72	129.062
4xqrdfXkTW4T0RauPLv3WA	Heather	87	kWTu8vPXjhMONiTWqtIfLp	4Uc8Dsxct0oMqx0P6i60ea	ndfd917VUIq2bOQToxPcqS	198040	3	0.357	0.425	5	-7.301	1	0.0333	0.584	0	0.322	0.27	102.078
4YYHgF9dWyVSor0GtrBzdf	Te Amo	71	ApKUCnrZX8mCPqWJDxsDmI	5pKCCKE2ajJHZ9KAiaK11H	Z3d7ZvFizjczhqkQnb7RXg	208427	4	0.567	0.707	8	-5.455	0	0.0818	0.541	0.000176	0.1	0.751	171.917
4z7gh3aIZV9arbL9jJSc5J	Ghost	58	aBi3wyQwTCV9uABO9HpEXV	7nDsS0l5ZAzMedVRKPP8F1	KUBSaE6ulYu49hAg7vmNAR	213213	4	0.68	0.84	9	-3.823	1	0.0414	0.0457	8.66e-06	0.143	0.468	104.975
50kpGaPAhYJ3sGmk6vplg0	Love Yourself	86	OhyCRR8AAeIniOkxEEUChH	1uNFoZAHBGtllmzznpCI3s	dRZrPqTJ2iw75iSpHG7KnI	233720	4	0.609	0.378	4	-9.828	1	0.438	0.835	0	0.28	0.515	100.418
52gvlDnre9craz9dKGObp8	La La La	60	PhWiBZouTZ1ZAo6nQgEDSV	1bT7m67vi78r2oqvxrP3X5	h9t7HfmUClwEKkUc7f34jH	220779	4	0.754	0.677	6	-4.399	0	0.0316	0.112	0	0.111	0.254	124.988
52xJxFP6TqMuO4Yt0eOkMz	We Don't Talk About Bruno	77	kh17ptYU8O3m5tIuh6jqh1	29PgYEggDV3cDP9QYTogwv	pZxQbhuIGcA5v4a4eMVxDI	216120	4	0.577	0.45	0	-8.516	0	0.0834	0.357	0	0.111	0.83	205.863
53DB6LJV9B8sz0p1s6tlGS	Roll Up	64	C5s9wwJwNyhYWobotXxF4P	137W8MRPWKqSmrBGDBFSop	wOvFE37RYJBq423MAkmUPr	227773	5	0.523	0.805	3	-5.473	1	0.192	0.0524	0	0.0914	0.602	125.358
53QF56cjZA9RTuuMZDrSA6	I Won't Give Up	73	aN1PmNMxfb9FRNhYouFfu1	4phGZZrJZRo4ElhRtViYdl	hYKylhpPiH1VPodagRTNzu	240166	3	0.483	0.303	4	-10.058	1	0.0429	0.694	0	0.115	0.139	133.406
55h7vJchibLdUkxdlX3fK7	Treasure	83	MrAPjitwjDPsSMKcFaz5wU	0du5cEVh5yTK9QJze8zA0C	h9t7HfmUClwEKkUc7f34jH	178560	4	0.874	0.692	5	-5.28	0	0.0431	0.0412	7.24e-05	0.324	0.937	116.017
56sxN1yKg1dgOZXBcAHkJG	Gone, Gone, Gone	75	vk68LIqlyOoM0W3tijKxYs	6p5JxpTc7USNnBnLzctyd4	hYKylhpPiH1VPodagRTNzu	209693	4	0.664	0.642	6	-5.961	1	0.038	0.129	0	0.114	0.501	118.002
58kZ9spgxmlEznXGu6FPdQ	Sick Boy	69	hKjQPi3h4dYfCusLglkKlF	69GGBxA162lTqCwzJG5jLp	Jp4YMIf936KasPLNEymvB3	193200	4	0.663	0.577	11	-7.518	0	0.0531	0.109	0	0.12	0.454	89.996
59CfNbkERJ3NoTXDvoURjj	Boyfriend	82	Km8FhoBBZYo6BZaG3WP2Zk	2W8yFh0Ga6Yf3jiayVxwkE	pZxQbhuIGcA5v4a4eMVxDI	153000	3	0.345	0.612	7	-6.543	0	0.0608	0.232	0	0.194	0.232	179.773
5BhsEd82G0Mnim0IUH6xkT	Cruise	61	Lbx5pN5KCnnni67Zvkro4u	3b8QkneNDz4JHKKKlLgYZg	h9t7HfmUClwEKkUc7f34jH	208960	4	0.457	0.948	10	-3.364	1	0.0354	0.0191	0	0.0536	0.878	148
5BJSZocnCeSNeYMj3iVqM7	Love Runs Out	64	SKZyDF66bl5uEXFdL14Wq8	5Pwc4xIPtQLFEnJriah9YJ	KUBSaE6ulYu49hAg7vmNAR	224227	4	0.719	0.935	7	-3.752	1	0.0589	0.167	0	0.0973	0.738	120.022
5BoIP8Eha5hwmRVURkC2Us	In My Head	64	ibkYLnbNzNgsJCPKFHjYiJ	07YZf4WDAMNwqr4jfgOZ8y	Z3d7ZvFizjczhqkQnb7RXg	199027	4	0.762	0.748	0	-4.15	0	0.033	0.0266	0	0.348	0.851	110.009
5BrTUo0xP1wKXLJWUaGFtk	Loyal (feat. Lil Wayne & Tyga)	75	TgMoI8Qo8RIyKalAghZMeG	7bXgB6jMjp9ATFy66eO08Z	KUBSaE6ulYu49hAg7vmNAR	264947	4	0.841	0.522	10	-5.963	0	0.049	0.0168	1.37e-06	0.188	0.616	99.059
5cc9Zbfp9u10sfJeKZ3h16	3005	80	lfgJolbOPS5xAbW8QoY03w	73sIBHcqh3Z3NyqHKZ7FOL	h9t7HfmUClwEKkUc7f34jH	234215	4	0.664	0.447	6	-7.272	0	0.289	0.112	0	0.091	0.659	83.138
5CMjjywI0eZMixPeqNd75R	Lose Yourself to Dance (feat. Pharrell Williams)	70	mvNJXaToliDuU7NWXOthAO	4tZwfgrHOc3mvqYlEYSvVi	h9t7HfmUClwEKkUc7f34jH	353893	4	0.832	0.659	10	-7.828	0	0.057	0.0839	0.00114	0.0753	0.674	100.163
5CZ40GBx1sQ9agT82CLQCT	traitor	88	qQOSra1GSEEeF36URg4nTg	1McMsnEElThX1knmY4oliG	pZxQbhuIGcA5v4a4eMVxDI	229227	4	0.38	0.339	3	-7.885	1	0.0338	0.691	0	0.12	0.0849	100.607
5DI9jxTHrEiFAhStG7VA8E	Started From the Bottom	70	7CBUtgqTxsm7PP98FuOQlA	3TVXtAsR1Inumwj472S9r4	h9t7HfmUClwEKkUc7f34jH	174133	4	0.793	0.524	8	-7.827	1	0.156	0.0319	0	0.156	0.579	86.325
5e0dZqrrTaoj6AIL7VjnBM	Written in the Stars (feat. Eric Turner)	48	hB611jp9MKsnPtBxlz8hp5	0Tob4H0FLtEONHU1MjpUEp	Z3d7ZvFizjczhqkQnb7RXg	207600	5	0.619	0.971	7	-3.045	1	0.13	0.0526	0	0.196	0.295	122.552
5E30LdtzQTGqRvNd7l6kG5	Daddy Issues	86	F0tBSOBor3SSYUAmEWjZC6	77SW9BnxLY8rJ0RciFqkHh	9wnrC2T34VLxtL7vdC8hVE	260173	4	0.588	0.521	10	-9.461	1	0.0329	0.0678	0.149	0.123	0.337	85.012
5E6CDAxnBqc9V9Y6t5wTUE	Mr. Saxobeat - Radio Edit	63	tsLRJWilHmItpwLIFUOagH	0BmLNz4nSLfoWYW1cYsElL	wOvFE37RYJBq423MAkmUPr	195105	4	0.732	0.925	11	-4.165	0	0.051	0.0276	0.000238	0.14	0.782	127.012
5enxwA8aAbwZbf5qCHORXi	All Too Well (10 Minute Version) (Taylor's Version) (From The Vault)	87	7ayKa2UThGp8JRt2ykqMEr	06HL4z0CvFAxyc27GXpf02	pcclfKySeZMYGS2V6uxNLn	613027	4	0.631	0.518	0	-8.771	1	0.0303	0.274	0	0.088	0.205	93.023
5FljCWR0cys07PQ9277GTz	The Other Side	61	i1a3XP4M9oQdN7YwLyvNbL	07YZf4WDAMNwqr4jfgOZ8y	h9t7HfmUClwEKkUc7f34jH	226987	4	0.561	0.836	9	-3.939	1	0.1	0.0525	0	0.136	0.517	127.923
5FVd6KXrgO9B3JPmC8OPst	Do I Wanna Know?	89	GDJWkBS3fxHHWvGajeXf8L	7Ln80lUS6He07XvHI8qqHH	h9t7HfmUClwEKkUc7f34jH	272394	4	0.548	0.532	5	-7.596	1	0.0323	0.186	0.000263	0.217	0.405	85.03
5g7rJvWYVrloJZwKiShqlS	Dirty Paws	71	Uhv3IxT8ac793dkZQAjeSh	4dwdTW1Lfiq0cM8nBAqIIz	hYKylhpPiH1VPodagRTNzu	278373	4	0.359	0.649	3	-7.06	1	0.0349	0.107	0.0124	0.0555	0.133	111.709
5GBuCHuPKx6UC7VsSPK0t3	Thotiana	66	qHyQbijU1HMpmEskyLIHuG	3Fl1V19tmjt57oBdxXKAjJ	QlNM9gC3Z9AwcKBBdmOIUm	129264	4	0.906	0.382	10	-12.89	0	0.269	0.18	0	0.113	0.391	104.025
5gW5dSy3vXJxgzma4rQuzH	Make Me Feel	65	HU5rH7TCxDXu3NyGh1HzMV	6ueGR6SWhUJfvEhqkvMsVs	Jp4YMIf936KasPLNEymvB3	194230	4	0.859	0.413	1	-7.399	1	0.182	0.132	0	0.334	0.697	115.035
5hc71nKsUgtwQ3z52KEKQk	Somebody Else	73	3Dyptw8ES7q2eGB7fTSTnr	3mIj9lX2MWuHmhNCA7LSCW	dRZrPqTJ2iw75iSpHG7KnI	347520	4	0.61	0.788	0	-5.724	1	0.0585	0.195	0.0142	0.153	0.472	101.045
5HCyWlXZPP0y6Gqq8TgA20	STAY (with Justin Bieber)	86	8MHxceyBSewF52BlJAWvIJ	2tIP7SsRs7vjIcLrU85W8J	pcclfKySeZMYGS2V6uxNLn	141806	4	0.591	0.764	1	-5.484	1	0.0483	0.0383	0	0.103	0.478	169.928
5Hroj5K7vLpIG4FNCRIjbP	Best Day Of My Life	82	VEkGohaAwJAyKX8U1WFMlp	0MlOPi3zIDMVrfA9R04Fe3	KUBSaE6ulYu49hAg7vmNAR	194240	4	0.673	0.902	2	-2.392	1	0.0346	0.0591	0.000262	0.0558	0.538	100.012
5IgjP7X4th6nMNDh4akUHb	Under The Influence	89	wGB2kDeEdP4RREJxhSWdDc	7bXgB6jMjp9ATFy66eO08Z	pZxQbhuIGcA5v4a4eMVxDI	184613	4	0.733	0.69	9	-5.529	0	0.0427	0.0635	1.18e-06	0.105	0.31	116.992
5ildQOEKmJuWGl2vRkFdYc	DESPECHÃ	82	q3kuZ3zSioln50YVrFf0fE	7ltDVBr6mKbRvohxheJ9h1	pZxQbhuIGcA5v4a4eMVxDI	157018	4	0.919	0.623	7	-6.521	1	0.0992	0.184	1.63e-05	0.0609	0.775	130.037
5itOtNx0WxtJmi1TQ3RuRd	Giant (with Rag'n'Bone Man)	74	4JqoJTtUn1zmf5kl8lHHJM	7CajNmpbOovFoOoasH2HaY	QlNM9gC3Z9AwcKBBdmOIUm	229184	4	0.807	0.887	1	-4.311	0	0.0361	0.016	0.000503	0.0811	0.606	122.015
5jE48hhRu8E6zBDPRSkEq7	All About That Bass	75	JZ5MrfdrNtzLMNSaN9NIwQ	6JL8zeS1NmiOftqZTRgdTz	KUBSaE6ulYu49hAg7vmNAR	187920	4	0.807	0.887	9	-3.726	1	0.0503	0.0573	2.87e-06	0.124	0.961	134.052
5JLv62qFIS1DR3zGEcApRt	Wide Awake	70	LotvOKuFl91BpsqnAcFcGl	6jJ0s89eD6GaHleKKya26X	hYKylhpPiH1VPodagRTNzu	220947	4	0.514	0.683	5	-5.099	1	0.0367	0.0749	2.64e-06	0.392	0.575	159.814
5jQI2r1RdgtuT8S3iG8zFC	Lavender Haze	86	fkrdol9gOidN8J4Q4M3nGW	06HL4z0CvFAxyc27GXpf02	pZxQbhuIGcA5v4a4eMVxDI	202396	4	0.733	0.436	10	-10.489	1	0.08	0.258	0.000573	0.157	0.0976	96.985
5jyUBKpmaH670zrXrE0wmO	Reload - Radio Edit	69	dmuRZRc6OUKy8J9WSzp3Bu	6hyMWrxGBsOx6sWcVj1DqP	h9t7HfmUClwEKkUc7f34jH	221273	4	0.485	0.724	9	-4.633	0	0.0521	0.0736	0	0.0631	0.433	128.045
5jzKL4BDMClWqRguW5qZvh	Teenage Dream	76	f1GOmd2yu5vAj5n9dOu4Nd	6jJ0s89eD6GaHleKKya26X	Z3d7ZvFizjczhqkQnb7RXg	227741	4	0.719	0.798	10	-4.582	1	0.0361	0.0162	2.34e-06	0.134	0.591	120.011
5kcE7pp02ezLZaUbbMv3Iq	Pound The Alarm	66	rf2DGU6NxaArbeoGLRM9BW	0hCNtLu0JehylgoiP8L4Gh	hYKylhpPiH1VPodagRTNzu	205640	4	0.728	0.858	9	-3.686	1	0.0609	0.0403	4.09e-06	0.0241	0.591	125.055
5knuzwU65gJK7IF5yJsuaW	Rockabye (feat. Sean Paul & Anne-Marie)	77	ifAbu3IaL0MPRtSw1xZbox	6MDME20pz9RveH9rEXvrOM	LgCTGYUwup3J1TSMRyObZA	251088	4	0.72	0.763	9	-4.068	0	0.0523	0.406	0	0.18	0.742	101.965
5KONnBIQ9LqCxyeSPin26k	Trumpets	64	i1a3XP4M9oQdN7YwLyvNbL	07YZf4WDAMNwqr4jfgOZ8y	KUBSaE6ulYu49hAg7vmNAR	217419	4	0.635	0.691	0	-4.862	1	0.258	0.555	0	0.097	0.638	82.142
5kqIPrATaCc2LqxVWzQGbk	7 Years	85	HytghV1QSNDuRYJhYFirDG	25u4wHJWxCA9vO0CzxAbK7	dRZrPqTJ2iw75iSpHG7KnI	237300	4	0.765	0.473	10	-5.829	1	0.0514	0.287	0	0.391	0.34	119.992
5lF0pHbsJ0QqyIrLweHJPW	Burn	75	fi1D6XkwhrY3Bu1OHVb35m	0X2BH1fck6amBIoJhDVmmJ	KUBSaE6ulYu49hAg7vmNAR	231213	4	0.555	0.772	1	-5.007	1	0.0523	0.315	0	0.105	0.346	86.921
5ls62WNKHUUrdF3r1cv83T	emotions	72	mUPVmjivXrykyiqMP0pbRT	6ASri4ePR7RlsvIQgWPJpS	QlNM9gC3Z9AwcKBBdmOIUm	131213	4	0.63	0.63	9	-6.211	1	0.0395	0.0131	0	0.142	0.163	80.512
5mCPDVBb16L4XQwDdbRUpz	Passionfruit	87	sDdieEC8vk3NJZbBnB6pnD	3TVXtAsR1Inumwj472S9r4	LgCTGYUwup3J1TSMRyObZA	298941	4	0.809	0.463	11	-11.377	1	0.0396	0.256	0.085	0.109	0.364	111.98
5n0CTysih20NYdT2S0Wpe8	Trouble	73	thOmKbAM1UNqD98AArXlDu	26T3LtbuGT1Fu9m0eRq5X3	dRZrPqTJ2iw75iSpHG7KnI	225973	4	0.47	0.623	0	-5.655	1	0.0302	0.392	0.000439	0.0992	0.298	77.861
5N1o6d8zGcSZSeMFkOUQOk	Hot Girl Summer (feat. Nicki Minaj & Ty Dolla $ign)	67	S9vRTJwSRyAuivIMvRjCed	181bsRPaVXVlUKXrxwZfHK	QlNM9gC3Z9AwcKBBdmOIUm	199427	4	0.872	0.814	0	-4.568	1	0.155	0.00485	1.96e-06	0.214	0.57	98.985
5NlFXQ0si6U87gXs6hq81B	Candy	71	Su1n5UP2lqqVL81CSGTK1V	2HcwFjNelS49kFbfvMxQYw	hYKylhpPiH1VPodagRTNzu	201053	4	0.715	0.791	10	-6.63	1	0.0414	0.0368	0	0.0694	0.879	116.043
5Nm9ERjJZ5oyfXZTECKmRt	Stay With Me	85	2pHMSrxrKZRsxRL40p3vkB	2wY79sveU1sp5g7SokKOiI	KUBSaE6ulYu49hAg7vmNAR	172724	4	0.418	0.42	0	-6.444	1	0.0414	0.588	6.39e-05	0.11	0.184	84.094
5O2P9iiztwhomNh8xkR9lJ	Night Changes	89	T7NxzTTggdT3gtq7RbDuVN	4AK6F7OLvEQ5QYCBNiQWHq	KUBSaE6ulYu49hAg7vmNAR	226600	4	0.672	0.52	8	-7.747	1	0.0353	0.859	0	0.115	0.37	120.001
5OCJzvD7sykQEKHH7qAC3C	God is a woman	79	oklCYUa2mBJA3nq2Y2sNDn	66CXWjxzNUsdJxJ2JdwvnR	Jp4YMIf936KasPLNEymvB3	197547	4	0.602	0.658	1	-5.934	1	0.0558	0.0233	6e-05	0.237	0.268	145.031
5oO3drDxtziYU2H1X23ZIp	Love On The Brain	86	f4FOUbugWrhDPurM39XEwx	5pKCCKE2ajJHZ9KAiaK11H	LgCTGYUwup3J1TSMRyObZA	224000	3	0.509	0.637	4	-4.83	0	0.0471	0.0717	1.08e-05	0.0789	0.378	172.006
5p7ujcrUXASCNwRaWNHR1C	Without Me	76	JBRPlkZhM1kRTwXJ2Q3yYK	26VFTg2z8YR0cCuwLzESi2	QlNM9gC3Z9AwcKBBdmOIUm	201661	4	0.752	0.488	6	-7.05	1	0.0705	0.297	9.11e-06	0.0936	0.533	136.041
5PUvinSo4MNqW7vmomGRS7	Blurred Lines	58	gAcHi1rckOBp87qNxdeKBf	0ZrpamOxcZybMHGg1AYtHP	h9t7HfmUClwEKkUc7f34jH	263053	4	0.861	0.504	7	-7.707	1	0.0489	0.00412	1.78e-05	0.0783	0.881	120
5Qy6a5KzM4XlRxsNcGYhgH	6 Foot 7 Foot	74	ca3Mrw8kcFXttv6qC7QRIZ	55Aa2cqylxrFIXC767Z865	wOvFE37RYJBq423MAkmUPr	248587	4	0.364	0.752	2	-5.429	1	0.304	0.0007	0	0.318	0.606	79.119
5RqR4ZCCKJDcBLIn4sih9l	Party Girl	73	mL95zwFFg8UxiryBp35p1p	1XLWox9w1Yvbodui0SRhUQ	ndfd917VUIq2bOQToxPcqS	147800	4	0.728	0.431	6	-9.966	0	0.0622	0.749	0	0.0996	0.629	130.022
5s7xgzXtmY4gMjeSlgisjy	Easy Love	68	Y2543SqLZGdiCNRtHLrlix	1IueXOQyABrMOprrzwQJWN	9wnrC2T34VLxtL7vdC8hVE	229813	4	0.68	0.942	9	-4.208	1	0.0631	0.175	0.0013	0.117	0.647	123.976
5sra5UY6sD658OabHL3QtI	Empire State of Mind (Part II) Broken Down	73	09mA6vMx1zYyUhuvpfv056	3DiDSECUqqY1AuBP8qtaIa	Z3d7ZvFizjczhqkQnb7RXg	216480	4	0.484	0.368	6	-7.784	1	0.0341	0.74	3.82e-05	0.118	0.142	92.923
5uCax9HTNlzGybIStD3vDh	Say You Won't Let Go	87	EgZyDWbjtqmnjg1xAnaZev	4IWBUUAFIplrNtaOHcJPRM	LgCTGYUwup3J1TSMRyObZA	211467	4	0.358	0.557	10	-7.398	1	0.059	0.695	0	0.0902	0.494	85.043
5ujh1I7NZH5agbwf7Hp8Hc	Swimming Pools (Drank) - Extended Version	71	fLaEHBY2dgmJqGhAchgL7v	2YZyLoL8N0Wb9xBt1NhZWg	hYKylhpPiH1VPodagRTNzu	313787	4	0.716	0.485	1	-7.745	1	0.404	0.123	2.69e-05	0.604	0.26	74.132
5UqCQaDshqbIk3pkhy4Pjg	Levels - Radio Edit	82	Ec8fJT1xN7mY6BkuUVHEiU	1vCWHaC5f2uS3yhpwWbIA6	hYKylhpPiH1VPodagRTNzu	199907	4	0.584	0.889	1	-5.941	0	0.0343	0.0462	0.828	0.309	0.464	126.04
5vL0yvddknhGj7IrBc6UTj	This Is How We Do	60	MZbGnPU1lZpfvvBeWJJqQt	6jJ0s89eD6GaHleKKya26X	h9t7HfmUClwEKkUc7f34jH	204285	4	0.69	0.636	9	-6.028	0	0.0457	0.0203	0	0.147	0.8	96
5vlEg2fT4cFWAqU5QptIpQ	Replay	74	L3Z4rmw6iBK2qbromMSbLC	5tKXB9uuebKE34yowVaU3C	Z3d7ZvFizjczhqkQnb7RXg	182307	4	0.706	0.751	9	-6.323	1	0.0708	0.173	0	0.168	0.195	91.031
5VSCgNlSmTV2Yq5lB40Eaw	Love Me Again	68	VaIT9VYZ0c0hLm2peBEgSf	34v5MVKeQnIo0CWYMbbrPf	h9t7HfmUClwEKkUc7f34jH	239894	4	0.495	0.894	2	-4.814	0	0.0441	0.00453	0.000596	0.103	0.213	126.03
5wEreUfwxZxWnEol61ulIi	Born To Die	69	yWvd7fahChwMerfh17getm	00FQb4jTyendYWaN8pK0wa	hYKylhpPiH1VPodagRTNzu	286253	4	0.393	0.634	4	-6.629	0	0.0378	0.2	0.000166	0.198	0.395	85.767
5WvAo7DNuPRmk4APhdPzi8	No Brainer	66	ClkHvEHx4OXGFajwkQKdjr	0QHgL1lAIqAw0HtD7YldmP	Jp4YMIf936KasPLNEymvB3	260000	5	0.552	0.76	0	-4.706	1	0.342	0.0733	0	0.0865	0.639	135.702
5Z9KJZvQzH6PFmb8SNkxuk	INDUSTRY BABY (feat. Jack Harlow)	79	mlRlxxucEEcTn8Zkwfj5a2	7jVv8c5Fj3E9VhNjxT4snq	pcclfKySeZMYGS2V6uxNLn	212353	4	0.741	0.691	10	-7.395	0	0.0672	0.0221	0	0.0476	0.892	150.087
5zdkUzguZYAfBH9fnWn3Zl	Need U (100%) (feat. A*M*E) - Radio Edit	61	CiEHZKcpR6NJk7VIXi2LKn	61lyPtntblHJvA7FMMhi7E	h9t7HfmUClwEKkUc7f34jH	174122	4	0.67	0.848	0	-5.103	0	0.0538	0.00172	0.00168	0.385	0.457	124.031
5ZFVacinyPxz19eK2vTodL	Miami 2 Ibiza - Swedish House Mafia vs. Tinie Tempah	48	hB611jp9MKsnPtBxlz8hp5	1h6Cn3P4NGzXbaXidqURXs	Z3d7ZvFizjczhqkQnb7RXg	206461	4	0.736	0.929	7	-5.89	0	0.0674	0.00237	1.11e-05	0.402	0.658	125.03
608a1wIsSd5KzMEqm1O7w3	I'm On One	72	bfugUjb4KAemuMqzw5aK4H	0QHgL1lAIqAw0HtD7YldmP	wOvFE37RYJBq423MAkmUPr	296147	4	0.413	0.807	11	-3.499	0	0.318	0.0536	0	0.631	0.438	149.33
60nZcImufyMA1MKQY3dcCH	Happy - From "Despicable Me 2"	83	oMasAYdrJSlv5TzCr84S5O	2RdwBSPQiwcmiDo9kixcl8	KUBSaE6ulYu49hAg7vmNAR	232720	4	0.647	0.822	5	-4.662	0	0.183	0.219	0	0.0908	0.962	160.019
61KpQadow081I2AsbeLcsb	deja vu	17	L7FGA7iZNxphb8lrXys1zV	1McMsnEElThX1knmY4oliG	pcclfKySeZMYGS2V6uxNLn	215508	4	0.439	0.61	9	-7.236	1	0.116	0.593	1.07e-05	0.341	0.172	181.088
61LtVmmkGr8P9I2tSPvdpf	Teach Me How to Dougie	70	T2XVW8W9ytnKghnxrLcYHf	1EeArivTpzLNCqubV95255	Z3d7ZvFizjczhqkQnb7RXg	237480	4	0.846	0.438	11	-4.981	1	0.141	0.2	9.43e-05	0.0939	0.512	85.013
62ke5zFUJN6RvtXZgVH0F8	Only Love Can Hurt Like This	83	BexOdwGjRBGwRVgbZUrrUq	4fwuXg6XQHfdlOdmw36OHa	KUBSaE6ulYu49hAg7vmNAR	232893	4	0.566	0.885	8	-4.528	1	0.0818	0.0958	9.97e-05	0.334	0.304	90.99
62PaSfnXSMyLshYJrlTuL3	Hello	75	itSDqOtn4MS7QnPDDFVe9c	4dpARuHxo51G3z768sgnrY	dRZrPqTJ2iw75iSpHG7KnI	295502	4	0.578	0.43	5	-6.134	0	0.0305	0.33	0	0.0854	0.288	78.991
67BtfxlNbhBmCDR2L2l8qd	MONTERO (Call Me By Your Name)	76	uQ3Mbu3t63W7V6b1EdHi5e	7jVv8c5Fj3E9VhNjxT4snq	pcclfKySeZMYGS2V6uxNLn	137876	4	0.61	0.508	8	-6.682	0	0.152	0.297	0	0.384	0.758	178.818
68rcszAg5pbVaXVvR7LFNh	One Day / Reckoning Song (Wankelmut Remix) - Radio Edit	70	RDrHV8poCD11Wu6hoYOKX5	7t51dSX8ZkKC7VoKRd0lME	hYKylhpPiH1VPodagRTNzu	215187	4	0.826	0.668	3	-6.329	0	0.0571	0.223	6.92e-05	0.167	0.534	118.99
698ItKASDavgwZ3WjaWjtz	Faded	82	ZkppOZInxmljFSbe4EjwwV	7vk5e3vY1uw9plTHJAMwjN	dRZrPqTJ2iw75iSpHG7KnI	212107	4	0.468	0.627	6	-5.085	1	0.0476	0.0281	7.97e-06	0.11	0.159	179.642
69gQgkobVW8bWjoCjBYQUd	I Got U	62	7fPaPtZG8KuFDhUPEoSp7w	61lyPtntblHJvA7FMMhi7E	KUBSaE6ulYu49hAg7vmNAR	285596	4	0.636	0.761	9	-7.752	0	0.035	0.00377	0.00784	0.0851	0.463	120.837
6b3b7lILUJqXcp6w9wNQSm	Cheap Thrills (feat. Sean Paul)	69	IniTpg8lC2b99Nv8ZGaNQ6	5WUlDfRSoLAfcVSX1WnrxN	dRZrPqTJ2iw75iSpHG7KnI	224813	4	0.592	0.8	6	-4.931	0	0.215	0.0561	2.01e-06	0.0775	0.728	89.972
6BdgtqiV3oXNqBikezwdvC	Over	73	1mbH9U7RhYZgALbPOeNd1a	3TVXtAsR1Inumwj472S9r4	Z3d7ZvFizjczhqkQnb7RXg	233560	5	0.35	0.845	7	-5.614	1	0.2	0.0107	0	0.123	0.45	99.643
6CjtS2JZH9RkDz5UVInsa9	Thrift Shop (feat. Wanz)	81	evNI7LJKF5hsJy1POUwaQS	5BcAKTbp20cv7tC5VqPFoC	h9t7HfmUClwEKkUc7f34jH	235613	4	0.781	0.526	6	-6.986	0	0.293	0.0633	0	0.0457	0.665	94.993
6DCZcSspjsKoFjzjrWoCdn	God's Plan	87	79OmYA5dWPLo2AXXliIkjF	3TVXtAsR1Inumwj472S9r4	Jp4YMIf936KasPLNEymvB3	198973	4	0.754	0.449	7	-9.211	1	0.109	0.0332	8.29e-05	0.552	0.357	77.169
6FE2iI43OZnszFLuLtvvmg	Classic	83	VkFPm1RMxdOTrPHZWZrfXi	2l35CQqtYRh3d8ZIiBep4v	KUBSaE6ulYu49hAg7vmNAR	175427	4	0.72	0.791	1	-4.689	1	0.124	0.0384	0	0.157	0.756	102.071
6FSxwdN08PvzimGApFjRnY	When We Collide	44	OsFKQGXX5Ro0jXSaocFUCq	3906URNmNa1VCXEeiJ3DSH	Z3d7ZvFizjczhqkQnb7RXg	226000	4	0.443	0.683	2	-5.521	1	0.0343	0.0198	5.26e-06	0.313	0.447	81.986
6gBFPUFcJLzWGx4lenP6h2	goosebumps	87	k7wxWybRpL7gLINXf37xIf	0Y5tJX1MQlPlqiwlOH1tJY	LgCTGYUwup3J1TSMRyObZA	243837	4	0.841	0.728	7	-3.37	1	0.0484	0.0847	0	0.149	0.43	130.049
6GgPsuz0HEO0nrO2T0QhDv	No Hands (feat. Roscoe Dash & Wale)	61	OrsimaVJJStUp2OmS2BCMx	6f4XkbvYlXMH0QgVRzW0sM	Z3d7ZvFizjczhqkQnb7RXg	263773	4	0.76	0.595	1	-6.366	1	0.0391	0.00544	0	0.241	0.361	131.497
6habFhsOp2NvshLv26DqMb	Despacito	82	DYc82k41IVcP5Yy58r8lsY	4V8Sr092TqfHkfAA5fXXqG	LgCTGYUwup3J1TSMRyObZA	229360	4	0.655	0.797	2	-4.787	1	0.153	0.198	0	0.067	0.839	177.928
6HZ9VeI5IRFCNQLXhpF4bq	I Love It (feat. Charli XCX)	73	ZbqVF9MLeVevnhGngRASoK	1VBflYyxBhnDc9uVib98rw	hYKylhpPiH1VPodagRTNzu	157153	4	0.711	0.906	8	-2.671	1	0.0284	0.00952	1.64e-05	0.153	0.824	125.916
6i0V12jOa3mr6uu4WYhUBr	Heathens	83	eJSJ3m4nmyK3EX8PGoKtuj	3YQKmKGau1PzlVlkL1iodx	dRZrPqTJ2iw75iSpHG7KnI	195920	4	0.732	0.396	4	-9.348	0	0.0286	0.0841	3.58e-05	0.105	0.548	90.024
6I3mqTwhRpn34SLVafSH7G	Ghost	87	9Zp669b3CjPBb7VuSKQrDE	1uNFoZAHBGtllmzznpCI3s	pZxQbhuIGcA5v4a4eMVxDI	153190	4	0.601	0.741	2	-5.569	1	0.0478	0.185	2.91e-05	0.415	0.441	153.96
6Im9k8u9iIzKMrmV7BWtlF	34+35	80	lX3fgePMdqwd4DETy543Jq	66CXWjxzNUsdJxJ2JdwvnR	pcclfKySeZMYGS2V6uxNLn	173711	4	0.83	0.585	0	-6.476	1	0.094	0.237	0	0.248	0.485	109.978
6ImEBuxsbuTowuHmg3Z2FO	Mad Love	67	8Z7m4KPre67LA5c9DfQs4E	1MIVXf74SZHmTIp4V4paH4	QlNM9gC3Z9AwcKBBdmOIUm	169813	4	0.623	0.796	0	-2.981	0	0.199	0.659	0	0.115	0.607	197.524
6IPwKM3fUUzlElbvKw2sKl	we fell in love in october	86	g987bkRnnjjYcXDbO1TQ5R	3uwAm6vQy7kWPS2bciKWx9	Jp4YMIf936KasPLNEymvB3	184154	4	0.566	0.366	7	-12.808	1	0.028	0.113	0.181	0.155	0.237	129.96
6j7hih15xG2cdYwIJnQXsq	Not Over You	67	eXklcDPagskemdr1wixxl8	5DYAABs8rkY9VhwtENoQCz	hYKylhpPiH1VPodagRTNzu	218520	4	0.63	0.894	10	-4.592	1	0.0544	0.255	0	0.181	0.364	142.051
6K4t31amVTZDgR3sKmwUJJ	The Less I Know The Better	87	QjHrUA52omUZepJoiryOAl	5INjqkS1o8h1imAzPqGZBb	9wnrC2T34VLxtL7vdC8hVE	216320	4	0.64	0.74	4	-4.083	1	0.0284	0.0115	0.00678	0.167	0.785	116.879
6KBYk8OFtod7brGuZ3Y67q	Misery	64	e8YBqPOh3y2MUTpQcPW3LA	04gDigrS5kc9YWfZHwBETP	Z3d7ZvFizjczhqkQnb7RXg	216200	4	0.704	0.81	4	-4.874	0	0.0425	0.000315	0	0.216	0.726	102.98
6KkyuDhrEhR5nJVKtv9mCf	High Hopes	68	2Rl1LsoIrMvYVRhQj9Nsdp	4BxCuXFJrSWGi1KHcVqaU4	h9t7HfmUClwEKkUc7f34jH	230267	4	0.488	0.487	4	-6.371	1	0.0305	0.577	0	0.193	0.219	77.278
6KuHjfXHkfnIjdmcIvt9r0	On Top Of The World	71	sT64qB1ytY9VsuVawpLGWm	53XhwfbYqKCa1cC15pYq2q	hYKylhpPiH1VPodagRTNzu	189840	4	0.635	0.926	0	-5.589	1	0.151	0.0893	4.53e-06	0.0928	0.761	100.048
6lV2MSQmRIkycDScNtrBXO	Airplanes (feat. Hayley Williams of Paramore)	78	3DYhAdvFvIeZ3X9mHs3xvd	5ndkK3dpZLKtBklKjxNQwT	Z3d7ZvFizjczhqkQnb7RXg	180480	4	0.66	0.867	6	-4.285	0	0.116	0.11	0	0.0368	0.377	93.033
6NFyWDv5CjfwuzoCkw47Xf	Delicate	87	81m49NLePQpOCfY4KI7pKJ	06HL4z0CvFAxyc27GXpf02	Jp4YMIf936KasPLNEymvB3	232253	4	0.75	0.404	9	-10.178	0	0.0682	0.216	0.000357	0.0911	0.0499	95.045
6p5abLu89ZSSpRQnbK9Wqs	Post to Be (feat. Chris Brown & Jhene Aiko)	56	SIA2OElYUyIfysFudwiyVF	0f5nVCcR06GX8Qikz0COtT	KUBSaE6ulYu49hAg7vmNAR	226581	4	0.733	0.676	10	-5.655	0	0.0432	0.0697	0	0.208	0.701	97.448
6PERP62TejQjgHu81OHxgM	good 4 u	24	1NuTHGjWBPCO7XauMEOp7a	1McMsnEElThX1knmY4oliG	pcclfKySeZMYGS2V6uxNLn	178148	4	0.556	0.661	6	-5.052	0	0.204	0.3	0	0.101	0.668	168.56
6PQ88X9TkUIAUIZJHW2upE	Bad Habits	18	lgT12R1oOMVVfckUZDxY4g	6eUKZXaKkcviH0Ku9w2n3V	pcclfKySeZMYGS2V6uxNLn	231041	4	0.808	0.897	11	-3.712	0	0.0348	0.0469	3.14e-05	0.364	0.591	126.026
6r2BECwMgEoRb5yLfp0Hca	Born This Way	71	oNKt8h5YYfQr2klpFMAW22	1HY2Jd0NmPuamShAr6KMms	wOvFE37RYJBq423MAkmUPr	260253	4	0.587	0.828	11	-5.108	1	0.161	0.00327	0	0.331	0.494	123.907
6RRNNciQGZEXnqk8SQ9yv5	You Need To Calm Down	84	mBW0t8OTI13cfu6QGgWDpO	06HL4z0CvFAxyc27GXpf02	QlNM9gC3Z9AwcKBBdmOIUm	171360	4	0.771	0.671	2	-5.617	1	0.0553	0.00929	0	0.0637	0.714	85.026
6RtPijgfPKROxEzTHNRiDp	Rude	84	9aU6jEovwmNfv0jlsXQaU8	0DxeaLnv6SyYk2DOqkLO8c	KUBSaE6ulYu49hAg7vmNAR	224840	4	0.773	0.758	1	-4.993	1	0.0381	0.0422	0	0.305	0.925	144.033
6s8nHXTJVqFjXE4yVZPDHR	Troublemaker (feat. Flo Rida)	77	hu8UtKhLXZbnZLB4oXxfuK	3whuHq0yGx60atvA2RCVRW	hYKylhpPiH1VPodagRTNzu	185587	4	0.762	0.863	0	-3.689	0	0.0561	0.015	0	0.125	0.965	106.012
6Sq7ltF9Qa7SNFBsV5Cogx	Me Porto Bonito	90	TJLNdIPReZFoj2z4xC6jGr	4q3ewBCX7sLwd24euuV69X	pZxQbhuIGcA5v4a4eMVxDI	178567	4	0.911	0.712	1	-5.105	0	0.0817	0.0901	2.68e-05	0.0933	0.425	92.005
6t6oULCRS6hnI7rm0h5gwl	Some Nights	71	g8pIqGxNEDNdK6VlLOUhmH	5nCi3BB41mBaMH9gfr6Su0	hYKylhpPiH1VPodagRTNzu	277040	4	0.672	0.738	0	-7.045	1	0.0506	0.0178	6.75e-05	0.0927	0.392	107.938
6TqXcAFInzjp0bODyvrWEq	Talk (feat. Disclosure)	73	FgBtlRNFolgC2Ya091tV5H	6LuN9FCkKOj5PcnpouEgny	QlNM9gC3Z9AwcKBBdmOIUm	197573	4	0.9	0.4	0	-8.575	1	0.127	0.0516	0	0.0599	0.346	135.984
6UelLqGlWMcVH1E5c4H7lY	Watermelon Sugar	90	kA31sEW2pWHlJrIbmojmKa	6KImCVD70vtIoJWnq6nGn3	ndfd917VUIq2bOQToxPcqS	174000	4	0.548	0.816	0	-4.209	1	0.0465	0.122	0	0.335	0.557	95.39
6V1bu6o1Yo5ZXnsCJU8Ovk	Girls Like You (feat. Cardi B) - Cardi B Version	67	oVY5eQ5EDi1gRZp3cM24Yp	04gDigrS5kc9YWfZHwBETP	Jp4YMIf936KasPLNEymvB3	235545	4	0.851	0.541	0	-6.825	1	0.0505	0.568	0	0.13	0.448	124.959
6v3KW9xbzN5yKLt9YKDYA2	SeÃ±orita	82	rWs8X7tBbjSuw3JUipkXQK	7n2wHs1TKAczGzO7Dd2rGr	QlNM9gC3Z9AwcKBBdmOIUm	190800	4	0.759	0.548	9	-6.049	0	0.029	0.0392	0	0.0828	0.749	116.967
6Vc5wAMmXdKIAM7WUoEb7N	Say Something	75	BgWuuVKTDLGmW1vO6cxZbL	5xKp3UyavIBUsGy3DQdXeF	KUBSaE6ulYu49hAg7vmNAR	229400	3	0.407	0.147	2	-8.822	1	0.0355	0.857	2.89e-06	0.0913	0.0765	141.284
6Vh03bkEfXqekWp7Y1UBRb	Live While We're Young	76	ANrsGkxST7pRQWjUDaaK8R	4AK6F7OLvEQ5QYCBNiQWHq	hYKylhpPiH1VPodagRTNzu	200213	4	0.663	0.857	2	-2.16	1	0.0544	0.0542	0	0.144	0.931	126.039
6VObnIkLVruX4UVyxWhlqm	Skyfall	83	bQHa6CvPPHL5X3FnPqLCa2	4dpARuHxo51G3z768sgnrY	hYKylhpPiH1VPodagRTNzu	286480	4	0.346	0.552	0	-6.864	0	0.0282	0.417	0	0.114	0.0789	75.881
6VRhkROS2SZHGlp0pxndbJ	Bangarang (feat. Sirah)	72	7oBsjwjveiVsqbwCQQlm4C	5he5w2lnU9x7JFhnwcekXX	hYKylhpPiH1VPodagRTNzu	215253	4	0.716	0.972	7	-2.302	1	0.196	0.0145	3.22e-05	0.317	0.576	110.026
6wN4nT2qy3MQc098yL3Eu9	Deuces (feat. Tyga & Kevin McCall)	71	QNuiqGtNXLsy08bRj50abu	7bXgB6jMjp9ATFy66eO08Z	Z3d7ZvFizjczhqkQnb7RXg	276560	4	0.692	0.736	1	-5.109	1	0.11	0.0324	0	0.0787	0.217	73.987
6xGruZOHLs39ZbVccQTuPZ	Glimpse of Us	85	yqbRlCgtWdvyC6yivZW1Mt	3MZsBdqDrRTJihTHQrO6Dq	pZxQbhuIGcA5v4a4eMVxDI	233456	3	0.44	0.317	8	-9.258	1	0.0531	0.891	4.78e-06	0.141	0.268	169.914
6Xom58OOXk2SoU711L2IXO	Moscow Mule	86	TJLNdIPReZFoj2z4xC6jGr	4q3ewBCX7sLwd24euuV69X	pZxQbhuIGcA5v4a4eMVxDI	245940	4	0.804	0.674	5	-5.453	0	0.0333	0.294	1.18e-06	0.115	0.292	99.968
6y468DyY1V67RBNCwzrMrC	L.I.F.E.G.O.E.S.O.N.	58	LENNAEkFWREDdZkPGiC7I7	0aeLcja6hKzb7Uz2ou7ulP	wOvFE37RYJBq423MAkmUPr	228000	4	0.603	0.745	4	-5.79	1	0.0368	0.207	0	0.348	0.606	81.981
6YUTL4dYpB9xZO5qExPf05	Summer	85	FSScrD2sBMDenVsRr5yjPV	7CajNmpbOovFoOoasH2HaY	KUBSaE6ulYu49hAg7vmNAR	222533	4	0.596	0.856	4	-3.556	0	0.0346	0.0211	0.0178	0.141	0.743	127.949
6Z8R6UsFuGXGtiIxiD8ISb	Safe And Sound	85	ExbrjCkHarShBwLwtPlzGc	4gwpcMTbLWtBUlOijbVpuu	h9t7HfmUClwEKkUc7f34jH	192790	5	0.655	0.819	0	-4.852	1	0.0316	0.000176	0.00374	0.104	0.766	117.956
70ATm56tH7OrQ1zurYssz0	I Need A Doctor	72	KEKE2WLyR2k5GP8ESQNHyE	6DPYiyq5kWVQS4RGwxzPC7	wOvFE37RYJBq423MAkmUPr	283733	4	0.594	0.946	3	-4.521	1	0.452	0.0869	0	0.306	0.397	155.826
72TFWvU3wUYdUuxejTTIzt	Work	79	f4FOUbugWrhDPurM39XEwx	5pKCCKE2ajJHZ9KAiaK11H	dRZrPqTJ2iw75iSpHG7KnI	219320	4	0.725	0.534	11	-6.238	1	0.0946	0.0752	0	0.0919	0.558	91.974
748mdHapucXQri7IAO8yFK	Kiss Me More (feat. SZA)	79	mxygbXBRF9NvDnVjaxNN47	5cj0lLjcoR7YOSnhnX0Po5	pcclfKySeZMYGS2V6uxNLn	208867	4	0.762	0.701	8	-3.541	1	0.0286	0.235	0.000158	0.123	0.742	110.968
76hfruVvmfQbw0eYn1nmeC	Cake By The Ocean	84	KQEMNSXft8tqXcD4fRWrCU	6T5tfhQCknKG4UnH90qGnz	dRZrPqTJ2iw75iSpHG7KnI	219147	4	0.774	0.753	4	-5.446	0	0.0517	0.152	0	0.0371	0.896	119.002
7795WJLVKJoAyVoOtCWqXN	I'm Not The Only One	86	2pHMSrxrKZRsxRL40p3vkB	2wY79sveU1sp5g7SokKOiI	KUBSaE6ulYu49hAg7vmNAR	239317	4	0.677	0.485	5	-5.795	1	0.0361	0.529	2.04e-05	0.0766	0.493	82.001
78JKJfKsqgeBDBF58gv1SF	Hands on the Wheel (feat. Asap Rocky)	66	HSYOaZv3rWMTSSfG1wopcG	5IcR3N7QB1j6KBL8eImZ8m	hYKylhpPiH1VPodagRTNzu	197132	4	0.646	0.784	1	-7.471	0	0.108	0.0166	0	0.0721	0.179	127.839
7a86XRg84qjasly9f6bPSD	We Are Young (feat. Janelle MonÃ¡e)	76	g8pIqGxNEDNdK6VlLOUhmH	5nCi3BB41mBaMH9gfr6Su0	hYKylhpPiH1VPodagRTNzu	250627	4	0.378	0.638	10	-5.576	1	0.075	0.02	7.66e-05	0.0849	0.735	184.086
7AqISujIaWcY3h5zrOqt5v	Forget You	66	uTK4FATArVi7vVsUkKNcrZ	5nLYd9ST4Cnwy6NHaCxbj8	Z3d7ZvFizjczhqkQnb7RXg	222733	4	0.696	0.875	0	-3.682	1	0.0649	0.134	0	0.159	0.772	127.39
7aXuop4Qambx5Oi3ynsKQr	I Don't Mind (feat. Juicy J)	68	fFKLuyVmwQntfT7wk2vSis	23zg3TcAtWQy7J6upgbUnj	9wnrC2T34VLxtL7vdC8hVE	251989	4	0.87	0.464	4	-8.337	1	0.178	0.205	0	0.0902	0.457	112.974
7B1Dl3tXqySkB8OPEwVvSu	We'll Be Coming Back (feat. Example)	66	fbgo2VmM0aYOB59uS5aJWV	7CajNmpbOovFoOoasH2HaY	hYKylhpPiH1VPodagRTNzu	234360	4	0.596	0.952	7	-4.364	1	0.0873	0.00131	0	0.598	0.571	127.945
7BKLCZ1jbUBVqRi2FVlTVw	Closer	86	TwfLuc2ppst9FqDxlyqVgI	69GGBxA162lTqCwzJG5jLp	dRZrPqTJ2iw75iSpHG7KnI	244960	4	0.748	0.524	8	-5.599	1	0.0338	0.414	0	0.111	0.661	95.01
7BqBn9nzAq8spo5e7cZ0dJ	Just the Way You Are	86	2kxbRH0Uah0OQnltYTwqgZ	0du5cEVh5yTK9QJze8zA0C	Z3d7ZvFizjczhqkQnb7RXg	220734	4	0.635	0.841	5	-5.379	1	0.0422	0.0134	0	0.0622	0.424	109.021
7DnAm9FOTWE3cUvso43HhI	Sweet but Psycho	82	sSFkuXpkDpBZPUlAPdlANZ	4npEfmQ6YuiwW1GpUmaq3F	QlNM9gC3Z9AwcKBBdmOIUm	187436	4	0.72	0.706	1	-4.719	1	0.0473	0.0684	0	0.166	0.62	133.002
7dSZ6zGTQx66c2GF91xCrb	PROVENZA	81	xVue1X991JHOWYx2cJNd3b	790FomKkXshlbRYZFtlgla	pZxQbhuIGcA5v4a4eMVxDI	210200	4	0.87	0.516	1	-8.006	1	0.0541	0.656	0.00823	0.11	0.53	111.005
7dt6x5M1jzdTEt8oCbisTK	Better Now	83	8xjeSVf4DCcxe7BasZB4FL	246dkjvS1zLTtiykXe5h60	QlNM9gC3Z9AwcKBBdmOIUm	231267	4	0.68	0.578	10	-5.804	1	0.04	0.331	0	0.135	0.341	145.038
7ef4DlsgrMEH11cDZd32M6	One Kiss (with Dua Lipa)	87	9Wt4REtMdHDCq8OxuJztAw	7CajNmpbOovFoOoasH2HaY	Jp4YMIf936KasPLNEymvB3	214847	4	0.791	0.862	9	-3.24	0	0.11	0.037	2.19e-05	0.0814	0.592	123.994
7eJMfftS33KTjuF7lTsMCx	death bed (coffee for your head)	83	OZnhY94gp1peCrK8xrLYMC	6bmlMHgSheBauioMgKv2tn	ndfd917VUIq2bOQToxPcqS	173333	4	0.726	0.431	8	-8.765	0	0.135	0.731	0	0.696	0.348	144.026
7ElF5zxOwYP4qVSWVvse3W	Break Your Heart	73	zVozFPnILLZ0J5sb2QNNGH	6MF9fzBmfXghAz953czmBC	Z3d7ZvFizjczhqkQnb7RXg	201547	4	0.607	0.934	3	-4.217	1	0.0314	0.0327	0	0.0909	0.568	122.01
7EVk9tRb6beJLTHrg6AkY9	Tuesday (feat. Danelle Sandoval)	73	ZqU1jM3YpUxbB9KnuMvEIq	4ON1ruy5ijE7ZPQthbrkgI	dRZrPqTJ2iw75iSpHG7KnI	241875	4	0.841	0.639	9	-6.052	0	0.0688	0.0156	0.0654	0.0545	0.675	99.002
7g13jf3zqlP5S68Voo5v9m	Dancing On My Own - Radio Edit	62	oX5Dgc2qWPZyNIC8prm7FB	6UE7nl9mha6s8z0wFQFIZ2	Z3d7ZvFizjczhqkQnb7RXg	278080	4	0.573	0.926	6	-6.045	1	0.0342	0.00202	0.0117	0.127	0.219	117.047
7HacCTm33hZYYN8DXpCYuG	I Like It	67	q0a6LQWSQyZ48hwtSEPZgk	7qG3b048QCHVRO5Pv1T5lw	Z3d7ZvFizjczhqkQnb7RXg	231373	4	0.648	0.942	10	-2.881	0	0.0878	0.021	0	0.0594	0.73	129.007
7hR5toSPEgwFZ78jfHdANM	Half of My Heart	67	0C4KIWtMQEPWb6y85RoFRN	0hEurMDQu99nJRq8pTxO14	Z3d7ZvFizjczhqkQnb7RXg	250373	4	0.681	0.593	5	-9.327	1	0.0251	0.435	0.000117	0.106	0.731	115.058
7hU3IHwjX150XLoTVmjD0q	MONEY	81	VZAmsMVpnJpn8YIM5jeJ05	5L1lO4eRHmJ7a0Q6csE5cT	pcclfKySeZMYGS2V6uxNLn	168228	4	0.831	0.554	1	-9.998	0	0.218	0.161	6.12e-05	0.152	0.396	140.026
7igeByaBM0MgGsgXtNxDJ7	positions	0	5bNA4ljkzVbY4a7COY6boT	66CXWjxzNUsdJxJ2JdwvnR	ndfd917VUIq2bOQToxPcqS	172325	4	0.736	0.802	0	-4.759	1	0.0864	0.468	0	0.094	0.675	144.005
7JJmb5XwzOO8jgpou264Ml	There's Nothing Holdin' Me Back	87	pffwrcdv6mYS8kGprm5r2t	7n2wHs1TKAczGzO7Dd2rGr	LgCTGYUwup3J1TSMRyObZA	199440	4	0.866	0.813	11	-4.063	0	0.0554	0.38	0	0.0779	0.969	121.998
7KXjTSCq5nL1LoYtL7XAwS	HUMBLE.	86	N88lxVcPKBXOzrcCXN3v1g	2YZyLoL8N0Wb9xBt1NhZWg	LgCTGYUwup3J1TSMRyObZA	177000	4	0.908	0.621	1	-6.638	0	0.102	0.000282	5.39e-05	0.0958	0.421	150.011
7LcfRTgAVTs5pQGEQgUEzN	Moves Like Jagger - Studio Recording From "The Voice" Performance	74	03Vw0cC606OOtfd9LF0hNF	04gDigrS5kc9YWfZHwBETP	wOvFE37RYJBq423MAkmUPr	201160	4	0.722	0.758	11	-4.477	0	0.0471	0.0111	0	0.308	0.62	128.047
7lGKEWMXVWWTt3X71Bv44I	Unsteady	75	7hCVyTtVM8GSd059e3ZFHl	3NPpFNZtSTHheNBaWC82rB	dRZrPqTJ2iw75iSpHG7KnI	193547	4	0.389	0.665	0	-6.169	1	0.0644	0.178	0.000732	0.116	0.199	117.055
7lPN2DXiMsVn7XUKtOW1CS	drivers license	28	HGFqAgFZbdLRx2HmhYGTJf	1McMsnEElThX1knmY4oliG	pcclfKySeZMYGS2V6uxNLn	242014	4	0.585	0.436	10	-8.761	1	0.0601	0.721	1.31e-05	0.105	0.132	143.874
7m3povhdMDLZwuEKak0l0n	Wasted	64	tzWujAKTKJjDRvKipmbgQf	2o5jDhtHVPhrJdv3cEQ99Z	KUBSaE6ulYu49hAg7vmNAR	190014	4	0.638	0.816	2	-5.503	1	0.0308	0.00149	0.00115	0.195	0.386	112.014
7MAibcTli4IisCtbHKrGMh	Leave The Door Open	12	CtReaEYhkIUiPsT2y1zlph	0du5cEVh5yTK9QJze8zA0C	pcclfKySeZMYGS2V6uxNLn	242096	4	0.586	0.616	5	-7.964	1	0.0324	0.182	0	0.0927	0.719	148.088
7mdNKXxia7AeSuJqjjA2rb	Beautiful People	55	4Q7yRqnNIg5n7ReHTtMgd4	7bXgB6jMjp9ATFy66eO08Z	wOvFE37RYJBq423MAkmUPr	225881	4	0.415	0.775	5	-6.366	0	0.161	0.0658	0.00431	0.0843	0.536	127.898
7mFj0LlWtEJaEigguaWqYh	Sweetest Pie	74	SJoqpkBhtP1wMQZajwAdEp	181bsRPaVXVlUKXrxwZfHK	pZxQbhuIGcA5v4a4eMVxDI	201334	4	0.814	0.628	7	-7.178	1	0.221	0.167	0	0.101	0.677	123.977
7MXVkk9YMctZqd1Srtv4MB	Starboy	92	Brk5mVPpW3Ewl2FE20a2Bc	1Xyo4u8uXC1ZmMpatF05PJ	dRZrPqTJ2iw75iSpHG7KnI	230453	4	0.679	0.587	7	-7.015	1	0.276	0.141	6.35e-06	0.137	0.486	186.003
7oVEtyuv9NBmnytsCIsY5I	BURN IT DOWN	77	aGAA4uuQLhbePEGimlvC2j	6XyY86QOPPrYVGvF9ch6wz	hYKylhpPiH1VPodagRTNzu	230253	4	0.585	0.972	9	-4.45	0	0.0534	0.0143	0	0.0707	0.585	110.006
7qEHsqek33rTcFNT9PFqLf	Someone You Loved	90	Lx9E3YScDN73wJzMn0VRJe	4GNC7GD6oZMSxPGyXy4MNB	QlNM9gC3Z9AwcKBBdmOIUm	182161	4	0.501	0.405	1	-5.679	1	0.0319	0.751	0	0.105	0.446	109.891
7qiZfU4dY1lWllzX7mPBI3	Shape of You	89	1Ru5FYEzNIKNM7ByfDjvdT	6eUKZXaKkcviH0Ku9w2n3V	LgCTGYUwup3J1TSMRyObZA	233713	4	0.825	0.652	1	-3.183	0	0.0802	0.581	0	0.0931	0.931	95.977
7rglLriMNBPAyuJOMGwi39	Cold Heart - PNAU Remix	72	qchmZl5JXgYaZbr7fVZcQy	3PhoLpVuITZKcymswpck5b	pZxQbhuIGcA5v4a4eMVxDI	202735	4	0.795	0.8	1	-6.32	1	0.0309	0.0354	7.25e-05	0.0915	0.934	116.032
7tFiyTwD0nx5a1eklYtX2J	Bohemian Rhapsody - Remastered 2011	75	OV44y9bc1t3sSenruWbuCM	1dfeR4HaWDbWqFHLkxsg1d	QlNM9gC3Z9AwcKBBdmOIUm	354320	4	0.392	0.402	0	-9.961	0	0.0536	0.288	0	0.243	0.228	143.883
7vS3Y0IKjde7Xg85LWIEdP	Problem	77	gHqFUMY18q4QDyFgfpdOdt	66CXWjxzNUsdJxJ2JdwvnR	KUBSaE6ulYu49hAg7vmNAR	193920	4	0.66	0.805	1	-5.352	0	0.153	0.0192	8.83e-06	0.159	0.625	103.008
7xQAfvXzm3AkraOtGPWIZg	Wow.	84	WtKSmRFwq1YGrQymSrqaxp	246dkjvS1zLTtiykXe5h60	QlNM9gC3Z9AwcKBBdmOIUm	149547	4	0.829	0.539	11	-7.359	0	0.208	0.136	1.78e-06	0.103	0.388	99.96
\.


--
-- TOC entry 4882 (class 0 OID 75942)
-- Dependencies: 224
-- Data for Name: album_tracks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.album_tracks (album_id, track_id) FROM stdin;
2kxbRH0Uah0OQnltYTwqgZ	7BqBn9nzAq8spo5e7cZ0dJ
M62GAHp8DW01MkDVWerlbq	15JINEqzVMv3SvJTAXAKED
7um1fHKjXG26KPF4oE6PS9	4HlFJV71xXKIGcU3kRyttv
nB7aI6VhCqpFOcwARgVx95	2GYHyAoLWpkxLVa4oYTVko
m7UhQ0V2gnLNUouSGZuaJQ	0HPD5WQqrq7wPWR7P7Dw1i
q69nlgYe2EDdf7CZUfwIuy	4dTaAiV9xFFCxnPur9c9yL
4SPvfqOkFTrAcl2CW3sTwd	3ZdJffjzJWFimSQyxgGIxN
emCDmCsjbrH8WC2D3Qm4U7	3GBApU0NuzH4hKZq4NOSdA
TjvgMoPjZK5Tm3xmZTAqXD	1bM50INir8voAkVoKuvEUI
hkmp2IVS5IU4ZbInZC8r8E	2M9ULmQwTaTGmAdXaXpfz5
f1GOmd2yu5vAj5n9dOu4Nd	5jzKL4BDMClWqRguW5qZvh
5WTRyrgd7TcTXUGfut79fO	4TCL0qqKyqsMZml0G3M9IM
L3Z4rmw6iBK2qbromMSbLC	5vlEg2fT4cFWAqU5QptIpQ
3DYhAdvFvIeZ3X9mHs3xvd	6lV2MSQmRIkycDScNtrBXO
F5UM2SnLkH0ySd08KbzhPi	4AYX69oFP3UOS1CFmV9UfO
2gqJXXfuCC3KEtxiwNraDr	6DkXLzBQT7cwXmTyzAB1DJ
5WTRyrgd7TcTXUGfut79fO	1HHeOs6zRdF8Ck58easiAY
09mA6vMx1zYyUhuvpfv056	5sra5UY6sD658OabHL3QtI
1mbH9U7RhYZgALbPOeNd1a	6BdgtqiV3oXNqBikezwdvC
zVozFPnILLZ0J5sb2QNNGH	7ElF5zxOwYP4qVSWVvse3W
QNuiqGtNXLsy08bRj50abu	6wN4nT2qy3MQc098yL3Eu9
ApKUCnrZX8mCPqWJDxsDmI	4YYHgF9dWyVSor0GtrBzdf
T2XVW8W9ytnKghnxrLcYHf	61LtVmmkGr8P9I2tSPvdpf
m7UhQ0V2gnLNUouSGZuaJQ	0WCiI0ddWiu5F2kSHgfw5S
I42pCTvXJYF9TJ1jle9uXH	2DHc2e5bBn4UzY0ENVFrUl
1mbH9U7RhYZgALbPOeNd1a	4BycRneKmOs6MhYG9THsuX
sla8XwqUbMQyNtasS4HQhT	4u26EevCNXMhlvE1xFBJwX
qf46gSnCtdiswRzehPxBb9	0oJMv049q8hEkes9w0L1J4
q0a6LQWSQyZ48hwtSEPZgk	7HacCTm33hZYYN8DXpCYuG
JkA4nuYwDW1nyZjqdbicXh	0JcKdUGNR7zI4jJDLyYXbi
TjvgMoPjZK5Tm3xmZTAqXD	030OCtLMrljNhp8OWHBWW3
0C4KIWtMQEPWb6y85RoFRN	7hR5toSPEgwFZ78jfHdANM
DOksD6YNbDUFm4mq9gtSBS	2r6DdaSbkbwoPzuK6NjLPn
vIxSJkLp4IrMoBlkP9YZoB	45O0tUN9Bh6LH4eNxQ07AT
Us7PErcBOp7KxKMAfAvIkX	37dYAkMa4lzRCH6kDbMT1L
uTK4FATArVi7vVsUkKNcrZ	7AqISujIaWcY3h5zrOqt5v
G4FL3sxSvcGZwWUslg6ReT	1hBM2D1ULT3aeKuddSwPsK
PfGnntldazb9OUI3emzkUE	0dBW6ZsW8skfvoRfgeerBF
rxJaVhmhN5Bo8yNPAvqTYp	07WEDHF2YwVgYuBugi2ECO
0C4KIWtMQEPWb6y85RoFRN	4gs07VlJST4bdxGbBsXVue
WISE6xmS5ARCPYnk1oYsKk	3uIGef7OSXkFdqxjFWn2o6
ZEWxHP66vxAahBlDBopew8	2fQ6sBFWaLv2Gxos4igHLy
GoZRTt8NnfK2jxnfqufbUI	1WtTLtofvcjQM3sXSMkDdX
PcT1EPz4a3KNfY9iSDDLvA	2rDwdvBma1O1eLzo29p2cr
ibkYLnbNzNgsJCPKFHjYiJ	5BoIP8Eha5hwmRVURkC2Us
hByTd9bAfXmQ93POTJXQTD	17tDv8WA8IhqE8qzuQn707
e8YBqPOh3y2MUTpQcPW3LA	6KBYk8OFtod7brGuZ3Y67q
mo729wukfvVSH2AjaA5CwA	41KPpw0EZCytxNkmEMJVgr
09mA6vMx1zYyUhuvpfv056	1yK9LISg5uBOOW5bT2Wm0i
RNaK5VPqa1HX4XjqNUxcVf	3VA8T3rNy5V24AXxNK5u9E
lzdr4hJer1Ofl7x9Vg8F5Z	09ZcYBGFX16X8GMDrvqQwt
oX5Dgc2qWPZyNIC8prm7FB	7g13jf3zqlP5S68Voo5v9m
OrsimaVJJStUp2OmS2BCMx	6GgPsuz0HEO0nrO2T0QhDv
GFaFksbZM1HkNLKOcgyOTh	0zREtnLmVnt8KUJZZbSdla
cqClds8QLGLF4bbqNDTNiO	2tNE4DP5nL85XUJv1glO0a
hB611jp9MKsnPtBxlz8hp5	5ZFVacinyPxz19eK2vTodL
hB611jp9MKsnPtBxlz8hp5	5e0dZqrrTaoj6AIL7VjnBM
hVOZtWaUxalQtToAxoOWPx	0XvjOhwCnXXFOSlBbV9jPN
hMJi3w7mbPhmDXO4Mllw6b	31zeLcKH2x3UCMHT75Gk5C
OsFKQGXX5Ro0jXSaocFUCq	6FSxwdN08PvzimGApFjRnY
A4oVEYX3Fgepv2NmY2JAVt	1c8gk2PeTE04A1pIDH9YMk
03Vw0cC606OOtfd9LF0hNF	7LcfRTgAVTs5pQGEQgUEzN
XH35ObLD4cAnI1dGxRXQAx	0IkKz2J93C94Ei4BvDop7P
f1GOmd2yu5vAj5n9dOu4Nd	4r6eNCsrZnQWJzzvFh4nlg
2kxbRH0Uah0OQnltYTwqgZ	2tJulUYLDKOg9XrtVkMgcJ
DStNHUtDTTED7mKqcQ59DE	0JXXNGljqupsJaZsgSbMZV
ImOenLh1uEEejt7GOQp5zW	6nek1Nin9q48AVZcWs9e9D
K4V28eLNYoUklG3KYINEmk	1eyzqe2QqGZUmfcPZtrIyt
ca3Mrw8kcFXttv6qC7QRIZ	5Qy6a5KzM4XlRxsNcGYhgH
q9Pj1cGCCbeehT9c9gswKt	4RL77hMWUq35NYnPLXBpih
QNuiqGtNXLsy08bRj50abu	3hsmbFKT5Cujb5GQjqEU39
7bFiUSt3TpvpzPlt2Nt3cu	3LUWWox8YYykohBbHUrrxd
ImOenLh1uEEejt7GOQp5zW	2U8g9wVcUu9wsg6i7sFSv8
5A42tC20fyhLnN2Q3XvYgE	2i0AUcEnsDm3dsqLrFWUCq
uyTzUQk55xvwquRlUoHNfc	4NTWZqvfQTlOMitlVn6tew
jsitC3iDAYkJ7IOglTFvC5	0aBKFfdyOD1Ttvgv0cfjjJ
bfugUjb4KAemuMqzw5aK4H	608a1wIsSd5KzMEqm1O7w3
KEKE2WLyR2k5GP8ESQNHyE	70ATm56tH7OrQ1zurYssz0
5NE7eqCekyTIiv0bU4elX1	16Of7eeW44kt0a1M0nitHM
1GRaLygoEdn4QrbxgMDqiH	4fINc8dnfcz7AdhFYVA4i7
oNKt8h5YYfQr2klpFMAW22	6r2BECwMgEoRb5yLfp0Hca
7bFiUSt3TpvpzPlt2Nt3cu	3pYDZTJM2tVBUhIRifWVzI
zXXgTXKNfU5TFD348hU5wC	2OXidlnDThZR3zf36k6DVL
xEJ8tNEmGveY9g9UfKwVct	2TUzU4IkfH8kcvY2MUlsd2
1GRaLygoEdn4QrbxgMDqiH	1r3myKmjWoOqRip99CmSj1
xzVeMt5udwpTLA2CmvTyna	1PAYgOjp1c9rrZ2kVQg2vN
C5s9wwJwNyhYWobotXxF4P	53DB6LJV9B8sz0p1s6tlGS
fbgo2VmM0aYOB59uS5aJWV	36cmM3MBMWWCFIiQ90U4J8
afIxZZuQBEov6r847Gzr32	04OxTCLGgDKfO0MMA2lcxv
tsLRJWilHmItpwLIFUOagH	5E6CDAxnBqc9V9Y6t5wTUE
TGcqk3M7RDvxWWYLfZWPW3	1f8UCzB3RqIgNkW7QIiIeP
3i38MFcKyAnvyeIa0I1txv	3SxiAdI8dP9AaaEz1Z24mn
QGEQ3t5p8mPcQJJDRjq8Si	0IF7bHzCXCZoKNog5vBC4g
y26OjaCm5xGkEllTjqnkI0	1Fxp4LBWsNC58NwnGAXJld
4AZbzBrTKlLO4EwEfYshZP	35KiiILklye1JRRctaLUb4
jigQYZRG2pWIkSrpm068jn	3FrX3mx8qq7SZX2NYbzDoj
LENNAEkFWREDdZkPGiC7I7	6y468DyY1V67RBNCwzrMrC
4Q7yRqnNIg5n7ReHTtMgd4	7mdNKXxia7AeSuJqjjA2rb
MrAPjitwjDPsSMKcFaz5wU	3w3y8KPTfNeOKPiqUTakBh
ZelCwRi4p9qHEru9QnDCMi	3TGRqZ0a2l1LRblBkJoaDx
g8pIqGxNEDNdK6VlLOUhmH	7a86XRg84qjasly9f6bPSD
xzGjyw2L7PclvClluKQSrh	1z9kQ14XBSN0r2v6fx4IdG
E3dHnYJCqOd871PkZLV9px	4cluDES4hQEUhmXj6TXkSo
WnNBkQMHY0nHaR7xGMXNV2	2V65y3PX4DkRhy1djlxd9p
fbgo2VmM0aYOB59uS5aJWV	1gihuPhrLraKYrJMAEONyc
bQHa6CvPPHL5X3FnPqLCa2	6VObnIkLVruX4UVyxWhlqm
7tdgca2Wcey2r5OPajRbAe	6lanRgr6wXibZr8KgzXxBl
Ec8fJT1xN7mY6BkuUVHEiU	5UqCQaDshqbIk3pkhy4Pjg
pc6ttdC1zPQmFXN6tOp7MP	2iUmqdfGZcHIhS3b9E9EWq
EAJfIYm6wNqbSOspMJwDE6	6FB3v4YcR57y4tXFcdxI1E
1lWEQkbaJXdisnwHwanXTO	0U10zFw4GlBacOy9VDGfGL
vbnRDDwMRARMMjIB2c3Qxx	0KAiuUOrLTIkzkpfpn9jb9
iAft5A3mX8Y1lxDanCJxZi	1NpW5kyvO4XrNJ3rnfcNy3
4mFIBTKIN3ncuY9geXJp31	1auxYwYrFRqZP7t3s7w4um
PcOL2N8jDroVXvlWnEi8fQ	4wCmqSrbyCgxEXROQE6vtV
hNMm9cGL2SgdkoeZr0QqAA	4Kz4RdRCceaA9VgTqBhBfa
9XP31CaBKqVFrfbPVM4GxG	1oHNvJVbFkexQc0BpQp7Y4
aGAA4uuQLhbePEGimlvC2j	7oVEtyuv9NBmnytsCIsY5I
hu8UtKhLXZbnZLB4oXxfuK	6s8nHXTJVqFjXE4yVZPDHR
LotvOKuFl91BpsqnAcFcGl	1nZzRJbFvCEct3uzu04ZoL
kfT5U5CGtZvPjdGRckVWRT	03UrZgTINDqvnUMbbIMhql
ANrsGkxST7pRQWjUDaaK8R	0TAmnCzOtqRfvA38DDLTjj
vk68LIqlyOoM0W3tijKxYs	56sxN1yKg1dgOZXBcAHkJG
mSCd3tK6a9A0ZJkn0PNrgt	4sOX1nhpKwFWPvoMMExi3q
SgkHoIMsTYrKlkvWXc3uLT	3n69hLUdIsSa1WlRmjMZlW
1lWEQkbaJXdisnwHwanXTO	3tyPOhuVnt5zd5kGfxbCyL
ANrsGkxST7pRQWjUDaaK8R	6Vh03bkEfXqekWp7Y1UBRb
HGWMZZtvNmADnk0XbDW5oB	4qikXelSRKvoCqFcHLB2H2
LotvOKuFl91BpsqnAcFcGl	3oL3XRtkP1WVbMxf7dtTdu
aN1PmNMxfb9FRNhYouFfu1	53QF56cjZA9RTuuMZDrSA6
uosfX9zpJByYEPgsuzkfH3	4P0osvTXoSYZZC2n8IFH3c
ScCeg1AcIW2Dqpo8p8sRvA	1DunhgeZSEgWiIYbHqXl0c
vk68LIqlyOoM0W3tijKxYs	1EAgPzRbK9YmdOESSMUm6P
ZbqVF9MLeVevnhGngRASoK	6HZ9VeI5IRFCNQLXhpF4bq
LiXuGJE3IZx6wluOIsLmES	3sP3c86WFjOzHHnbhhZcLA
7oBsjwjveiVsqbwCQQlm4C	6VRhkROS2SZHGlp0pxndbJ
B2exUPK9T5kOL16qwoU2gA	0lHAMNU8RGiIObScrsRgmP
ImOenLh1uEEejt7GOQp5zW	4HXOBjwv2RnLpGG4xWOO6N
mSCd3tK6a9A0ZJkn0PNrgt	2sEk5R8ErGIFxbZ7rX6S2S
sT64qB1ytY9VsuVawpLGWm	6KuHjfXHkfnIjdmcIvt9r0
g8pIqGxNEDNdK6VlLOUhmH	6t6oULCRS6hnI7rm0h5gwl
Uhv3IxT8ac793dkZQAjeSh	5g7rJvWYVrloJZwKiShqlS
fLaEHBY2dgmJqGhAchgL7v	5ujh1I7NZH5agbwf7Hp8Hc
qnOpU5ZLOMdPo6rKb2ktK1	0RUGuh2uSNFJpGMSsD1F5C
yWvd7fahChwMerfh17getm	3WD91HQDBIavSapet3ZpjG
cwHApq2OwaJAoHciFR1isS	25cUhiAod71TIQSNicOaW3
Su1n5UP2lqqVL81CSGTK1V	5NlFXQ0si6U87gXs6hq81B
3i38MFcKyAnvyeIa0I1txv	2EcsgXlxz99UMDSPg5T8RF
jdvZsuG3il71XS0eeHJmlE	4kte3OcW800TPvOVgrLLj8
RDrHV8poCD11Wu6hoYOKX5	68rcszAg5pbVaXVvR7LFNh
LotvOKuFl91BpsqnAcFcGl	5JLv62qFIS1DR3zGEcApRt
WA8Exu53HfVCvGqU1Kz0fr	4b4c0oH7PtrPsI86drzgFs
OR4ULWr1g3kXH6uOrvpNe1	439TlnnznSiBbQbgXiBqAd
qWl8CEfq2ZgdhdcsLChqSJ	0MOiv7WTXCqvm89lVCf9C8
eqky6vmVnM4IOXObHs1FHG	0c4IEciLCDdXEhhKxj4ThA
yWvd7fahChwMerfh17getm	5wEreUfwxZxWnEol61ulIi
vbnRDDwMRARMMjIB2c3Qxx	2NniAhAtkRACaMeYt48xlD
eXklcDPagskemdr1wixxl8	6j7hih15xG2cdYwIJnQXsq
EJGs08wTDIlOEu3UQxrAyq	06h3McKzmxS8Bx58USHiMq
RIPbjpJVp4LWeFaQwvifUu	0obBFrPYkSoBJbvHfUIhkv
yWvd7fahChwMerfh17getm	0ZyfiFudK9Si2n2G9RkiWj
HSYOaZv3rWMTSSfG1wopcG	78JKJfKsqgeBDBF58gv1SF
fbgo2VmM0aYOB59uS5aJWV	7B1Dl3tXqySkB8OPEwVvSu
JLe1XZ7GmA07M1xpmHvyJj	28GUjBGqZVcAV4PHSYzkj2
rf2DGU6NxaArbeoGLRM9BW	5kcE7pp02ezLZaUbbMv3Iq
sxxcTaedFrEBsF0BICuFPy	1RMRkCn07y2xtBip9DzwmC
ikhmhB4Q9U2EHzwTCGB7tp	3zsRP8rH1kaIAo9fmiP4El
0eCU9CHjzV0H2px0ykCgCO	0vFMQi8ZnOM2y8cuReZTZ2
lYG8tLZpeVwMxndjxSulDe	2L7rZWg9RLxIwnysmxm4xk
zc2fqZvKJWwaseCGTIHPjD	3e0yTP5trHBBVvV32jwXqF
9ByWgmy0wGnW83XMMqKIM4	4rHZZAmHpZrA3iH5zx8frV
gAcHi1rckOBp87qNxdeKBf	5PUvinSo4MNqW7vmomGRS7
aVjUrDKgxT8d8DhukT8OaK	2dLLR6qlu5UJ5gk0dKz0h3
LN38h8kksPxGb9KMfV9dJt	2QjOHCTQ1Jl3zawyYOpxh6
eqMeD7j7bFidg4DycLuRu1	3JvKfv6T31zO0ini8iNItO
14LKOnKDKl4of348SlyER1	0nrRP2bk19rLc0orkWPQk2
GDJWkBS3fxHHWvGajeXf8L	5FVd6KXrgO9B3JPmC8OPst
ExbrjCkHarShBwLwtPlzGc	6Z8R6UsFuGXGtiIxiD8ISb
nuVKfXQ8vbvFRU9eq7qfUf	4G8gkOterJn0Ywt6uhqbhp
MrAPjitwjDPsSMKcFaz5wU	0nJW01T7XtvILxQgC5J7Wh
qzjKn6b9XVF0WShYzSkgAo	2XHzzp1j4IfTNp1FTn7YFg
qFcMbu76A6zVBJ0QZynDbs	1mKXFLRA179hdOWQBwUk9e
wSZrg2L1j48eG1dGw0hlVq	1yjY7rpaAQvKwpdUliHx0d
evNI7LJKF5hsJy1POUwaQS	3bidbhpOYeV4knp8AIu8Xn
HTZ6iJihPth59V4bcupVGO	2Foc5Q5nqNiosCNqttzHof
GDJWkBS3fxHHWvGajeXf8L	086myS9r57YsLbJpU0TgK9
lYG8tLZpeVwMxndjxSulDe	190jyVPHYjAqEaOGmMzdyk
9VBwBhONRYmFTjoS84qEIM	2vwlzO0Qp8kfEtzTsCXfyE
MrAPjitwjDPsSMKcFaz5wU	55h7vJchibLdUkxdlX3fK7
2Rl1LsoIrMvYVRhQj9Nsdp	0NlGoUyOJSuSHmngoibVAs
Uhv3IxT8ac793dkZQAjeSh	2ihCaVdNZmnHZWt0fvAM7B
evNI7LJKF5hsJy1POUwaQS	6CjtS2JZH9RkDz5UVInsa9
lfgJolbOPS5xAbW8QoY03w	5cc9Zbfp9u10sfJeKZ3h16
mvNJXaToliDuU7NWXOthAO	5CMjjywI0eZMixPeqNd75R
7CBUtgqTxsm7PP98FuOQlA	5DI9jxTHrEiFAhStG7VA8E
feKDSQUbLKICSZJQ8onRnP	0qwcGscxUHGZTgq0zcaqk1
Oyhx8KSPSNUpA1Z7Yql4oh	0S4RKPbRDA72tvKwVdXQqe
5y2DIj3hRAb4kqukHLlGw6	0mvkwaZMP2gAy2ApQLtZRv
fbgo2VmM0aYOB59uS5aJWV	1KtD0xaLAikgIt5tPbteZQ
dmuRZRc6OUKy8J9WSzp3Bu	5jyUBKpmaH670zrXrE0wmO
2Rl1LsoIrMvYVRhQj9Nsdp	6KkyuDhrEhR5nJVKtv9mCf
tHapRMl6Sd4dfLdsgKbfs2	3Tu7uWBecS6GsLsL8UONKn
O7yCVxgo6ZfGREbFS1owST	01TuObJVd7owWchVRuQbQw
VaIT9VYZ0c0hLm2peBEgSf	5VSCgNlSmTV2Yq5lB40Eaw
B2exUPK9T5kOL16qwoU2gA	2QD4C6RRHgRNRAyrfnoeAo
fbgo2VmM0aYOB59uS5aJWV	1oHxIPqJyvAYHy0PVrDU98
1emBPKN1KDyxLMFuXfisEe	1zVhMuH7agsRe6XkljIY4U
CiEHZKcpR6NJk7VIXi2LKn	5zdkUzguZYAfBH9fnWn3Zl
i1a3XP4M9oQdN7YwLyvNbL	5FljCWR0cys07PQ9277GTz
Lbx5pN5KCnnni67Zvkro4u	5BhsEd82G0Mnim0IUH6xkT
hu8UtKhLXZbnZLB4oXxfuK	0s0JMUkb2WCxIJsRB3G7Hd
PhWiBZouTZ1ZAo6nQgEDSV	52gvlDnre9craz9dKGObp8
MZbGnPU1lZpfvvBeWJJqQt	5vL0yvddknhGj7IrBc6UTj
PS8ZM5J057W6EpoJKKOOQh	2FV7Exjr70J652JcGucCtE
T7NxzTTggdT3gtq7RbDuVN	5O2P9iiztwhomNh8xkR9lJ
SKZyDF66bl5uEXFdL14Wq8	2tpWsVSb9UEmDRxAl1zhX1
yz7aUB4fNV1SdBHPocNiEN	0FDzzruyVECATHXKHFs9eJ
QKiHO8PXsxZn8zsxZMz9rc	1HNkqx9Ahdgi1Ixy2xkKkL
gtwdIQz5p2IQRMCNcuPuUZ	3U4isOIWM3VvDubwSI3y7a
2pHMSrxrKZRsxRL40p3vkB	7795WJLVKJoAyVoOtCWqXN
avHL55XdULYRbi7pc24Uog	4gbVRS8gloEluzf0GzDOFc
FSScrD2sBMDenVsRr5yjPV	6YUTL4dYpB9xZO5qExPf05
tHapRMl6Sd4dfLdsgKbfs2	3cHyrEgdyYRjgJKSOiOtcS
xhC6tcM42ulhDUOtMnT2Tg	4nVBt6MZDDP6tRVdQTgxJg
9aU6jEovwmNfv0jlsXQaU8	6RtPijgfPKROxEzTHNRiDp
BexOdwGjRBGwRVgbZUrrUq	62ke5zFUJN6RvtXZgVH0F8
QKiHO8PXsxZn8zsxZMz9rc	34gCuhDGsG4bRPIf9bb02f
2pHMSrxrKZRsxRL40p3vkB	5Nm9ERjJZ5oyfXZTECKmRt
VkFPm1RMxdOTrPHZWZrfXi	6FE2iI43OZnszFLuLtvvmg
avHL55XdULYRbi7pc24Uog	2iuZJX9X9P0GKaE93xcPjk
oMasAYdrJSlv5TzCr84S5O	60nZcImufyMA1MKQY3dcCH
hQ1DnvWyq9wnE6Og4Uvfr2	2ixsaeFioXJmMgkkbd4uj1
VEkGohaAwJAyKX8U1WFMlp	5Hroj5K7vLpIG4FNCRIjbP
T7NxzTTggdT3gtq7RbDuVN	2Bs4jQEGMycglOfWPBqrVG
ZJY1p5Vyg3rBHCIJ11csYn	0puf9yIluy9W0vpMEUoAnN
gHqFUMY18q4QDyFgfpdOdt	7vS3Y0IKjde7Xg85LWIEdP
KtrCTSJhbbpviHk8XFoJOE	4N1MFKjziFHH4IS3RYYUrU
fi1D6XkwhrY3Bu1OHVb35m	5lF0pHbsJ0QqyIrLweHJPW
JZ5MrfdrNtzLMNSaN9NIwQ	5jE48hhRu8E6zBDPRSkEq7
TgMoI8Qo8RIyKalAghZMeG	5BrTUo0xP1wKXLJWUaGFtk
3mTB6fdrTmBctFwrHxXmF9	14OxJlLdcHNpgsm4DRwDOB
BgWuuVKTDLGmW1vO6cxZbL	6Vc5wAMmXdKIAM7WUoEb7N
w8zab6XjGbjPkPxAMo5mM9	0Dc7J9VPV4eOInoxUiZrsL
i1a3XP4M9oQdN7YwLyvNbL	5KONnBIQ9LqCxyeSPin26k
SKZyDF66bl5uEXFdL14Wq8	5BJSZocnCeSNeYMj3iVqM7
tzWujAKTKJjDRvKipmbgQf	7m3povhdMDLZwuEKak0l0n
6F4SloVvfD5Dc4sMFVmY5M	39lS97papXAI72StGRtZBo
HCRcGt6BUiu9LlC1yfI2M4	2GQEM9JuHu30sGFvRYeCxz
7fPaPtZG8KuFDhUPEoSp7w	69gQgkobVW8bWjoCjBYQUd
YEDP2Zao3uyqExotpuQXjt	1fu5IQSRgPxJL2OTP7FVLW
mioV6HHCbvcUoYxefkOGHc	2dRvMEW4EwySxRUtEamSfG
ItOtP3GqqsZ9hO21w0RKHR	2stPxcgjdSImK7Gizl8ZUN
i1a3XP4M9oQdN7YwLyvNbL	2sLwPnIP3CUVmIuHranJZU
aBi3wyQwTCV9uABO9HpEXV	4z7gh3aIZV9arbL9jJSc5J
tLH5k4hITUqa2vMlJ8kqrf	3nB82yGjtbQFSU0JLAwLRH
SIA2OElYUyIfysFudwiyVF	6p5abLu89ZSSpRQnbK9Wqs
f4zKlk4yTm8FM2YrgpZBsV	32OlwWuMpZ6b0aN2RZOeMS
yeNusMSn44IStFkwLLdTNq	2JzZzZUQj3Qff7wapcbKjc
OhyCRR8AAeIniOkxEEUChH	4B0JvthVoAAuygILe3n4Bs
1lqnHSIfwwGuVK6f8tyGVd	1Lim1Py7xBgbAkAys3AGAG
C4OHIqLyBufUHm7d8VVytu	2PIvq1pGrUjY007X5y1UpM
Eip5OsdTNeXizV4v6qU72R	3zHq9ouUJQFQRf3cm1rRLu
UOLEFHUQ1b8gl5AjQdbdJQ	0ct6r3EGTcMLPtrXHDvVjc
QjHrUA52omUZepJoiryOAl	6K4t31amVTZDgR3sKmwUJJ
F0tBSOBor3SSYUAmEWjZC6	5E30LdtzQTGqRvNd7l6kG5
fFKLuyVmwQntfT7wk2vSis	7aXuop4Qambx5Oi3ynsKQr
CtMHnFYKnlLVMZMJrdzvab	19cL3SOKpwnwoKkII7U3Wh
Y2543SqLZGdiCNRtHLrlix	5s7xgzXtmY4gMjeSlgisjy
eEemh7JJDWHXLTlGgcIbvr	1JDIArrcepzWDTAWXdGYmP
5y0bDXN9bf9tbkd72WZSbB	2S5LNtRVRPbXk01yRQ14sZ
XL4QEuvZTUlmyNigmFPvs3	1WoOzgvz6CgH4pX6a1RKGp
Brk5mVPpW3Ewl2FE20a2Bc	7MXVkk9YMctZqd1Srtv4MB
rEjj5noxgRHDXwN31NOuF9	1zi7xx7UVEFkmKfv06H8x0
OhyCRR8AAeIniOkxEEUChH	50kpGaPAhYJ3sGmk6vplg0
TwfLuc2ppst9FqDxlyqVgI	7BKLCZ1jbUBVqRi2FVlTVw
itSDqOtn4MS7QnPDDFVe9c	62PaSfnXSMyLshYJrlTuL3
AaMOSu3E3DOhDwTN2UjQeX	3xKsf9qdS1CyvXSMEid6g8
VIFdrPq5rp0E4AMbRsPhNa	3QGsuHI8jO1Rx4JWLUh9jd
IniTpg8lC2b99Nv8ZGaNQ6	6b3b7lILUJqXcp6w9wNQSm
Uaxq3DxO6YLhCi9gkbBTK8	0lYBSQXN6rCTvUZvg9S0lU
f4FOUbugWrhDPurM39XEwx	72TFWvU3wUYdUuxejTTIzt
Veo9OcOWKxRCCTh7pFDKm0	2Z8WuEywRWYTKe1NybPQEW
OhyCRR8AAeIniOkxEEUChH	09CtPGIpYB4BrO8qb1RGsF
HytghV1QSNDuRYJhYFirDG	5kqIPrATaCc2LqxVWzQGbk
HQvngT6gmiHngziPYrggbh	3RiPr603aXAoi4GHyXx0uy
B4faG1yY2t5b3Uinq4kfqv	0azC730Exh71aQlOt9Zj3y
HtV5W9zq946ik1fWri27mh	3pXF1nA74528Edde4of9CC
KQEMNSXft8tqXcD4fRWrCU	76hfruVvmfQbw0eYn1nmeC
f4FOUbugWrhDPurM39XEwx	4pAl7FkDMNBsjykPXo91B3
0XH4ou2qfnmx2p3135bars	1i1fxkWeaMmKEB4T7zqbzK
eJSJ3m4nmyK3EX8PGoKtuj	6i0V12jOa3mr6uu4WYhUBr
yzjCXlHQWVSYhI3AF5KBdT	23L5CiUhw2jV1OIMwthR3S
mbFXMOi5zNPQSDT5MlhIMM	2BOqDYLOJBiMOXShCV1neZ
ZkppOZInxmljFSbe4EjwwV	698ItKASDavgwZ3WjaWjtz
jOcM1YXlJMJdBFBZjGOM6A	0vbtURX4qv1l7besfwmnD8
yLgwhAFmxOb9Pf54YC18kk	0y60itmpH0aPKsFiGxmtnh
EgZyDWbjtqmnjg1xAnaZev	0VhgEqMTNZwYL1ARDLLNCX
4gU0hJTbPQuG9gDlYrcqB5	1A8j067qyiNwQnZT0bzUpZ
rEjj5noxgRHDXwN31NOuF9	3O8NlPh2LByMU9lSRSHedm
itSDqOtn4MS7QnPDDFVe9c	0t7fVeEJxO2Xi4H2K5Svc9
7hCVyTtVM8GSd059e3ZFHl	7lGKEWMXVWWTt3X71Bv44I
SXKSIHAEaqcllq4sspQEHI	2GyA33q5rti5IxkMQemRDH
VG5k6ec1Emeiu3f3H9nDjK	0TXNKTzawI6VgLoA9UauRp
thOmKbAM1UNqD98AArXlDu	5n0CTysih20NYdT2S0Wpe8
ZqU1jM3YpUxbB9KnuMvEIq	7EVk9tRb6beJLTHrg6AkY9
hsjhvIGhKASPzjxTgMH184	27GmP9AWRs744SzKcpJsTZ
3Dyptw8ES7q2eGB7fTSTnr	5hc71nKsUgtwQ3z52KEKQk
1Ru5FYEzNIKNM7ByfDjvdT	7qiZfU4dY1lWllzX7mPBI3
MMj6tlEaqaAAtONpeGdLBz	0pqnGHJpmpxLKifKRmU6WP
DYc82k41IVcP5Yy58r8lsY	6habFhsOp2NvshLv26DqMb
uXAn01sEKucbx8jdYgs5vC	1PSBzsahR2AKwLJgx8ehBj
ifAbu3IaL0MPRtSw1xZbox	5knuzwU65gJK7IF5yJsuaW
WSx1yfmFnbNWbN4PoDTLNW	1rfofaqEpACxVEHIZBJe6W
MMj6tlEaqaAAtONpeGdLBz	1zB4vmk8tFRmM9UULNzbLB
oVY5eQ5EDi1gRZp3cM24Yp	1nueTG77MzNkJTKQ0ZdGzT
5udkiavO1L1Ql71gthvgby	0KKkJNfGyhkQ5aFogxQAPU
1Ru5FYEzNIKNM7ByfDjvdT	0tgVpDi06FyKpA1z0VMD4v
pffwrcdv6mYS8kGprm5r2t	7JJmb5XwzOO8jgpou264Ml
EgZyDWbjtqmnjg1xAnaZev	5uCax9HTNlzGybIStD3vDh
sDdieEC8vk3NJZbBnB6pnD	5mCPDVBb16L4XQwDdbRUpz
k7wxWybRpL7gLINXf37xIf	6gBFPUFcJLzWGx4lenP6h2
nMjQmVgLliURKSFzs1vACs	1mXVgsBdtIVeCLJnSnmtdV
81m49NLePQpOCfY4KI7pKJ	1P17dC1amhFzptugyAO7Il
N88lxVcPKBXOzrcCXN3v1g	7KXjTSCq5nL1LoYtL7XAwS
DLpnimNWMVvoSVIcZo99vj	3B54sVLJ402zGa6Xm4YGNe
f4FOUbugWrhDPurM39XEwx	5oO3drDxtziYU2H1X23ZIp
tg4DjtBHNnTt9f5SVVzCM8	0jdny0dhgjUwoIp5GkqEaA
GYFLlFaEjPeTYA67df5YNh	0zbzrhfVS9S2TszW3wLQZ7
pojqEe5KA7rxlrOToGU9Xi	0SGkqnVQo9KPytSri1H6cF
Vb3nt9CpuWZr22HGfLHL6y	29JrmE89KgRyCxBIzq2Ocw
TQVZvYPr9GUjqcv7gIVYew	45XhKYRRkyeqoW3teSOkCM
oklCYUa2mBJA3nq2Y2sNDn	2qT1uLXPVPzGgFOx4jtEuo
u3RiwNHtNkWEGsk4tESrgu	0u2P5u6lvoDfwTYjAADbn4
9Wt4REtMdHDCq8OxuJztAw	7ef4DlsgrMEH11cDZd32M6
81m49NLePQpOCfY4KI7pKJ	6NFyWDv5CjfwuzoCkw47Xf
oklCYUa2mBJA3nq2Y2sNDn	5OCJzvD7sykQEKHH7qAC3C
79OmYA5dWPLo2AXXliIkjF	6DCZcSspjsKoFjzjrWoCdn
K4iVMYr4Sgbvwoe5kXKXqg	2xLMifQCjDGFmkHkpNLD9h
8xjeSVf4DCcxe7BasZB4FL	0e7ipj03S05BNilyu5bRzt
g987bkRnnjjYcXDbO1TQ5R	6IPwKM3fUUzlElbvKw2sKl
gSv7qTs8eStrHWORg5hYWq	3GCdLUSnKSMJhs4Tj6CV3s
hKjQPi3h4dYfCusLglkKlF	58kZ9spgxmlEznXGu6FPdQ
24dEITbt61Jlluhm2IauKp	4EAV2cKiqKP5UPZmY6dejk
oVY5eQ5EDi1gRZp3cM24Yp	6V1bu6o1Yo5ZXnsCJU8Ovk
jKOw9QREER77NNFxM3aXVR	2xGjteMU3E1tkEPVFBO08U
ClkHvEHx4OXGFajwkQKdjr	5WvAo7DNuPRmk4APhdPzi8
gy2TH09GSEAvAFcPLOLWR6	1BuZAIO8WZpavWVbbq3Lci
SSv2vWLpaH8oLYAzORt9Gc	0ZNrc4kNeQYD9koZ3KvCsy
HU5rH7TCxDXu3NyGh1HzMV	5gW5dSy3vXJxgzma4rQuzH
I9Co1JiseRX08xDrLMmMhK	083Qf6hn6sFL6xiOHlZUyn
tkQF4Bcmh9ytLD6b73Jz4Y	2YpeDb67231RjR0MgVLzsG
sXF5w1SSO7BOUBh4oeTXl2	2Fxmhks0bxGSBdJ92vM42m
rWs8X7tBbjSuw3JUipkXQK	6v3KW9xbzN5yKLt9YKDYA2
mBW0t8OTI13cfu6QGgWDpO	1BxfuPKGuaTgP7aM0Bbdwr
WtKSmRFwq1YGrQymSrqaxp	21jGcNKet2qwijlDFuPiPb
jnI1rPljcfCki1mwl68QYc	2qxmye6gAegTMjLKEBoR3d
JBRPlkZhM1kRTwXJ2Q3yYK	5p7ujcrUXASCNwRaWNHR1C
exF1qMShRdmaDTdvOVB9BT	2vXKRlJBXyOcvZYTdNeckS
Lx9E3YScDN73wJzMn0VRJe	7qEHsqek33rTcFNT9PFqLf
05bAUqt1t1ZnwrBSJUOLZT	0Oqc0kKFsQ6MhFOLBNZIGX
WRAW5S89ol8as3SX1trIYE	2JvzF1RMd7lE3KmFlsyZD8
mBW0t8OTI13cfu6QGgWDpO	1dGr1c8CrMLDpV6mPbImSI
sXF5w1SSO7BOUBh4oeTXl2	43zdsphuZLzwA9k4DJhU0I
WtKSmRFwq1YGrQymSrqaxp	7xQAfvXzm3AkraOtGPWIZg
K941V577nQ3yxGOssbbV50	22vgEDb5hykfaTwLuskFGD
F6S5gbLagjHutcSnMyxnbX	4l0Mvzj72xxOpRrp6h8nHi
XuPFuHysdMjwv8Iu9568Uc	3e9HZxeyfWwjeyPAMmWSSQ
mExcmIQRoJ5tbpVA9Ym5y1	1rqqCSm0Qe4I9rUvWncaom
mBW0t8OTI13cfu6QGgWDpO	6RRNNciQGZEXnqk8SQ9yv5
8xjeSVf4DCcxe7BasZB4FL	7dt6x5M1jzdTEt8oCbisTK
Yo4CiC2sLfRvSSJKVWj82L	2t8yVaLvJ0RenpXUIAC52d
RaQUVeRvV9RFNJZMPyisFb	1lOe9qE0vR9zwWQAOk6CoO
sSFkuXpkDpBZPUlAPdlANZ	7DnAm9FOTWE3cUvso43HhI
Wwul1C732vLOM3YlQlcMJe	1wJRveJZLSb1rjhnUHQiv6
OV44y9bc1t3sSenruWbuCM	7tFiyTwD0nx5a1eklYtX2J
Ml5cO85RH0Xl8MbGzsmB1N	132ALUzVLmqYB4UsBj5qD6
K941V577nQ3yxGOssbbV50	0DiDStADDVh3SvAsoJAFMk
4JqoJTtUn1zmf5kl8lHHJM	5itOtNx0WxtJmi1TQ3RuRd
sSFkuXpkDpBZPUlAPdlANZ	2Xnv3GntqbBH1juvUYSpHG
Lx9E3YScDN73wJzMn0VRJe	0pEkK8MqbmGSX7fT8WLMbR
FgBtlRNFolgC2Ya091tV5H	6TqXcAFInzjp0bODyvrWEq
8m1tZbEnGgBAYJHrD9Z9n9	1000nHvUdawXuUHgBod4Wv
mUPVmjivXrykyiqMP0pbRT	5ls62WNKHUUrdF3r1cv83T
qQrxVMu98SUnQb1GteSarL	19kUPdKTp85q9RZNwaXM15
S9vRTJwSRyAuivIMvRjCed	5N1o6d8zGcSZSeMFkOUQOk
29sRiZo2KJyxveON9iEUcT	3iH29NcCxYgI5shlkZrUoB
8Z7m4KPre67LA5c9DfQs4E	6ImEBuxsbuTowuHmg3Z2FO
TSY3wLwOoZ2vxnXtd6XQxm	1AI7UPw3fgwAFkvAlZWhE0
qHyQbijU1HMpmEskyLIHuG	5GBuCHuPKx6UC7VsSPK0t3
ui0ZFt8M0HnB9ufuHssm0m	0sf12qNH5qcw8qpgymFOqD
lyh9dhdY7SFvLeiUnkFX2d	4LEK9rD7TWIG4FCL1s27XC
5bNA4ljkzVbY4a7COY6boT	7igeByaBM0MgGsgXtNxDJ7
kA31sEW2pWHlJrIbmojmKa	6UelLqGlWMcVH1E5c4H7lY
kjTW4EhTW8g0j9x4KPsPVV	22LAwLoDA5b4AaGSkg6bKW
D1WK9ih865OnSBzZPvLpVz	0nbXyq5TXYPCO7pr3N8S4I
xFh85SC04epawID4MyRnYg	127QTOFJsJQp5LbJbu3A1y
mL95zwFFg8UxiryBp35p1p	5RqR4ZCCKJDcBLIn4sih9l
OZnhY94gp1peCrK8xrLYMC	7eJMfftS33KTjuF7lTsMCx
kWTu8vPXjhMONiTWqtIfLp	4xqrdfXkTW4T0RauPLv3WA
35cikXHHKHaFvIalZZonbq	3ZCTVFBt2Brf31RLEnCkWJ
XVIxRoUeucGvDOaSkh4ZwZ	3Dv1eDb0MEgF93GpLXlucZ
y5sxQInj8A2fL2FsLtAk4b	0v1x6rN6JHRapa03JElljE
l9RS6OpmaT1fjQghbTNbjb	3tjFYV6RSFtuktYl3ZtYcq
rDGf6ffcpANtuKNkvKa7xy	0PvFJmanyNQMseIFrU708S
7VdQTsonRGH4oe7iTJXX5G	2Wo6QQD1KMDWeFkkjLqwx5
tX9B1X5tUSe0Vo6ZC1NUwV	1Cv1YLb4q0RzL6pybtaMLo
kA31sEW2pWHlJrIbmojmKa	3jjujdWJ72nww5eGnfs2E7
UBlJ7ZeeAQwPEeiVhTJA7f	2SAqBLGA283SUiwJ3xOUVI
M1PDjVsVPSxjqDYksT9GA3	2Z8yfpFX0ZMavHkcIeHiO1
EzIBRHlZVwVdHwVo2sAJWB	1DWZUa5Mzf2BwzpHtgbHPY
rAr0wWEAlhy4j8vNdxOyrw	2ygvZOXrIeVL4xZmAWJT2C
HGFqAgFZbdLRx2HmhYGTJf	7lPN2DXiMsVn7XUKtOW1CS
uQ3Mbu3t63W7V6b1EdHi5e	67BtfxlNbhBmCDR2L2l8qd
1RBvSmcI9Vb5SZvQxT5EOQ	3Wrjm47oTz2sjIgck11l5e
LjWfylLxGDRA5VnjhLCBkm	37BZB0z9T8Xu7U3e65qxFy
9Zp669b3CjPBb7VuSKQrDE	4iJyoBOLtHqaGxP12qzhQI
CtReaEYhkIUiPsT2y1zlph	7MAibcTli4IisCtbHKrGMh
L7FGA7iZNxphb8lrXys1zV	61KpQadow081I2AsbeLcsb
Wd2zsPWac3xINaibmNl05I	3YJJjQPAbDT7mGpX3WtQ9A
lgT12R1oOMVVfckUZDxY4g	6PQ88X9TkUIAUIZJHW2upE
8MHxceyBSewF52BlJAWvIJ	5HCyWlXZPP0y6Gqq8TgA20
mlRlxxucEEcTn8Zkwfj5a2	5Z9KJZvQzH6PFmb8SNkxuk
mxygbXBRF9NvDnVjaxNN47	748mdHapucXQri7IAO8yFK
1NuTHGjWBPCO7XauMEOp7a	6PERP62TejQjgHu81OHxgM
a08tldRUjMYfFApgu7tuBt	3FAJ6O0NOHQV8Mc5Ri6ENp
FUcQ40iN1mBIRMBTDdATqW	0gplL1WMoJ6iYaPgMCL0gX
7ayKa2UThGp8JRt2ykqMEr	5enxwA8aAbwZbf5qCHORXi
iQz5Hn5sSVoxaty4ShaRnT	4RVwu0g32PAqgUiJoXsdF8
sm6SW9eXP9ziQSAXxiAdYD	40iJIUlhi6renaREYGeIDS
yR2IuTnTXMa9CByAgDucmI	6Uj1ctrBOjOas8xZXGqKk4
ACYbRJ2CwobghFSijBlMbp	3Ofmpyhv5UAQ70mENzB277
VZAmsMVpnJpn8YIM5jeJ05	7hU3IHwjX150XLoTVmjD0q
DDDRgCngHduf4ZcIVgZeiB	3VqeTFIvhxu3DIe4eZVzGq
doPGwSUx5FdVcIefJv58SM	463CkQjx2Zk1yXoBuierM9
CdqGklcc9HWxibcFUI6eOE	4fSIb4hdOQ151TILNsSEaF
lX3fgePMdqwd4DETy543Jq	6Im9k8u9iIzKMrmV7BWtlF
RCDfBYhqsIcei29jJ5XUA3	10hcDov7xmcRviA8jLwEaI
B1l1c1kijmZsKluOBjiLMw	4pt5fDVTg5GhEvEtlz9dKk
wQdosoiodfAqZsij5MWFoj	0z8hI3OPS8ADPWtoCjjLl6
kBVviPYomJId6YL7O3WFXn	07MDkzWARZaLEdKxo6yArG
K2JLq6nAkDEcpPGthcfpF2	0eu4C55hL6x29mmeAjytzC
PoR7IBAE6GMuTNMWtq4Y2N	3nY8AqaMNNHHLYV4380ol0
CcdOs1XlSziFjLo3GFqT3Q	0WSEq9Ko4kFPt8yo3ICd6T
Vm4vNAZPz2gaOgA2AmHGqt	4LRPiXqCikLlN15c3yImP7
TJLNdIPReZFoj2z4xC6jGr	1IHWl5LamUGEuP4ozKQSXZ
fkrdol9gOidN8J4Q4M3nGW	0V3wPSX9ygBnCm8psDIegu
vadGh32RPfmGgXgVDuvVaA	3nqQXoyQOWXiESFLlDF1hG
5kfmcehxWSzWiVRRjRn3zG	29d0nY7TzCoi22XBqDQkiP
yqbRlCgtWdvyC6yivZW1Mt	6xGruZOHLs39ZbVccQTuPZ
h88zi8oQCzrfOeP9OoeGRe	1xzi1Jcr7mEi9K2RfzLOqS
lnTkJz46nWCWhpTKoELM2o	1rDQ4oMwGJI7B4tovsBOxc
KQ9WFNuwGmFvDDXd0dPzWu	02MWAaffLxlfxAUY7c5dvx
KDIGkNG694DeELip5VX7JW	4k6Uh1HXdhtusDW5y8Gbvy
9Zp669b3CjPBb7VuSKQrDE	6I3mqTwhRpn34SLVafSH7G
3CQwlqS0IrFyJqsSwmxL9W	4fouWK6XVHhzl78KzQ1UjL
QPJKhrkNIJjCpuZrCntEBY	1qEmFfgcLObUfQm0j1W2CK
qQOSra1GSEEeF36URg4nTg	5CZ40GBx1sQ9agT82CLQCT
TJLNdIPReZFoj2z4xC6jGr	6Sq7ltF9Qa7SNFBsV5Cogx
QXMrsyu17ghvbLa4hLSdE6	4C6Uex2ILwJi9sZXRdmqXp
hi3PywrKYfGVWMVb0hVn6O	1PckUlxKqWQs3RlWXVBLw3
Pb4JMl8kOeG4DXDvFsbsFi	27NovPIUIRrOZoCHxABJwK
fWxzm3LslYwy8VBuuHkON9	2tTmW7RDtMQtBk7m2rYeSw
q3kuZ3zSioln50YVrFf0fE	5ildQOEKmJuWGl2vRkFdYc
qchmZl5JXgYaZbr7fVZcQy	7rglLriMNBPAyuJOMGwi39
wGB2kDeEdP4RREJxhSWdDc	5IgjP7X4th6nMNDh4akUHb
Km8FhoBBZYo6BZaG3WP2Zk	59CfNbkERJ3NoTXDvoURjj
fkrdol9gOidN8J4Q4M3nGW	5jQI2r1RdgtuT8S3iG8zFC
Nrga2Ot6f9oSe0pdN54WaM	3IAfUEeaXRX9s9UdKOJrFI
HYjYonlWP1jRVKnUxQTbGb	0skYUMpS0AcbpjcGsAbRGj
mlRlxxucEEcTn8Zkwfj5a2	0e8nrvls4Qqv5Rfa2UhqmO
JNAhPOQM69cvaaDsNGkZNt	4h9wh7iOZ0GGn8QVp4RAOB
TRgPl4vtsHMa7s6GHBlKUy	0mBP9X2gPCuapvpZ7TGDk3
k44YnYQDALbUTKnfqrw1Rs	35ovElsgyAtQwYPYnZJECg
kh17ptYU8O3m5tIuh6jqh1	52xJxFP6TqMuO4Yt0eOkMz
6rztDuATqT1hqyHpeulkSI	2KukL7UlQ8TdvpaA7bY3ZJ
xVue1X991JHOWYx2cJNd3b	7dSZ6zGTQx66c2GF91xCrb
HAcyWGuH1Ch26uRLOPLWbE	2rurDawMfoKP4uHyb2kJBt
TJLNdIPReZFoj2z4xC6jGr	6Xom58OOXk2SoU711L2IXO
O1ngSY5PZKltRIjq8odNfd	0ARKW62l9uWIDYMZTUmJHF
pftRBjrY01ajuOBfy7x7RR	1ri9ZUkBJVFUdgwzCnfcYs
SJoqpkBhtP1wMQZajwAdEp	7mFj0LlWtEJaEigguaWqYh
vSIUBbUUbiFXLlWQ2a4rH7	1oFAF1hdPOickyHgbuRjyX
D76Ubp5dg1VtzpZsenP22g	34ZAzO78a5DAVNrYIGWcPm
kPz9RlLEkOgX5mNwkv0BS8	3F5CgOj3wFlRv51JsHbxhe
fkrdol9gOidN8J4Q4M3nGW	3rWDp9tBPQR9z6U5YyRSK4
rJ8rKtBEaM6ZHGwFoNmwhL	2g6tReTlM2Akp41g0HaeXN
RASyPkhsdLDco9RSYEufbo	4pi1G1x8tl9VfdD9bL3maT
cFB18eEGbRNU8XdoFXtYBY	3LtpKP5abr2qqjunvjlX5i
v858bIrHx2xJn8q67vRS8s	3XOalgusokruzA5ZBA2Qcb
1VQu2bCA0syWiEGV1dcDxC	1r8ZCjfrQxoy2wVaBUbpwg
\.


--
-- TOC entry 4880 (class 0 OID 75918)
-- Dependencies: 222
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.albums (album_id, album_name) FROM stdin;
mBW0t8OTI13cfu6QGgWDpO	Lover
0C4KIWtMQEPWb6y85RoFRN	Battle Studies
SJoqpkBhtP1wMQZajwAdEp	Sweetest Pie
BgWuuVKTDLGmW1vO6cxZbL	Is There Anybody Out There?
v858bIrHx2xJn8q67vRS8s	DS4EVER
qWl8CEfq2ZgdhdcsLChqSJ	Million Voices
itSDqOtn4MS7QnPDDFVe9c	25
nuVKfXQ8vbvFRU9eq7qfUf	Night Visions
QGEQ3t5p8mPcQJJDRjq8Si	Wherever You Will Go
mbFXMOi5zNPQSDT5MlhIMM	Only Human (Deluxe)
JLe1XZ7GmA07M1xpmHvyJj	Strange Clouds
S9vRTJwSRyAuivIMvRjCed	Hot Girl Summer (feat. Nicki Minaj & Ty Dolla $ign)
VkFPm1RMxdOTrPHZWZrfXi	MKTO
eqMeD7j7bFidg4DycLuRu1	Long Way Down (Deluxe)
03Vw0cC606OOtfd9LF0hNF	Hands All Over
Wd2zsPWac3xINaibmNl05I	Good Days
ZqU1jM3YpUxbB9KnuMvEIq	Tuesday (feat. Danelle Sandoval)
TwfLuc2ppst9FqDxlyqVgI	Closer
xEJ8tNEmGveY9g9UfKwVct	The Awakening
1mbH9U7RhYZgALbPOeNd1a	Thank Me Later
VZAmsMVpnJpn8YIM5jeJ05	LALISA
q9Pj1cGCCbeehT9c9gswKt	Birdy
xzVeMt5udwpTLA2CmvTyna	Playing In The Shadows
SXKSIHAEaqcllq4sspQEHI	Handwritten
3Dyptw8ES7q2eGB7fTSTnr	I like it when you sleep, for you are so beautiful yet so unaware of it
l9RS6OpmaT1fjQghbTNbjb	Mood (feat. iann dior)
lYG8tLZpeVwMxndjxSulDe	Believe (Deluxe Edition)
qchmZl5JXgYaZbr7fVZcQy	The Lockdown Sessions
pojqEe5KA7rxlrOToGU9Xi	I Decided.
GYFLlFaEjPeTYA67df5YNh	Raised Under Grey Skies (Deluxe)
mL95zwFFg8UxiryBp35p1p	Party Girl
e8YBqPOh3y2MUTpQcPW3LA	Hands All Over (Deluxe)
G4FL3sxSvcGZwWUslg6ReT	WANT (Deluxe)
OR4ULWr1g3kXH6uOrvpNe1	good kid, m.A.A.d city
Brk5mVPpW3Ewl2FE20a2Bc	Starboy
hNMm9cGL2SgdkoeZr0QqAA	Take Care (Deluxe)
ZJY1p5Vyg3rBHCIJ11csYn	Sweet Talker (Deluxe Version)
TGcqk3M7RDvxWWYLfZWPW3	In Case You Didn't Know
XVIxRoUeucGvDOaSkh4ZwZ	Hot Pink
fi1D6XkwhrY3Bu1OHVb35m	Halcyon Nights
LN38h8kksPxGb9KMfV9dJt	I Love You.
f4FOUbugWrhDPurM39XEwx	ANTI (Deluxe)
HTZ6iJihPth59V4bcupVGO	Get Lucky (Radio Edit) [feat. Pharrell Williams and Nile Rodgers]
m7UhQ0V2gnLNUouSGZuaJQ	Animal (Expanded Edition)
Km8FhoBBZYo6BZaG3WP2Zk	Boyfriend
CtReaEYhkIUiPsT2y1zlph	Leave The Door Open
OsFKQGXX5Ro0jXSaocFUCq	Letters (Deluxe Edition)
K4V28eLNYoUklG3KYINEmk	Hurry Up, We're Dreaming
zXXgTXKNfU5TFD348hU5wC	Own The Night
aBi3wyQwTCV9uABO9HpEXV	Chapter One
mUPVmjivXrykyiqMP0pbRT	nothings ever good enough
PS8ZM5J057W6EpoJKKOOQh	The Bones of What You Believe
RaQUVeRvV9RFNJZMPyisFb	We Love You Tecca
8m1tZbEnGgBAYJHrD9Z9n9	Panini
yzjCXlHQWVSYhI3AF5KBdT	In the Name of Love
OZnhY94gp1peCrK8xrLYMC	death bed (coffee for your head)
QPJKhrkNIJjCpuZrCntEBY	Harry's House
JNAhPOQM69cvaaDsNGkZNt	I Ainâ€™t Worried (Music From The Motion Picture "Top Gun: Maverick")
jOcM1YXlJMJdBFBZjGOM6A	At Night, Alone.
ZelCwRi4p9qHEru9QnDCMi	Kiss (Deluxe)
Pb4JMl8kOeG4DXDvFsbsFi	INDUSTRY BABY (feat. Jack Harlow)
Ec8fJT1xN7mY6BkuUVHEiU	Levels
M1PDjVsVPSxjqDYksT9GA3	Monster
gSv7qTs8eStrHWORg5hYWq	Black Panther The Album Music From And Inspired By
4mFIBTKIN3ncuY9geXJp31	Watch The Throne
ZEWxHP66vxAahBlDBopew8	Ready (Deluxe)
TJLNdIPReZFoj2z4xC6jGr	Un Verano Sin Ti
fbgo2VmM0aYOB59uS5aJWV	18 Months
hsjhvIGhKASPzjxTgMH184	What A Time To Be Alive
kPz9RlLEkOgX5mNwkv0BS8	Honestly, Nevermind
QNuiqGtNXLsy08bRj50abu	F.A.M.E. (Expanded Edition)
Uaxq3DxO6YLhCi9gkbBTK8	Encore
TQVZvYPr9GUjqcv7gIVYew	Grateful
nMjQmVgLliURKSFzs1vACs	The Thrill Of It All (Special Edition)
i1a3XP4M9oQdN7YwLyvNbL	Talk Dirty
B1l1c1kijmZsKluOBjiLMw	Teatro d'ira - Vol. I
JkA4nuYwDW1nyZjqdbicXh	The Incredible Machine
GoZRTt8NnfK2jxnfqufbUI	Battle Of The Sexes (Deluxe)
1RBvSmcI9Vb5SZvQxT5EOQ	Chosen
iQz5Hn5sSVoxaty4ShaRnT	Happier Than Ever
oMasAYdrJSlv5TzCr84S5O	G I R L
fLaEHBY2dgmJqGhAchgL7v	good kid, m.A.A.d city (Deluxe)
HtV5W9zq946ik1fWri27mh	T R A P S O U L
UOLEFHUQ1b8gl5AjQdbdJQ	The Days / Nights
DLpnimNWMVvoSVIcZo99vj	Jungle Rules
emCDmCsjbrH8WC2D3Qm4U7	Tourist History
mo729wukfvVSH2AjaA5CwA	One (Your Name)
ui0ZFt8M0HnB9ufuHssm0m	Blinding Lights
ibkYLnbNzNgsJCPKFHjYiJ	Jason Derulo
sla8XwqUbMQyNtasS4HQhT	The Band Perry
rxJaVhmhN5Bo8yNPAvqTYp	Won't Go Quietly
xFh85SC04epawID4MyRnYg	Toosie Slide
14LKOnKDKl4of348SlyER1	TRUE
HYjYonlWP1jRVKnUxQTbGb	Pink Venom
pc6ttdC1zPQmFXN6tOp7MP	Picture Show
pftRBjrY01ajuOBfy7x7RR	MAMIII
CtMHnFYKnlLVMZMJrdzvab	Bombs Away
5kfmcehxWSzWiVRRjRn3zG	Hounds of Love (2018 Remaster)
L3Z4rmw6iBK2qbromMSbLC	Replay
RNaK5VPqa1HX4XjqNUxcVf	Kaleidoscope Heart
qnOpU5ZLOMdPo6rKb2ktK1	The Twilight Saga: Breaking Dawn - Part 1 (Original Motion Picture Soundtrack)
XL4QEuvZTUlmyNigmFPvs3	Fetty Wap (Deluxe)
9XP31CaBKqVFrfbPVM4GxG	Pink Friday ... Roman Reloaded
HSYOaZv3rWMTSSfG1wopcG	Habits & Contradictions
05bAUqt1t1ZnwrBSJUOLZT	Norman Fucking Rockwell!
pffwrcdv6mYS8kGprm5r2t	Illuminate (Deluxe)
SIA2OElYUyIfysFudwiyVF	Post to Be (feat. Chris Brown & Jhene Aiko)
KDIGkNG694DeELip5VX7JW	Gemini Rights
YEDP2Zao3uyqExotpuQXjt	The Hobbit: The Desolation of Smaug (Original Motion Picture Soundtrack)
oklCYUa2mBJA3nq2Y2sNDn	Sweetener
hMJi3w7mbPhmDXO4Mllw6b	Here I Am (Deluxe Version)
uXAn01sEKucbx8jdYgs5vC	bloom
8xjeSVf4DCcxe7BasZB4FL	beerbongs & bentleys
N88lxVcPKBXOzrcCXN3v1g	DAMN.
1lqnHSIfwwGuVK6f8tyGVd	Peace Is The Mission (Extended)
sSFkuXpkDpBZPUlAPdlANZ	Heaven & Hell
eEemh7JJDWHXLTlGgcIbvr	True Colors
WtKSmRFwq1YGrQymSrqaxp	Hollywood's Bleeding
cFB18eEGbRNU8XdoFXtYBY	Doja
vadGh32RPfmGgXgVDuvVaA	Unholy (feat. Kim Petras)
mvNJXaToliDuU7NWXOthAO	Random Access Memories
gHqFUMY18q4QDyFgfpdOdt	My Everything (Deluxe)
2pHMSrxrKZRsxRL40p3vkB	In The Lonely Hour
Nrga2Ot6f9oSe0pdN54WaM	Envolver
CcdOs1XlSziFjLo3GFqT3Q	Donda
xVue1X991JHOWYx2cJNd3b	PROVENZA
sxxcTaedFrEBsF0BICuFPy	Fortune (Expanded Edition)
DOksD6YNbDUFm4mq9gtSBS	Can't Be Tamed
rEjj5noxgRHDXwN31NOuF9	Views
rf2DGU6NxaArbeoGLRM9BW	Pink Friday ... Roman Reloaded (Deluxe)
8Z7m4KPre67LA5c9DfQs4E	High Expectations
1lWEQkbaJXdisnwHwanXTO	Talk That Talk
k44YnYQDALbUTKnfqrw1Rs	Lift Me Up (From Black Panther: Wakanda Forever - Music From and Inspired By)
avHL55XdULYRbi7pc24Uog	V
3CQwlqS0IrFyJqsSwmxL9W	abcdefu
4AZbzBrTKlLO4EwEfYshZP	Bon Iver
vk68LIqlyOoM0W3tijKxYs	The World From The Side Of The Moon
fkrdol9gOidN8J4Q4M3nGW	Midnights
uTK4FATArVi7vVsUkKNcrZ	The Lady Killer
yWvd7fahChwMerfh17getm	Born To Die â€“ Paradise Edition (Special Version)
3i38MFcKyAnvyeIa0I1txv	Electronic Earth (Expanded Edition)
Lbx5pN5KCnnni67Zvkro4u	Here's To The Good Times
q0a6LQWSQyZ48hwtSEPZgk	Euphoria
VEkGohaAwJAyKX8U1WFMlp	Oh, What A Life
MrAPjitwjDPsSMKcFaz5wU	Unorthodox Jukebox
PcT1EPz4a3KNfY9iSDDLvA	For Your Entertainment
K2JLq6nAkDEcpPGthcfpF2	Ugly is Beautiful: Shorter, Thicker & Uglier (Deluxe)
2gqJXXfuCC3KEtxiwNraDr	Loud (Japan Version)
lzdr4hJer1Ofl7x9Vg8F5Z	Science & Faith
F6S5gbLagjHutcSnMyxnbX	Rare
gtwdIQz5p2IQRMCNcuPuUZ	Love In The Future (Expanded Edition)
C4OHIqLyBufUHm7d8VVytu	Earned It (Fifty Shades Of Grey) [From The "Fifty Shades Of Grey" Soundtrack]
h88zi8oQCzrfOeP9OoeGRe	RENAISSANCE
I42pCTvXJYF9TJ1jle9uXH	Shock Value II
5A42tC20fyhLnN2Q3XvYgE	Whatever
LiXuGJE3IZx6wluOIsLmES	Unbroken
E3dHnYJCqOd871PkZLV9px	Up All Night
f4zKlk4yTm8FM2YrgpZBsV	Uptown Special
TSY3wLwOoZ2vxnXtd6XQxm	No.6 Collaborations Project
PcOL2N8jDroVXvlWnEi8fQ	Making Mirrors
ClkHvEHx4OXGFajwkQKdjr	No Brainer
q69nlgYe2EDdf7CZUfwIuy	One Love (Deluxe)
uyTzUQk55xvwquRlUoHNfc	Lasers
VaIT9VYZ0c0hLm2peBEgSf	Tribute
1VQu2bCA0syWiEGV1dcDxC	Thousand Miles
QKiHO8PXsxZn8zsxZMz9rc	x (Deluxe Edition)
hByTd9bAfXmQ93POTJXQTD	Streets Of Gold
FUcQ40iN1mBIRMBTDdATqW	Easy On Me
tLH5k4hITUqa2vMlJ8kqrf	The 20/20 Experience - 2 of 2 (Deluxe)
y26OjaCm5xGkEllTjqnkI0	Stereo Typical
7ayKa2UThGp8JRt2ykqMEr	Red (Taylor's Version)
lfgJolbOPS5xAbW8QoY03w	Because the Internet
mExcmIQRoJ5tbpVA9Ym5y1	Pray for the Wicked
7um1fHKjXG26KPF4oE6PS9	Save Me, San Francisco (Golden Gate Edition)
tHapRMl6Sd4dfLdsgKbfs2	Global Warming: Meltdown (Deluxe Version)
FSScrD2sBMDenVsRr5yjPV	Motion
RASyPkhsdLDco9RSYEufbo	777
kWTu8vPXjhMONiTWqtIfLp	Kid Krow
7CBUtgqTxsm7PP98FuOQlA	Nothing Was The Same
rJ8rKtBEaM6ZHGwFoNmwhL	Mr. Morale & The Big Steppers
EgZyDWbjtqmnjg1xAnaZev	Back from the Edge
a08tldRUjMYfFApgu7tuBt	TAKE TIME
yz7aUB4fNV1SdBHPocNiEN	Ghost Stories
bfugUjb4KAemuMqzw5aK4H	We The Best Forever
CiEHZKcpR6NJk7VIXi2LKn	Need U (100%) (feat. A*M*E) [Remixes]
EAJfIYm6wNqbSOspMJwDE6	Red (Big Machine Radio Release Special)
1emBPKN1KDyxLMFuXfisEe	human
JZ5MrfdrNtzLMNSaN9NIwQ	Title (Deluxe)
hVOZtWaUxalQtToAxoOWPx	Barbra Streisand
SSv2vWLpaH8oLYAzORt9Gc	STAY DANGEROUS
81m49NLePQpOCfY4KI7pKJ	reputation
gy2TH09GSEAvAFcPLOLWR6	SR3MM
ScCeg1AcIW2Dqpo8p8sRvA	Settle (Deluxe)
QXMrsyu17ghvbLa4hLSdE6	Super Freaky Girl
ANrsGkxST7pRQWjUDaaK8R	Take Me Home (Expanded Edition)
HGFqAgFZbdLRx2HmhYGTJf	drivers license
Veo9OcOWKxRCCTh7pFDKm0	Blurryface
xhC6tcM42ulhDUOtMnT2Tg	Midnight Memories (Deluxe)
BexOdwGjRBGwRVgbZUrrUq	A Perfect Contradiction (Outsiders' Expanded Edition)
wGB2kDeEdP4RREJxhSWdDc	Indigo (Extended)
qQrxVMu98SUnQb1GteSarL	Experiment Extended
4SPvfqOkFTrAcl2CW3sTwd	5
WnNBkQMHY0nHaR7xGMXNV2	Don't You Worry Child
RDrHV8poCD11Wu6hoYOKX5	One Day / Reckoning Song (Wankelmut Remix)
A4oVEYX3Fgepv2NmY2JAVt	21
ZbqVF9MLeVevnhGngRASoK	THIS IS... ICONA POP
4JqoJTtUn1zmf5kl8lHHJM	Giant (with Rag'n'Bone Man)
g987bkRnnjjYcXDbO1TQ5R	we fell in love in october / October Passed Me By
y5sxQInj8A2fL2FsLtAk4b	Dynamite
aVjUrDKgxT8d8DhukT8OaK	Pure Heroine
29sRiZo2KJyxveON9iEUcT	Industry Plant
DYc82k41IVcP5Yy58r8lsY	VIDA
yqbRlCgtWdvyC6yivZW1Mt	Glimpse of Us
sXF5w1SSO7BOUBh4oeTXl2	WHEN WE ALL FALL ASLEEP, WHERE DO WE GO?
WSx1yfmFnbNWbN4PoDTLNW	Camila
7VdQTsonRGH4oe7iTJXX5G	Roses (Imanbek Remix)
hKjQPi3h4dYfCusLglkKlF	Sick Boy
79OmYA5dWPLo2AXXliIkjF	Scorpion
jKOw9QREER77NNFxM3aXVR	This Is Me
CdqGklcc9HWxibcFUI6eOE	Todo De Ti
w8zab6XjGbjPkPxAMo5mM9	Late Nights: The Album
F0tBSOBor3SSYUAmEWjZC6	Wiped Out!
SKZyDF66bl5uEXFdL14Wq8	Native
XuPFuHysdMjwv8Iu9568Uc	thank u, next
qf46gSnCtdiswRzehPxBb9	THE E.N.D. (THE ENERGY NEVER DIES)
HytghV1QSNDuRYJhYFirDG	Lukas Graham
Su1n5UP2lqqVL81CSGTK1V	Take The Crown (Deluxe Edition)
sDdieEC8vk3NJZbBnB6pnD	More Life
HU5rH7TCxDXu3NyGh1HzMV	Dirty Computer
oX5Dgc2qWPZyNIC8prm7FB	Body Talk
KQ9WFNuwGmFvDDXd0dPzWu	Dreamland (+ Bonus Levels)
bQHa6CvPPHL5X3FnPqLCa2	Skyfall
5WTRyrgd7TcTXUGfut79fO	The Fame Monster (Deluxe Edition)
thOmKbAM1UNqD98AArXlDu	Tell Me I'm Pretty
L7FGA7iZNxphb8lrXys1zV	deja vu
HCRcGt6BUiu9LlC1yfI2M4	THE NIGHTDAY
MMj6tlEaqaAAtONpeGdLBz	Evolve
EzIBRHlZVwVdHwVo2sAJWB	Circles
jdvZsuG3il71XS0eeHJmlE	R.E.D. (Deluxe Edition)
evNI7LJKF5hsJy1POUwaQS	The Heist
2Rl1LsoIrMvYVRhQj9Nsdp	In A Perfect World (Expanded Edition)
uQ3Mbu3t63W7V6b1EdHi5e	MONTERO (Call Me By Your Name)
Eip5OsdTNeXizV4v6qU72R	Delirium (Deluxe)
dmuRZRc6OUKy8J9WSzp3Bu	Reload (Vocal Version / Radio Edit)
mSCd3tK6a9A0ZJkn0PNrgt	Electra Heart (Deluxe)
vIxSJkLp4IrMoBlkP9YZoB	Eenie Meenie EP
5bNA4ljkzVbY4a7COY6boT	positions
0XH4ou2qfnmx2p3135bars	Don't Let Me Down
RCDfBYhqsIcei29jJ5XUA3	Need to Know
eXklcDPagskemdr1wixxl8	Sweeter
09mA6vMx1zYyUhuvpfv056	The Element Of Freedom
oVY5eQ5EDi1gRZp3cM24Yp	Red Pill Blues (Deluxe)
F5UM2SnLkH0ySd08KbzhPi	Passion, Pain & Pleasure (Deluxe Version)
g8pIqGxNEDNdK6VlLOUhmH	Some Nights
HGWMZZtvNmADnk0XbDW5oB	Mercy
wSZrg2L1j48eG1dGw0hlVq	Paramore
9Zp669b3CjPBb7VuSKQrDE	Justice
K941V577nQ3yxGOssbbV50	Happiness Begins
aN1PmNMxfb9FRNhYouFfu1	Love Is a Four Letter Word (Deluxe Edition)
KQEMNSXft8tqXcD4fRWrCU	DNCE
OrsimaVJJStUp2OmS2BCMx	No Hands (feat. Roscoe Dash & Wale)
mioV6HHCbvcUoYxefkOGHc	For You
7bFiUSt3TpvpzPlt2Nt3cu	Cannibal (Expanded Edition)
9aU6jEovwmNfv0jlsXQaU8	Don't Kill the Magic
tg4DjtBHNnTt9f5SVVzCM8	Rainbow
kjTW4EhTW8g0j9x4KPsPVV	Certified Hitmaker
uosfX9zpJByYEPgsuzkfH3	Overexposed (Deluxe)
eJSJ3m4nmyK3EX8PGoKtuj	Heathens
K4iVMYr4Sgbvwoe5kXKXqg	ASTROWORLD
1NuTHGjWBPCO7XauMEOp7a	good 4 u
ifAbu3IaL0MPRtSw1xZbox	Rockabye (feat. Sean Paul & Anne-Marie)
gAcHi1rckOBp87qNxdeKBf	Blurred Lines
3mTB6fdrTmBctFwrHxXmF9	Queen Of The Clouds
AaMOSu3E3DOhDwTN2UjQeX	Blonde
VG5k6ec1Emeiu3f3H9nDjK	Chapters
hi3PywrKYfGVWMVb0hVn6O	About Damn Time
VIFdrPq5rp0E4AMbRsPhNa	Illuminate
lyh9dhdY7SFvLeiUnkFX2d	folklore
Uhv3IxT8ac793dkZQAjeSh	My Head Is An Animal
IniTpg8lC2b99Nv8ZGaNQ6	Cheap Thrills (feat. Sean Paul)
5y0bDXN9bf9tbkd72WZSbB	My House
u3RiwNHtNkWEGsk4tESrgu	lovely (with Khalid)
rAr0wWEAlhy4j8vNdxOyrw	my future
ikhmhB4Q9U2EHzwTCGB7tp	Coexist
T7NxzTTggdT3gtq7RbDuVN	FOUR (Deluxe)
Yo4CiC2sLfRvSSJKVWj82L	i am > i was
WRAW5S89ol8as3SX1trIYE	MIDDLE CHILD
5y2DIj3hRAb4kqukHLlGw6	To Be Loved
eqky6vmVnM4IOXObHs1FHG	The 2nd Law
DDDRgCngHduf4ZcIVgZeiB	Butter
iAft5A3mX8Y1lxDanCJxZi	Wild Ones
9Wt4REtMdHDCq8OxuJztAw	One Kiss (with Dua Lipa)
WISE6xmS5ARCPYnk1oYsKk	Gold Dust
O7yCVxgo6ZfGREbFS1owST	#willpower (Deluxe)
2kxbRH0Uah0OQnltYTwqgZ	Doo-Wops & Hooligans
JBRPlkZhM1kRTwXJ2Q3yYK	Without Me
rWs8X7tBbjSuw3JUipkXQK	Shawn Mendes (Deluxe)
feKDSQUbLKICSZJQ8onRnP	Avril Lavigne (Expanded Edition)
rDGf6ffcpANtuKNkvKa7xy	Shoot For The Stars Aim For The Moon
aGAA4uuQLhbePEGimlvC2j	LIVING THINGS
Wwul1C732vLOM3YlQlcMJe	Hoodie SZN
yLgwhAFmxOb9Pf54YC18kk	ARDIPITHECUS
9ByWgmy0wGnW83XMMqKIM4	The 20/20 Experience (Deluxe Version)
kBVviPYomJId6YL7O3WFXn	THE ANXIETY
hB611jp9MKsnPtBxlz8hp5	Disc-Overy
sT64qB1ytY9VsuVawpLGWm	Night Visions (Deluxe)
lgT12R1oOMVVfckUZDxY4g	Bad Habits
jsitC3iDAYkJ7IOglTFvC5	More
WA8Exu53HfVCvGqU1Kz0fr	The Wanted (Special Edition)
D1WK9ih865OnSBzZPvLpVz	Please Excuse Me for Being Antisocial
QjHrUA52omUZepJoiryOAl	Currents
jnI1rPljcfCki1mwl68QYc	Narrated For You
TRgPl4vtsHMa7s6GHBlKUy	Left and Right (Feat. Jung Kook of BTS)
kh17ptYU8O3m5tIuh6jqh1	Encanto (Original Motion Picture Soundtrack)
Us7PErcBOp7KxKMAfAvIkX	We No Speak Americano
cwHApq2OwaJAoHciFR1isS	Kaleidoscope Dream
ApKUCnrZX8mCPqWJDxsDmI	Rated R
tkQF4Bcmh9ytLD6b73Jz4Y	7 EP
UBlJ7ZeeAQwPEeiVhTJA7f	Laugh Now Cry Later (feat. Lil Durk)
FgBtlRNFolgC2Ya091tV5H	Free Spirit
D76Ubp5dg1VtzpZsenP22g	Shirt
Ml5cO85RH0Xl8MbGzsmB1N	Homerun
afIxZZuQBEov6r847Gzr32	No More Idols
4Q7yRqnNIg5n7ReHTtMgd4	2010s Hits
Oyhx8KSPSNUpA1Z7Yql4oh	Yours Truly
jigQYZRG2pWIkSrpm068jn	Who's That Chick?
0eCU9CHjzV0H2px0ykCgCO	Blown Away
4gU0hJTbPQuG9gDlYrcqB5	Layers
Vb3nt9CpuWZr22HGfLHL6y	LP1
RIPbjpJVp4LWeFaQwvifUu	Sorry For Party Rocking (Deluxe Version)
T2XVW8W9ytnKghnxrLcYHf	The Kickback
5NE7eqCekyTIiv0bU4elX1	Night Shades
doPGwSUx5FdVcIefJv58SM	Levitating (feat. DaBaby)
PhWiBZouTZ1ZAo6nQgEDSV	La La La
fFKLuyVmwQntfT7wk2vSis	I Don't Mind (feat. Juicy J)
qHyQbijU1HMpmEskyLIHuG	Famous Cryp
ZkppOZInxmljFSbe4EjwwV	Different World
Y2543SqLZGdiCNRtHLrlix	Brighter Days
lnTkJz46nWCWhpTKoELM2o	First Class
8MHxceyBSewF52BlJAWvIJ	STAY (with Justin Bieber)
tzWujAKTKJjDRvKipmbgQf	A Town Called Paradise (Deluxe)
TjvgMoPjZK5Tm3xmZTAqXD	Raymond v Raymond (Expanded Edition)
DStNHUtDTTED7mKqcQ59DE	All I Want Is You
9VBwBhONRYmFTjoS84qEIM	Bangerz (Deluxe Version)
ACYbRJ2CwobghFSijBlMbp	Astronaut In The Ocean
GFaFksbZM1HkNLKOcgyOTh	Troubadour
7tdgca2Wcey2r5OPajRbAe	A Thousand Years
KEKE2WLyR2k5GP8ESQNHyE	I Need A Doctor
24dEITbt61Jlluhm2IauKp	Bobby Tarantino II
ImOenLh1uEEejt7GOQp5zW	Mylo Xyloto
xzGjyw2L7PclvClluKQSrh	Unapologetic (Edited Version)
q3kuZ3zSioln50YVrFf0fE	DESPECHÃ
3DYhAdvFvIeZ3X9mHs3xvd	B.o.B Presents: The Adventures of Bobby Ray
cqClds8QLGLF4bbqNDTNiO	Ten Add Ten: The Very Best of Scouting For Girls
O1ngSY5PZKltRIjq8odNfd	BORN PINK
Lx9E3YScDN73wJzMn0VRJe	Divinely Uninspired To A Hellish Extent
HQvngT6gmiHngziPYrggbh	A Head Full of Dreams
kfT5U5CGtZvPjdGRckVWRT	Gangnam Style
C5s9wwJwNyhYWobotXxF4P	Rolling Papers
ca3Mrw8kcFXttv6qC7QRIZ	Tha Carter IV (Complete Edition)
HAcyWGuH1Ch26uRLOPLWbE	Te Felicito
exF1qMShRdmaDTdvOVB9BT	Hyperion
k7wxWybRpL7gLINXf37xIf	Birds In The Trap Sing McKnight
hu8UtKhLXZbnZLB4oXxfuK	Right Place Right Time (Expanded Edition)
B2exUPK9T5kOL16qwoU2gA	Nothing but the Beat 2.0
1GRaLygoEdn4QrbxgMDqiH	Future History (Deluxe Edition)
KtrCTSJhbbpviHk8XFoJOE	My Love
OV44y9bc1t3sSenruWbuCM	A Night At The Opera (Deluxe Remastered Version)
35cikXHHKHaFvIalZZonbq	everything i wanted
MZbGnPU1lZpfvvBeWJJqQt	PRISM (Deluxe)
oNKt8h5YYfQr2klpFMAW22	Born This Way (Special Edition)
B4faG1yY2t5b3Uinq4kfqv	This Is What You Came For
Vm4vNAZPz2gaOgA2AmHGqt	As It Was
LENNAEkFWREDdZkPGiC7I7	Last Night On Earth
nB7aI6VhCqpFOcwARgVx95	Cheese
yR2IuTnTXMa9CByAgDucmI	Planet Her
kA31sEW2pWHlJrIbmojmKa	Fine Line
tX9B1X5tUSe0Vo6ZC1NUwV	Where the Light Is
7oBsjwjveiVsqbwCQQlm4C	Bangarang EP
7hCVyTtVM8GSd059e3ZFHl	VHS
I9Co1JiseRX08xDrLMmMhK	I'll Be There
hQ1DnvWyq9wnE6Og4Uvfr2	Wanted on Voyage (Expanded Edition)
TgMoI8Qo8RIyKalAghZMeG	X (Expanded Edition)
6F4SloVvfD5Dc4sMFVmY5M	Never Been Better (Expanded Edition)
ExbrjCkHarShBwLwtPlzGc	In A Tidal Wave Of Mystery (Deluxe Edition)
zVozFPnILLZ0J5sb2QNNGH	The Rokstarr Hits Collection
XH35ObLD4cAnI1dGxRXQAx	Sorry For Party Rocking
7fPaPtZG8KuFDhUPEoSp7w	EP1
fWxzm3LslYwy8VBuuHkON9	Quevedo: Bzrp Music Sessions, Vol. 52
qFcMbu76A6zVBJ0QZynDbs	The Truth About Love
5udkiavO1L1Ql71gthvgby	24K Magic
EJGs08wTDIlOEu3UQxrAyq	Silhouettes
tsLRJWilHmItpwLIFUOagH	Come Into My World
qzjKn6b9XVF0WShYzSkgAo	I Am Not A Human Being II (Deluxe)
PfGnntldazb9OUI3emzkUE	Speak Now
GDJWkBS3fxHHWvGajeXf8L	AM
vbnRDDwMRARMMjIB2c3Qxx	California 37
f1GOmd2yu5vAj5n9dOu4Nd	Teenage Dream
vSIUBbUUbiFXLlWQ2a4rH7	After Hours (Deluxe)
wQdosoiodfAqZsij5MWFoj	Summer Of Love
yeNusMSn44IStFkwLLdTNq	See You Again (feat. Charlie Puth)
hkmp2IVS5IU4ZbInZC8r8E	Billionaire (feat. Bruno Mars)
OhyCRR8AAeIniOkxEEUChH	Purpose (Deluxe)
qQOSra1GSEEeF36URg4nTg	SOUR
mlRlxxucEEcTn8Zkwfj5a2	MONTERO
LjWfylLxGDRA5VnjhLCBkm	Save Your Tears (Remix)
ItOtP3GqqsZ9hO21w0RKHR	Lift Your Spirit
LotvOKuFl91BpsqnAcFcGl	Teenage Dream: The Complete Confection
lX3fgePMdqwd4DETy543Jq	Positions
mxygbXBRF9NvDnVjaxNN47	Kiss Me More (feat. SZA)
zc2fqZvKJWwaseCGTIHPjD	Walk The Moon
sm6SW9eXP9ziQSAXxiAdYD	Certified Lover Boy
M62GAHp8DW01MkDVWerlbq	Recovery
6rztDuATqT1hqyHpeulkSI	BREAK MY SOUL
PoR7IBAE6GMuTNMWtq4Y2N	Dick (feat. Doja Cat)
1Ru5FYEzNIKNM7ByfDjvdT	Ã· (Deluxe)
SgkHoIMsTYrKlkvWXc3uLT	An Awesome Wave
\.


--
-- TOC entry 4881 (class 0 OID 75925)
-- Dependencies: 223
-- Data for Name: artist_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artist_genres (artist_id, genre_id) FROM stdin;
0du5cEVh5yTK9QJze8zA0C	KX8AIg1eUdlOT4NrGhk35P
0du5cEVh5yTK9QJze8zA0C	2LqnIQ8brNKkq5UpYasS3M
7dGJo4pcD2V6oG8kP0tJRR	eQ963SlkrY8qwgmn93yBAt
7dGJo4pcD2V6oG8kP0tJRR	GlCMRz71ZgklFN1OnobcXU
7dGJo4pcD2V6oG8kP0tJRR	V7w4ohCNxr1Ddc3hKRHDWw
3FUY2gzHeIiaesXtOAdB7A	KX8AIg1eUdlOT4NrGhk35P
3FUY2gzHeIiaesXtOAdB7A	qy8fE1PrAelfZ29K13ZSEG
3FUY2gzHeIiaesXtOAdB7A	2LqnIQ8brNKkq5UpYasS3M
3FUY2gzHeIiaesXtOAdB7A	rFBROMeUWoNfNR6AwyhO2N
5j4HeCoUlzhfWtjAfM1acR	LdVObxEvZiuZuVSXueOZ1P
5j4HeCoUlzhfWtjAfM1acR	KJM3kNhtSdNbdMNGGf3d5h
6LqNN22kT3074XbTVUrhzX	KX8AIg1eUdlOT4NrGhk35P
6LqNN22kT3074XbTVUrhzX	2LqnIQ8brNKkq5UpYasS3M
1Cs0zKBU1kc0i8ypK3B9ai	RLwofC9qBR221ghUuoRgkS
1Cs0zKBU1kc0i8ypK3B9ai	KX8AIg1eUdlOT4NrGhk35P
1Cs0zKBU1kc0i8ypK3B9ai	1MmI2gY2e2xo6j1GOwS52A
1Cs0zKBU1kc0i8ypK3B9ai	2LqnIQ8brNKkq5UpYasS3M
1Cs0zKBU1kc0i8ypK3B9ai	p347GOssFGeRsh2UDHcz0X
2gBjLmx6zQnFGQJCAQpRgw	KX8AIg1eUdlOT4NrGhk35P
2gBjLmx6zQnFGQJCAQpRgw	RE12Ku7eAAd6lISO7oBoOh
2gBjLmx6zQnFGQJCAQpRgw	GlCMRz71ZgklFN1OnobcXU
2gBjLmx6zQnFGQJCAQpRgw	LQZm0woEpsP2lZtzqyfO3K
2gBjLmx6zQnFGQJCAQpRgw	V7w4ohCNxr1Ddc3hKRHDWw
2gBjLmx6zQnFGQJCAQpRgw	8TjGGi59AnSWHKHUF6Y2GS
2gBjLmx6zQnFGQJCAQpRgw	Ag6mEJFMRpkqeVkwTpdGdv
536BYVgOnRky0xjsPT96zl	sE29JgBaVmIObx2DmVRiqf
536BYVgOnRky0xjsPT96zl	iDVo27DQcN9JLSI8enf6vi
536BYVgOnRky0xjsPT96zl	E4Q265b3EmpKqVQoCQ8ASc
536BYVgOnRky0xjsPT96zl	whRMEhdeuqs0iaMhxx5Smb
536BYVgOnRky0xjsPT96zl	Da1EKMQQa8bTR2b82MY7ag
536BYVgOnRky0xjsPT96zl	53QoB8xceU8mWXCorSBO5W
23zg3TcAtWQy7J6upgbUnj	zRxPoppovbdFtrtQUZJMDT
23zg3TcAtWQy7J6upgbUnj	pA6b3IJ3XfGvlhbFms2vpW
23zg3TcAtWQy7J6upgbUnj	KX8AIg1eUdlOT4NrGhk35P
23zg3TcAtWQy7J6upgbUnj	2LqnIQ8brNKkq5UpYasS3M
23zg3TcAtWQy7J6upgbUnj	paHyw6nLLQP1js37lYmvxD
23zg3TcAtWQy7J6upgbUnj	V7w4ohCNxr1Ddc3hKRHDWw
23zg3TcAtWQy7J6upgbUnj	2SLoZRdP1aI7I1QRPgMUGL
23zg3TcAtWQy7J6upgbUnj	Ag6mEJFMRpkqeVkwTpdGdv
7o9Nl7K1Al6NNAHX6jn6iG	LQZm0woEpsP2lZtzqyfO3K
6jJ0s89eD6GaHleKKya26X	2LqnIQ8brNKkq5UpYasS3M
1HY2Jd0NmPuamShAr6KMms	jnszrK69fmB7DuSbBUYOcz
1HY2Jd0NmPuamShAr6KMms	KX8AIg1eUdlOT4NrGhk35P
1HY2Jd0NmPuamShAr6KMms	2LqnIQ8brNKkq5UpYasS3M
5tKXB9uuebKE34yowVaU3C	KX8AIg1eUdlOT4NrGhk35P
5tKXB9uuebKE34yowVaU3C	LQZm0woEpsP2lZtzqyfO3K
5tKXB9uuebKE34yowVaU3C	rZCmSCdlE4mdC3rZnkQI8I
5ndkK3dpZLKtBklKjxNQwT	zRxPoppovbdFtrtQUZJMDT
5ndkK3dpZLKtBklKjxNQwT	KX8AIg1eUdlOT4NrGhk35P
5ndkK3dpZLKtBklKjxNQwT	LQZm0woEpsP2lZtzqyfO3K
5ndkK3dpZLKtBklKjxNQwT	V7w4ohCNxr1Ddc3hKRHDWw
5ndkK3dpZLKtBklKjxNQwT	MEqeqHl7UI8lyedJMux3Wj
2iojnBLj0qIMiKPvVhLnsH	KX8AIg1eUdlOT4NrGhk35P
2iojnBLj0qIMiKPvVhLnsH	paHyw6nLLQP1js37lYmvxD
2iojnBLj0qIMiKPvVhLnsH	MEqeqHl7UI8lyedJMux3Wj
2iojnBLj0qIMiKPvVhLnsH	5x6O4mJLMhXsbI8aUucv2B
2iojnBLj0qIMiKPvVhLnsH	Ag6mEJFMRpkqeVkwTpdGdv
5pKCCKE2ajJHZ9KAiaK11H	8k2RTdUrFX1cbjDsRNERHV
5pKCCKE2ajJHZ9KAiaK11H	2LqnIQ8brNKkq5UpYasS3M
5pKCCKE2ajJHZ9KAiaK11H	Ag6mEJFMRpkqeVkwTpdGdv
3DiDSECUqqY1AuBP8qtaIa	RKGu0xs9uJF1u5W1psoj23
3DiDSECUqqY1AuBP8qtaIa	2LqnIQ8brNKkq5UpYasS3M
3DiDSECUqqY1AuBP8qtaIa	paHyw6nLLQP1js37lYmvxD
3TVXtAsR1Inumwj472S9r4	odvwbwzsetIHXknwT5HEJP
3TVXtAsR1Inumwj472S9r4	wm8hn89gVWDs3sSLr2K7Zu
3TVXtAsR1Inumwj472S9r4	GlCMRz71ZgklFN1OnobcXU
3TVXtAsR1Inumwj472S9r4	LQZm0woEpsP2lZtzqyfO3K
3TVXtAsR1Inumwj472S9r4	V7w4ohCNxr1Ddc3hKRHDWw
6MF9fzBmfXghAz953czmBC	KX8AIg1eUdlOT4NrGhk35P
6MF9fzBmfXghAz953czmBC	2LqnIQ8brNKkq5UpYasS3M
6MF9fzBmfXghAz953czmBC	LQZm0woEpsP2lZtzqyfO3K
7bXgB6jMjp9ATFy66eO08Z	LQZm0woEpsP2lZtzqyfO3K
7bXgB6jMjp9ATFy66eO08Z	paHyw6nLLQP1js37lYmvxD
7bXgB6jMjp9ATFy66eO08Z	V7w4ohCNxr1Ddc3hKRHDWw
1EeArivTpzLNCqubV95255	LQZm0woEpsP2lZtzqyfO3K
5Y5TRrQiqgUO4S36tzjIRZ	KX8AIg1eUdlOT4NrGhk35P
5Y5TRrQiqgUO4S36tzjIRZ	2LqnIQ8brNKkq5UpYasS3M
5Y5TRrQiqgUO4S36tzjIRZ	LQZm0woEpsP2lZtzqyfO3K
75FnCoo4FBxH5K1Rrx0k5A	n8VMb4nyFdFHY8Zz0ik1uE
75FnCoo4FBxH5K1Rrx0k5A	EDF5mqailn2C9hyqQXAcxd
75FnCoo4FBxH5K1Rrx0k5A	z98WlS2KpBloy4ohjZZA2G
75FnCoo4FBxH5K1Rrx0k5A	K5fCj9fHKVxf4ddjn16JB8
1yxSLGMDHlW21z4YXirZDS	KX8AIg1eUdlOT4NrGhk35P
1yxSLGMDHlW21z4YXirZDS	2LqnIQ8brNKkq5UpYasS3M
1yxSLGMDHlW21z4YXirZDS	LQZm0woEpsP2lZtzqyfO3K
7qG3b048QCHVRO5Pv1T5lw	KX8AIg1eUdlOT4NrGhk35P
7qG3b048QCHVRO5Pv1T5lw	SqiWV5CL9rWp0Z64AlSqGA
7qG3b048QCHVRO5Pv1T5lw	Crp9K0upoGcJYeORjknaq4
0hYxQe3AK5jBPCr5MumLHD	n8VMb4nyFdFHY8Zz0ik1uE
0hYxQe3AK5jBPCr5MumLHD	EDF5mqailn2C9hyqQXAcxd
0hYxQe3AK5jBPCr5MumLHD	z98WlS2KpBloy4ohjZZA2G
0hYxQe3AK5jBPCr5MumLHD	K5fCj9fHKVxf4ddjn16JB8
0hEurMDQu99nJRq8pTxO14	qy8fE1PrAelfZ29K13ZSEG
0hEurMDQu99nJRq8pTxO14	1esd4m69Iex1apATbeolIi
5YGY8feqx7naU7z4HrwZM6	2LqnIQ8brNKkq5UpYasS3M
6S0dmVVn4udvppDhZIWxCr	KX8AIg1eUdlOT4NrGhk35P
6S0dmVVn4udvppDhZIWxCr	uSZJVdMWfFSEGkfcmUTnn2
6S0dmVVn4udvppDhZIWxCr	2LqnIQ8brNKkq5UpYasS3M
4KkHjCe8ouh8C2P9LPoD4F	5wqS8b6SV9Y7XcLuJNFjpg
4KkHjCe8ouh8C2P9LPoD4F	ovnmTdhAsBPp0XT7dVhu0r
4KkHjCe8ouh8C2P9LPoD4F	qs2C5lpYrx5TV82rT0llCf
5nLYd9ST4Cnwy6NHaCxbj8	zRxPoppovbdFtrtQUZJMDT
0FWzNDaEu9jdgcYTbcOa4F	KX8AIg1eUdlOT4NrGhk35P
0FWzNDaEu9jdgcYTbcOa4F	1jReh01uA4uVM19jZTVyyt
0FWzNDaEu9jdgcYTbcOa4F	pKhTWOvK3Y6IeyDnci4KDu
0FWzNDaEu9jdgcYTbcOa4F	LQZm0woEpsP2lZtzqyfO3K
0FWzNDaEu9jdgcYTbcOa4F	rZCmSCdlE4mdC3rZnkQI8I
06HL4z0CvFAxyc27GXpf02	2LqnIQ8brNKkq5UpYasS3M
6Vh6UDWfu9PUSXSzAaB3CW	R2MjU4vXbep5wxegAoH4Ot
6Vh6UDWfu9PUSXSzAaB3CW	xJmSkIp1Q4Dl8pDzOfxVDx
6r20qOqY7qDWI0PPTxVMlC	Ch3LEqStHbk1TgsjjtyieY
6r20qOqY7qDWI0PPTxVMlC	Caw5218qJm8ANBXTb6oaDx
6r20qOqY7qDWI0PPTxVMlC	xJmSkIp1Q4Dl8pDzOfxVDx
3ipn9JLAPI5GUEo4y4jcoi	zRxPoppovbdFtrtQUZJMDT
3ipn9JLAPI5GUEo4y4jcoi	KX8AIg1eUdlOT4NrGhk35P
3ipn9JLAPI5GUEo4y4jcoi	WsK8DfEcHbqETfIJ69RS1d
3ipn9JLAPI5GUEo4y4jcoi	GlCMRz71ZgklFN1OnobcXU
3ipn9JLAPI5GUEo4y4jcoi	WtrbZflTTOud8ZU8gY3iM3
3ipn9JLAPI5GUEo4y4jcoi	LQZm0woEpsP2lZtzqyfO3K
3ipn9JLAPI5GUEo4y4jcoi	V7w4ohCNxr1Ddc3hKRHDWw
3ipn9JLAPI5GUEo4y4jcoi	MEqeqHl7UI8lyedJMux3Wj
3ipn9JLAPI5GUEo4y4jcoi	5x6O4mJLMhXsbI8aUucv2B
6prmLEyn4LfHlD9NnXWlf7	KX8AIg1eUdlOT4NrGhk35P
6prmLEyn4LfHlD9NnXWlf7	WVAftOScguQs31GXAphyRU
6prmLEyn4LfHlD9NnXWlf7	2LqnIQ8brNKkq5UpYasS3M
6prmLEyn4LfHlD9NnXWlf7	rZCmSCdlE4mdC3rZnkQI8I
07YZf4WDAMNwqr4jfgOZ8y	KX8AIg1eUdlOT4NrGhk35P
07YZf4WDAMNwqr4jfgOZ8y	2LqnIQ8brNKkq5UpYasS3M
04gDigrS5kc9YWfZHwBETP	2LqnIQ8brNKkq5UpYasS3M
1h6Cn3P4NGzXbaXidqURXs	1MmI2gY2e2xo6j1GOwS52A
1h6Cn3P4NGzXbaXidqURXs	p347GOssFGeRsh2UDHcz0X
1h6Cn3P4NGzXbaXidqURXs	CqvAnCq2v4Q0aMk9ytWTMp
2Sqr0DXoaYABbjBo9HaMkM	ab16UTObfH5IybcL2217Cr
2Sqr0DXoaYABbjBo9HaMkM	RfaDa0ajCygXtBj37Ox8st
2Sqr0DXoaYABbjBo9HaMkM	qy8fE1PrAelfZ29K13ZSEG
2Sqr0DXoaYABbjBo9HaMkM	rFBROMeUWoNfNR6AwyhO2N
2Sqr0DXoaYABbjBo9HaMkM	rZCmSCdlE4mdC3rZnkQI8I
3AQRLZ9PuTAozP28Skbq8V	L256hjbDPpaDSMH8aNiD9k
3AQRLZ9PuTAozP28Skbq8V	2LqnIQ8brNKkq5UpYasS3M
6UE7nl9mha6s8z0wFQFIZ2	KX8AIg1eUdlOT4NrGhk35P
6UE7nl9mha6s8z0wFQFIZ2	olqVcznfeC6c5LCW33m8Ix
6UE7nl9mha6s8z0wFQFIZ2	bWTeVmpTsiw5ttEVSETCOM
6UE7nl9mha6s8z0wFQFIZ2	LNGQsYWJ5Dx7TzYpr6M0gZ
6UE7nl9mha6s8z0wFQFIZ2	nHA0eOdA7YqGV1OmKAJV9i
6UE7nl9mha6s8z0wFQFIZ2	fHr2y58b2e2XiM9tGbGpvQ
6f4XkbvYlXMH0QgVRzW0sM	zRxPoppovbdFtrtQUZJMDT
6f4XkbvYlXMH0QgVRzW0sM	WsK8DfEcHbqETfIJ69RS1d
6f4XkbvYlXMH0QgVRzW0sM	LQZm0woEpsP2lZtzqyfO3K
6f4XkbvYlXMH0QgVRzW0sM	V7w4ohCNxr1Ddc3hKRHDWw
6f4XkbvYlXMH0QgVRzW0sM	MEqeqHl7UI8lyedJMux3Wj
6f4XkbvYlXMH0QgVRzW0sM	5x6O4mJLMhXsbI8aUucv2B
7pGyQZx9thVa8GxMBeXscB	ufaJetRQmV06BtOolWkGQO
0Tob4H0FLtEONHU1MjpUEp	KX8AIg1eUdlOT4NrGhk35P
0Tob4H0FLtEONHU1MjpUEp	LfqiUsgYNyo5Dnlb6QxEQS
0Tob4H0FLtEONHU1MjpUEp	LQZm0woEpsP2lZtzqyfO3K
0q8J3Yj810t5cpAYEJ7gxt	MaMDqlKoEEwjYAqLjJQNMm
3AuMNF8rQAKOzjYppFNAoB	zRxPoppovbdFtrtQUZJMDT
3AuMNF8rQAKOzjYppFNAoB	KX8AIg1eUdlOT4NrGhk35P
3AuMNF8rQAKOzjYppFNAoB	VxQtETZVbYFskEUTsdsDKL
3AuMNF8rQAKOzjYppFNAoB	paHyw6nLLQP1js37lYmvxD
3AuMNF8rQAKOzjYppFNAoB	Ag6mEJFMRpkqeVkwTpdGdv
3906URNmNa1VCXEeiJ3DSH	E5t7R5wCxfwLPsV2bBh4Au
4dpARuHxo51G3z768sgnrY	12XRUtBZVdLgcba8y2Be0o
4dpARuHxo51G3z768sgnrY	2LqnIQ8brNKkq5UpYasS3M
4dpARuHxo51G3z768sgnrY	8mNfH1L6k6exhWHFjQdfNo
4dpARuHxo51G3z768sgnrY	8h1nry3IY96ZTSOwuHMUZR
3sgFRtyBnxXD5ESfmbK4dl	KX8AIg1eUdlOT4NrGhk35P
3sgFRtyBnxXD5ESfmbK4dl	2LqnIQ8brNKkq5UpYasS3M
3sgFRtyBnxXD5ESfmbK4dl	LQZm0woEpsP2lZtzqyfO3K
360IAlyVv4PCEVjgyMZrxK	paHyw6nLLQP1js37lYmvxD
4gzpq5DPGxSnKTe4SA8HAU	AkD0RYLVh3masDRAmNER7a
4gzpq5DPGxSnKTe4SA8HAU	2LqnIQ8brNKkq5UpYasS3M
63MQldklfxkjYDoUE4Tppz	gRUsub3KAT3LzKfepJ3wxC
63MQldklfxkjYDoUE4Tppz	jCd9yAjgsHmP5egjlE33FJ
63MQldklfxkjYDoUE4Tppz	iDVo27DQcN9JLSI8enf6vi
63MQldklfxkjYDoUE4Tppz	uGPcY5hn2lMGTL6wmWuN7l
63MQldklfxkjYDoUE4Tppz	bWTeVmpTsiw5ttEVSETCOM
55Aa2cqylxrFIXC767Z865	GlCMRz71ZgklFN1OnobcXU
55Aa2cqylxrFIXC767Z865	aVqVL6GHgXDeQA4Pq7us70
55Aa2cqylxrFIXC767Z865	LQZm0woEpsP2lZtzqyfO3K
55Aa2cqylxrFIXC767Z865	V7w4ohCNxr1Ddc3hKRHDWw
55Aa2cqylxrFIXC767Z865	5x6O4mJLMhXsbI8aUucv2B
2WX2uTcsvV5OnS0inACecP	qy8fE1PrAelfZ29K13ZSEG
2WX2uTcsvV5OnS0inACecP	8h1nry3IY96ZTSOwuHMUZR
6jTnHxhb6cDCaCu4rdvsQ0	2wkHFHGy2fJvAzKS8ppqgL
6jTnHxhb6cDCaCu4rdvsQ0	CgIfe4pLQAEvcyID6h5Ujr
6jTnHxhb6cDCaCu4rdvsQ0	rZCmSCdlE4mdC3rZnkQI8I
01QTIT5P1pFP3QnnFSdsJf	ITUee9sTXyqtVUFSluX7Xd
01QTIT5P1pFP3QnnFSdsJf	4BcJaCA3fGBwot6p3xC1Hn
01QTIT5P1pFP3QnnFSdsJf	GlCMRz71ZgklFN1OnobcXU
01QTIT5P1pFP3QnnFSdsJf	RajifVQECSHb83OFLQxkx7
01QTIT5P1pFP3QnnFSdsJf	LQZm0woEpsP2lZtzqyfO3K
01QTIT5P1pFP3QnnFSdsJf	V7w4ohCNxr1Ddc3hKRHDWw
01QTIT5P1pFP3QnnFSdsJf	MEqeqHl7UI8lyedJMux3Wj
0QHgL1lAIqAw0HtD7YldmP	GlCMRz71ZgklFN1OnobcXU
0QHgL1lAIqAw0HtD7YldmP	uSZJVdMWfFSEGkfcmUTnn2
0QHgL1lAIqAw0HtD7YldmP	LQZm0woEpsP2lZtzqyfO3K
0QHgL1lAIqAw0HtD7YldmP	V7w4ohCNxr1Ddc3hKRHDWw
6DPYiyq5kWVQS4RGwxzPC7	81l4y0ay9bqlEbuKU08K6W
6DPYiyq5kWVQS4RGwxzPC7	RE12Ku7eAAd6lISO7oBoOh
6DPYiyq5kWVQS4RGwxzPC7	GlCMRz71ZgklFN1OnobcXU
6DPYiyq5kWVQS4RGwxzPC7	V7w4ohCNxr1Ddc3hKRHDWw
6DPYiyq5kWVQS4RGwxzPC7	KExNJCTjwIr6n4eWyeg9pe
2aYJ5LAta2ScCdfLhKgZOY	CgIfe4pLQAEvcyID6h5Ujr
2aYJ5LAta2ScCdfLhKgZOY	pKhTWOvK3Y6IeyDnci4KDu
2aYJ5LAta2ScCdfLhKgZOY	rZCmSCdlE4mdC3rZnkQI8I
32WkQRZEVKSzVAAYqukAEA	n8VMb4nyFdFHY8Zz0ik1uE
32WkQRZEVKSzVAAYqukAEA	EDF5mqailn2C9hyqQXAcxd
32WkQRZEVKSzVAAYqukAEA	z98WlS2KpBloy4ohjZZA2G
32WkQRZEVKSzVAAYqukAEA	RJadUUEPQF39ZfoYVFNREl
32WkQRZEVKSzVAAYqukAEA	K5fCj9fHKVxf4ddjn16JB8
3LpLGlgRS1IKPPwElnpW35	qy8fE1PrAelfZ29K13ZSEG
137W8MRPWKqSmrBGDBFSop	GlCMRz71ZgklFN1OnobcXU
137W8MRPWKqSmrBGDBFSop	E1dNffWSO2mKOroONjQTNr
137W8MRPWKqSmrBGDBFSop	LQZm0woEpsP2lZtzqyfO3K
137W8MRPWKqSmrBGDBFSop	V7w4ohCNxr1Ddc3hKRHDWw
137W8MRPWKqSmrBGDBFSop	MEqeqHl7UI8lyedJMux3Wj
137W8MRPWKqSmrBGDBFSop	5x6O4mJLMhXsbI8aUucv2B
7CajNmpbOovFoOoasH2HaY	KX8AIg1eUdlOT4NrGhk35P
7CajNmpbOovFoOoasH2HaY	1MmI2gY2e2xo6j1GOwS52A
7CajNmpbOovFoOoasH2HaY	YxOOM3R5eecR5nKXaAW0Xz
7CajNmpbOovFoOoasH2HaY	PXAZ3FP5VbdGWFE9pjGVlG
7CajNmpbOovFoOoasH2HaY	2LqnIQ8brNKkq5UpYasS3M
7CajNmpbOovFoOoasH2HaY	DfGFE1USWx7GEiEFiGFsuE
7CajNmpbOovFoOoasH2HaY	xJmSkIp1Q4Dl8pDzOfxVDx
3jNkaOXasoc7RsxdchvEVq	Ch3LEqStHbk1TgsjjtyieY
3jNkaOXasoc7RsxdchvEVq	Caw5218qJm8ANBXTb6oaDx
3jNkaOXasoc7RsxdchvEVq	xJmSkIp1Q4Dl8pDzOfxVDx
0BmLNz4nSLfoWYW1cYsElL	HjEUIly1GABqcA3Zpn73vD
3whuHq0yGx60atvA2RCVRW	KX8AIg1eUdlOT4NrGhk35P
3whuHq0yGx60atvA2RCVRW	2LqnIQ8brNKkq5UpYasS3M
3whuHq0yGx60atvA2RCVRW	E5t7R5wCxfwLPsV2bBh4Au
2feDdbD5araYcm6JhFHHw7	AQJy0cICgcJ7OAwLkr6Mtr
2feDdbD5araYcm6JhFHHw7	2LqnIQ8brNKkq5UpYasS3M
0qk8MxMzgnfFECvDO3cc0X	TE6nPFmStCTQOAlbpYbDc5
2ajhZ7EA6Dec0kaWiKCApF	1Qn6xdLSrQ7FLHkjyU0L4G
4LEiUm1SRbFMgfqnQTwUbQ	mpui95W8Gpqp9pChPu2Kkw
4LEiUm1SRbFMgfqnQTwUbQ	3gLRg9YjdFQFgIxNPyrDXK
4LEiUm1SRbFMgfqnQTwUbQ	0eCk6UEHfgIEiOzO6c9QQq
4LEiUm1SRbFMgfqnQTwUbQ	1WZCcFSbNtBETKdcflXSQo
4LEiUm1SRbFMgfqnQTwUbQ	Da1EKMQQa8bTR2b82MY7ag
0aeLcja6hKzb7Uz2ou7ulP	d51gUfq0plLEythN72HJoH
6sFIWsNpZYqfjUpaCgueju	wm8hn89gVWDs3sSLr2K7Zu
6sFIWsNpZYqfjUpaCgueju	KX8AIg1eUdlOT4NrGhk35P
6sFIWsNpZYqfjUpaCgueju	2LqnIQ8brNKkq5UpYasS3M
5nCi3BB41mBaMH9gfr6Su0	FS3g1jguh01C3PFkxEDLIK
5nCi3BB41mBaMH9gfr6Su0	uGPcY5hn2lMGTL6wmWuN7l
4AK6F7OLvEQ5QYCBNiQWHq	CQFwQ9CVGrmSl7IhgEPJxI
4AK6F7OLvEQ5QYCBNiQWHq	2LqnIQ8brNKkq5UpYasS3M
4AK6F7OLvEQ5QYCBNiQWHq	rZCmSCdlE4mdC3rZnkQI8I
4AK6F7OLvEQ5QYCBNiQWHq	E5t7R5wCxfwLPsV2bBh4Au
7H55rcKCfwqkyDFH9wpKM6	2LqnIQ8brNKkq5UpYasS3M
1vCWHaC5f2uS3yhpwWbIA6	1MmI2gY2e2xo6j1GOwS52A
1vCWHaC5f2uS3yhpwWbIA6	2LqnIQ8brNKkq5UpYasS3M
1vCWHaC5f2uS3yhpwWbIA6	p347GOssFGeRsh2UDHcz0X
0RpddSzUHfncUWNJXKOsjy	Da1EKMQQa8bTR2b82MY7ag
0RpddSzUHfncUWNJXKOsjy	qy8fE1PrAelfZ29K13ZSEG
0RpddSzUHfncUWNJXKOsjy	rFBROMeUWoNfNR6AwyhO2N
0RpddSzUHfncUWNJXKOsjy	rk5tGP58hdo4pxkbh8q86J
0jnsk9HBra6NMjO2oANoPY	KX8AIg1eUdlOT4NrGhk35P
0jnsk9HBra6NMjO2oANoPY	uSZJVdMWfFSEGkfcmUTnn2
0jnsk9HBra6NMjO2oANoPY	2LqnIQ8brNKkq5UpYasS3M
0jnsk9HBra6NMjO2oANoPY	LQZm0woEpsP2lZtzqyfO3K
3nFkdlSjzX9mRTtwJOzDYB	YoRnYuRATplwTA2WHadVjS
3nFkdlSjzX9mRTtwJOzDYB	RE12Ku7eAAd6lISO7oBoOh
3nFkdlSjzX9mRTtwJOzDYB	GlCMRz71ZgklFN1OnobcXU
3nFkdlSjzX9mRTtwJOzDYB	LQZm0woEpsP2lZtzqyfO3K
3nFkdlSjzX9mRTtwJOzDYB	V7w4ohCNxr1Ddc3hKRHDWw
2AsusXITU8P25dlRNhcAbG	1PMfLOqFsvN8tSveICzhNJ
0hCNtLu0JehylgoiP8L4Gh	VxQtETZVbYFskEUTsdsDKL
0hCNtLu0JehylgoiP8L4Gh	2LqnIQ8brNKkq5UpYasS3M
0hCNtLu0JehylgoiP8L4Gh	zdy5aiERwBVLsCfk36RhuK
0hCNtLu0JehylgoiP8L4Gh	V7w4ohCNxr1Ddc3hKRHDWw
6XyY86QOPPrYVGvF9ch6wz	TaILWRKGSVMLBALGLgPgXg
6XyY86QOPPrYVGvF9ch6wz	P4GV1oadwjhHeAQ7qKK3eQ
6XyY86QOPPrYVGvF9ch6wz	j3YL54mLVZbG9bTgkALwQE
6XyY86QOPPrYVGvF9ch6wz	6Tvm7rH1PZAbcPbdSKK0AG
6XyY86QOPPrYVGvF9ch6wz	nIGGJGaPtlfLiaeQ0DUMhT
2dd5mrQZvg6SmahdgVKDzh	cSaPAuw3Pbj9YYbPOwC9w1
2dd5mrQZvg6SmahdgVKDzh	O4rL3gmxJZ1ubTEry7Dmqu
6p5JxpTc7USNnBnLzctyd4	YfroEA85GouAxakcl98NId
6p5JxpTc7USNnBnLzctyd4	qy8fE1PrAelfZ29K13ZSEG
6p5JxpTc7USNnBnLzctyd4	rFBROMeUWoNfNR6AwyhO2N
6CwfuxIqcltXDGjfZsMd9A	uGPcY5hn2lMGTL6wmWuN7l
6CwfuxIqcltXDGjfZsMd9A	2LqnIQ8brNKkq5UpYasS3M
6CwfuxIqcltXDGjfZsMd9A	rk5tGP58hdo4pxkbh8q86J
6CwfuxIqcltXDGjfZsMd9A	xDUH5ifXyXjeN2dLLknJ31
3XHO7cRUPCLOr6jwp8vsx5	sE29JgBaVmIObx2DmVRiqf
3XHO7cRUPCLOr6jwp8vsx5	iDVo27DQcN9JLSI8enf6vi
3XHO7cRUPCLOr6jwp8vsx5	whRMEhdeuqs0iaMhxx5Smb
3XHO7cRUPCLOr6jwp8vsx5	Da1EKMQQa8bTR2b82MY7ag
3XHO7cRUPCLOr6jwp8vsx5	nIGGJGaPtlfLiaeQ0DUMhT
5K4W6rqBFWDnAN6FQUkS6x	ITUee9sTXyqtVUFSluX7Xd
5K4W6rqBFWDnAN6FQUkS6x	GlCMRz71ZgklFN1OnobcXU
5K4W6rqBFWDnAN6FQUkS6x	V7w4ohCNxr1Ddc3hKRHDWw
4phGZZrJZRo4ElhRtViYdl	ab16UTObfH5IybcL2217Cr
4phGZZrJZRo4ElhRtViYdl	KX8AIg1eUdlOT4NrGhk35P
4phGZZrJZRo4ElhRtViYdl	qy8fE1PrAelfZ29K13ZSEG
4phGZZrJZRo4ElhRtViYdl	2LqnIQ8brNKkq5UpYasS3M
6nS5roXSAGhTGr34W6n7Et	1MmI2gY2e2xo6j1GOwS52A
6nS5roXSAGhTGr34W6n7Et	PXAZ3FP5VbdGWFE9pjGVlG
6nS5roXSAGhTGr34W6n7Et	iDVo27DQcN9JLSI8enf6vi
6nS5roXSAGhTGr34W6n7Et	xJmSkIp1Q4Dl8pDzOfxVDx
1VBflYyxBhnDc9uVib98rw	ME3FgRwQZx7XcxftUC8t53
1VBflYyxBhnDc9uVib98rw	KX8AIg1eUdlOT4NrGhk35P
1VBflYyxBhnDc9uVib98rw	olqVcznfeC6c5LCW33m8Ix
1VBflYyxBhnDc9uVib98rw	uGPcY5hn2lMGTL6wmWuN7l
1VBflYyxBhnDc9uVib98rw	nHA0eOdA7YqGV1OmKAJV9i
1VBflYyxBhnDc9uVib98rw	WjxdlV5uG0qXEqnazAq6D6
6S2OmqARrzebs0tKUEyXyp	2LqnIQ8brNKkq5UpYasS3M
6S2OmqARrzebs0tKUEyXyp	rZCmSCdlE4mdC3rZnkQI8I
5he5w2lnU9x7JFhnwcekXX	PN43AI5RvpmbPGEmPLgM2m
5he5w2lnU9x7JFhnwcekXX	7qOyvybcAUPfPJt4DD9cQT
5he5w2lnU9x7JFhnwcekXX	1MmI2gY2e2xo6j1GOwS52A
5he5w2lnU9x7JFhnwcekXX	PJzZvwuDj5AjJMnlDNF4Rh
5he5w2lnU9x7JFhnwcekXX	p347GOssFGeRsh2UDHcz0X
53XhwfbYqKCa1cC15pYq2q	Da1EKMQQa8bTR2b82MY7ag
53XhwfbYqKCa1cC15pYq2q	2LqnIQ8brNKkq5UpYasS3M
53XhwfbYqKCa1cC15pYq2q	nIGGJGaPtlfLiaeQ0DUMhT
4dwdTW1Lfiq0cM8nBAqIIz	YfroEA85GouAxakcl98NId
4dwdTW1Lfiq0cM8nBAqIIz	uGPcY5hn2lMGTL6wmWuN7l
4dwdTW1Lfiq0cM8nBAqIIz	Da1EKMQQa8bTR2b82MY7ag
4dwdTW1Lfiq0cM8nBAqIIz	d51gUfq0plLEythN72HJoH
2YZyLoL8N0Wb9xBt1NhZWg	4BcJaCA3fGBwot6p3xC1Hn
2YZyLoL8N0Wb9xBt1NhZWg	GlCMRz71ZgklFN1OnobcXU
2YZyLoL8N0Wb9xBt1NhZWg	V7w4ohCNxr1Ddc3hKRHDWw
2YZyLoL8N0Wb9xBt1NhZWg	KExNJCTjwIr6n4eWyeg9pe
00FQb4jTyendYWaN8pK0wa	jnszrK69fmB7DuSbBUYOcz
00FQb4jTyendYWaN8pK0wa	2LqnIQ8brNKkq5UpYasS3M
2HcwFjNelS49kFbfvMxQYw	2wkHFHGy2fJvAzKS8ppqgL
2HcwFjNelS49kFbfvMxQYw	dObL99TGhq1tMKWObjafye
21E3waRsmPlU7jZsS13rcj	KX8AIg1eUdlOT4NrGhk35P
21E3waRsmPlU7jZsS13rcj	2LqnIQ8brNKkq5UpYasS3M
21E3waRsmPlU7jZsS13rcj	paHyw6nLLQP1js37lYmvxD
21E3waRsmPlU7jZsS13rcj	Ag6mEJFMRpkqeVkwTpdGdv
7t51dSX8ZkKC7VoKRd0lME	1cbJ3J9HHbAMLgkQbz7S4x
7t51dSX8ZkKC7VoKRd0lME	evoqUqYGvypPFnAVgc8Ehb
2NhdGz9EDv2FeUw6udu2g1	CQFwQ9CVGrmSl7IhgEPJxI
2NhdGz9EDv2FeUw6udu2g1	KX8AIg1eUdlOT4NrGhk35P
2NhdGz9EDv2FeUw6udu2g1	2LqnIQ8brNKkq5UpYasS3M
2NhdGz9EDv2FeUw6udu2g1	rZCmSCdlE4mdC3rZnkQI8I
5fahUm8t5c0GIdeTq0ZaG8	m45QR6ueNTjHDukEXoYPJE
5fahUm8t5c0GIdeTq0ZaG8	1MmI2gY2e2xo6j1GOwS52A
5fahUm8t5c0GIdeTq0ZaG8	YxOOM3R5eecR5nKXaAW0Xz
5fahUm8t5c0GIdeTq0ZaG8	p347GOssFGeRsh2UDHcz0X
5fahUm8t5c0GIdeTq0ZaG8	CqvAnCq2v4Q0aMk9ytWTMp
5fahUm8t5c0GIdeTq0ZaG8	DfGFE1USWx7GEiEFiGFsuE
12Chz98pHFMPJEknJQMWvI	FGhbxC5rW4SCZNdzy2Y6JK
12Chz98pHFMPJEknJQMWvI	Da1EKMQQa8bTR2b82MY7ag
12Chz98pHFMPJEknJQMWvI	AkD0RYLVh3masDRAmNER7a
12Chz98pHFMPJEknJQMWvI	nIGGJGaPtlfLiaeQ0DUMhT
5DYAABs8rkY9VhwtENoQCz	qy8fE1PrAelfZ29K13ZSEG
5DYAABs8rkY9VhwtENoQCz	rFBROMeUWoNfNR6AwyhO2N
5IcR3N7QB1j6KBL8eImZ8m	RE12Ku7eAAd6lISO7oBoOh
5IcR3N7QB1j6KBL8eImZ8m	GlCMRz71ZgklFN1OnobcXU
5IcR3N7QB1j6KBL8eImZ8m	LQZm0woEpsP2lZtzqyfO3K
5IcR3N7QB1j6KBL8eImZ8m	V7w4ohCNxr1Ddc3hKRHDWw
5IcR3N7QB1j6KBL8eImZ8m	MEqeqHl7UI8lyedJMux3Wj
5IcR3N7QB1j6KBL8eImZ8m	5x6O4mJLMhXsbI8aUucv2B
3iOvXCl6edW5Um0fXEBRXy	g75PC7NSeFauMtdsPtkiby
3iOvXCl6edW5Um0fXEBRXy	iXxOZuR2UPHmLiW4EpPsWN
3iOvXCl6edW5Um0fXEBRXy	iDVo27DQcN9JLSI8enf6vi
4xFUf1FHVy696Q1JQZMTRj	7aiS44tLtJKjHKjsx14rP6
4xFUf1FHVy696Q1JQZMTRj	n8VMb4nyFdFHY8Zz0ik1uE
4xFUf1FHVy696Q1JQZMTRj	EDF5mqailn2C9hyqQXAcxd
4xFUf1FHVy696Q1JQZMTRj	z98WlS2KpBloy4ohjZZA2G
4xFUf1FHVy696Q1JQZMTRj	K5fCj9fHKVxf4ddjn16JB8
4xFUf1FHVy696Q1JQZMTRj	KX8AIg1eUdlOT4NrGhk35P
1uNFoZAHBGtllmzznpCI3s	wm8hn89gVWDs3sSLr2K7Zu
1uNFoZAHBGtllmzznpCI3s	2LqnIQ8brNKkq5UpYasS3M
6DIS6PRrLS3wbnZsf7vYic	2wkHFHGy2fJvAzKS8ppqgL
6DIS6PRrLS3wbnZsf7vYic	Da1EKMQQa8bTR2b82MY7ag
6DIS6PRrLS3wbnZsf7vYic	2LqnIQ8brNKkq5UpYasS3M
31TPClRtHm23RisEBtV3X7	KX8AIg1eUdlOT4NrGhk35P
31TPClRtHm23RisEBtV3X7	2LqnIQ8brNKkq5UpYasS3M
0ZrpamOxcZybMHGg1AYtHP	KX8AIg1eUdlOT4NrGhk35P
0ZrpamOxcZybMHGg1AYtHP	RKGu0xs9uJF1u5W1psoj23
0ZrpamOxcZybMHGg1AYtHP	LQZm0woEpsP2lZtzqyfO3K
0ZrpamOxcZybMHGg1AYtHP	paHyw6nLLQP1js37lYmvxD
0ZrpamOxcZybMHGg1AYtHP	Ag6mEJFMRpkqeVkwTpdGdv
163tK9Wjr9P9DmM0AVK7lm	jnszrK69fmB7DuSbBUYOcz
163tK9Wjr9P9DmM0AVK7lm	uGPcY5hn2lMGTL6wmWuN7l
163tK9Wjr9P9DmM0AVK7lm	onleIBJY94wm7JXtwDU6CS
163tK9Wjr9P9DmM0AVK7lm	2LqnIQ8brNKkq5UpYasS3M
77SW9BnxLY8rJ0RciFqkHh	whRMEhdeuqs0iaMhxx5Smb
77SW9BnxLY8rJ0RciFqkHh	Da1EKMQQa8bTR2b82MY7ag
77SW9BnxLY8rJ0RciFqkHh	2LqnIQ8brNKkq5UpYasS3M
2txHhyCwHjUEpJjWrEyqyX	xJL83wL7lphcryKvMy8DWS
7Ln80lUS6He07XvHI8qqHH	xSyoi3lZsvwVVqvY9CA42l
7Ln80lUS6He07XvHI8qqHH	Da1EKMQQa8bTR2b82MY7ag
7Ln80lUS6He07XvHI8qqHH	AkD0RYLVh3masDRAmNER7a
7Ln80lUS6He07XvHI8qqHH	nIGGJGaPtlfLiaeQ0DUMhT
7Ln80lUS6He07XvHI8qqHH	lfnwzkeovyEIpy2q0s329x
4gwpcMTbLWtBUlOijbVpuu	uGPcY5hn2lMGTL6wmWuN7l
4gwpcMTbLWtBUlOijbVpuu	Da1EKMQQa8bTR2b82MY7ag
1KCSPY1glIKqW2TotWuXOR	KX8AIg1eUdlOT4NrGhk35P
1KCSPY1glIKqW2TotWuXOR	2LqnIQ8brNKkq5UpYasS3M
74XFHRwlV6OrjEM0A2NCMF	ME3FgRwQZx7XcxftUC8t53
74XFHRwlV6OrjEM0A2NCMF	SJAqPg5xR7LTmJQve15FSd
74XFHRwlV6OrjEM0A2NCMF	2LqnIQ8brNKkq5UpYasS3M
74XFHRwlV6OrjEM0A2NCMF	T3bfHQGBZ3RAoPs2QTgsk3
74XFHRwlV6OrjEM0A2NCMF	pKhTWOvK3Y6IeyDnci4KDu
74XFHRwlV6OrjEM0A2NCMF	nIGGJGaPtlfLiaeQ0DUMhT
5BcAKTbp20cv7tC5VqPFoC	LQZm0woEpsP2lZtzqyfO3K
5BcAKTbp20cv7tC5VqPFoC	gFnsYxq1x22UUZsL9fWUnW
4tZwfgrHOc3mvqYlEYSvVi	PJzZvwuDj5AjJMnlDNF4Rh
4tZwfgrHOc3mvqYlEYSvVi	eMCIJFba7cLfOuPb7ZZIe7
4tZwfgrHOc3mvqYlEYSvVi	nIGGJGaPtlfLiaeQ0DUMhT
4BxCuXFJrSWGi1KHcVqaU4	WDMAEHHMMKmH3PDpnQVVog
4BxCuXFJrSWGi1KHcVqaU4	Da1EKMQQa8bTR2b82MY7ag
73sIBHcqh3Z3NyqHKZ7FOL	zRxPoppovbdFtrtQUZJMDT
73sIBHcqh3Z3NyqHKZ7FOL	GlCMRz71ZgklFN1OnobcXU
73sIBHcqh3Z3NyqHKZ7FOL	V7w4ohCNxr1Ddc3hKRHDWw
0p4nmQO2msCgU4IF37Wi3j	wm8hn89gVWDs3sSLr2K7Zu
0p4nmQO2msCgU4IF37Wi3j	ME3FgRwQZx7XcxftUC8t53
0p4nmQO2msCgU4IF37Wi3j	2LqnIQ8brNKkq5UpYasS3M
66CXWjxzNUsdJxJ2JdwvnR	2LqnIQ8brNKkq5UpYasS3M
1GxkXlMwML1oSg5eLPiAz3	HRReE04Frs6Y1KgpaKi5tr
1GxkXlMwML1oSg5eLPiAz3	wm8hn89gVWDs3sSLr2K7Zu
1GxkXlMwML1oSg5eLPiAz3	yWuvJvZOJ5MIHTAGrUjl2l
1GxkXlMwML1oSg5eLPiAz3	G6WqxqvB3oEBm7ti8lUvnS
6hyMWrxGBsOx6sWcVj1DqP	m45QR6ueNTjHDukEXoYPJE
6hyMWrxGBsOx6sWcVj1DqP	1MmI2gY2e2xo6j1GOwS52A
6hyMWrxGBsOx6sWcVj1DqP	YxOOM3R5eecR5nKXaAW0Xz
6hyMWrxGBsOx6sWcVj1DqP	p347GOssFGeRsh2UDHcz0X
6hyMWrxGBsOx6sWcVj1DqP	CqvAnCq2v4Q0aMk9ytWTMp
6hyMWrxGBsOx6sWcVj1DqP	DfGFE1USWx7GEiEFiGFsuE
0TnOYISbd1XYRBk9myaseg	KX8AIg1eUdlOT4NrGhk35P
0TnOYISbd1XYRBk9myaseg	uSZJVdMWfFSEGkfcmUTnn2
0TnOYISbd1XYRBk9myaseg	2LqnIQ8brNKkq5UpYasS3M
085pc2PYOi8bGKj0PNjekA	KX8AIg1eUdlOT4NrGhk35P
085pc2PYOi8bGKj0PNjekA	2LqnIQ8brNKkq5UpYasS3M
34v5MVKeQnIo0CWYMbbrPf	KX8AIg1eUdlOT4NrGhk35P
61lyPtntblHJvA7FMMhi7E	1MmI2gY2e2xo6j1GOwS52A
61lyPtntblHJvA7FMMhi7E	PXAZ3FP5VbdGWFE9pjGVlG
61lyPtntblHJvA7FMMhi7E	p347GOssFGeRsh2UDHcz0X
61lyPtntblHJvA7FMMhi7E	DfGFE1USWx7GEiEFiGFsuE
61lyPtntblHJvA7FMMhi7E	xJmSkIp1Q4Dl8pDzOfxVDx
3b8QkneNDz4JHKKKlLgYZg	n8VMb4nyFdFHY8Zz0ik1uE
3b8QkneNDz4JHKKKlLgYZg	EDF5mqailn2C9hyqQXAcxd
3b8QkneNDz4JHKKKlLgYZg	RJadUUEPQF39ZfoYVFNREl
3b8QkneNDz4JHKKKlLgYZg	K5fCj9fHKVxf4ddjn16JB8
3b8QkneNDz4JHKKKlLgYZg	GcU1XuaOaeMu1kVMAphgXN
1bT7m67vi78r2oqvxrP3X5	81ZV6b2eZnjKGZts41CQsW
3CjlHNtplJyTf9npxaPl5w	iDVo27DQcN9JLSI8enf6vi
3CjlHNtplJyTf9npxaPl5w	uGPcY5hn2lMGTL6wmWuN7l
3CjlHNtplJyTf9npxaPl5w	bWTeVmpTsiw5ttEVSETCOM
3CjlHNtplJyTf9npxaPl5w	XL1Ai6HyCV5TWOiifZ9kbE
5Pwc4xIPtQLFEnJriah9YJ	MJiWVH1dy7BR2XrCZS1Hpj
5Pwc4xIPtQLFEnJriah9YJ	2LqnIQ8brNKkq5UpYasS3M
6eUKZXaKkcviH0Ku9w2n3V	2LqnIQ8brNKkq5UpYasS3M
6eUKZXaKkcviH0Ku9w2n3V	2ClyZecLJceYYdLli7c9Pa
6eUKZXaKkcviH0Ku9w2n3V	8h1nry3IY96ZTSOwuHMUZR
5y2Xq6xcjJb2jVM54GHK3t	RKGu0xs9uJF1u5W1psoj23
5y2Xq6xcjJb2jVM54GHK3t	2LqnIQ8brNKkq5UpYasS3M
5y2Xq6xcjJb2jVM54GHK3t	8mNfH1L6k6exhWHFjQdfNo
5y2Xq6xcjJb2jVM54GHK3t	Ag6mEJFMRpkqeVkwTpdGdv
2wY79sveU1sp5g7SokKOiI	2LqnIQ8brNKkq5UpYasS3M
2wY79sveU1sp5g7SokKOiI	8h1nry3IY96ZTSOwuHMUZR
0DxeaLnv6SyYk2DOqkLO8c	2LqnIQ8brNKkq5UpYasS3M
0DxeaLnv6SyYk2DOqkLO8c	ufaJetRQmV06BtOolWkGQO
4fwuXg6XQHfdlOdmw36OHa	12XRUtBZVdLgcba8y2Be0o
4fwuXg6XQHfdlOdmw36OHa	E5t7R5wCxfwLPsV2bBh4Au
2l35CQqtYRh3d8ZIiBep4v	2LqnIQ8brNKkq5UpYasS3M
2l35CQqtYRh3d8ZIiBep4v	rZCmSCdlE4mdC3rZnkQI8I
2RdwBSPQiwcmiDo9kixcl8	KX8AIg1eUdlOT4NrGhk35P
2RdwBSPQiwcmiDo9kixcl8	2LqnIQ8brNKkq5UpYasS3M
2ysnwxxNtSgbb9t1m2Ur4j	YfroEA85GouAxakcl98NId
2ysnwxxNtSgbb9t1m2Ur4j	TE6nPFmStCTQOAlbpYbDc5
0MlOPi3zIDMVrfA9R04Fe3	Da1EKMQQa8bTR2b82MY7ag
0MlOPi3zIDMVrfA9R04Fe3	rFBROMeUWoNfNR6AwyhO2N
2gsggkzM5R49q6jpPvazou	KX8AIg1eUdlOT4NrGhk35P
2gsggkzM5R49q6jpPvazou	2LqnIQ8brNKkq5UpYasS3M
1dgdvbogmctybPrGEcnYf6	PXAZ3FP5VbdGWFE9pjGVlG
1dgdvbogmctybPrGEcnYf6	xJmSkIp1Q4Dl8pDzOfxVDx
0X2BH1fck6amBIoJhDVmmJ	iDVo27DQcN9JLSI8enf6vi
0X2BH1fck6amBIoJhDVmmJ	uGPcY5hn2lMGTL6wmWuN7l
0X2BH1fck6amBIoJhDVmmJ	2LqnIQ8brNKkq5UpYasS3M
0X2BH1fck6amBIoJhDVmmJ	8h1nry3IY96ZTSOwuHMUZR
6JL8zeS1NmiOftqZTRgdTz	VxQtETZVbYFskEUTsdsDKL
6JL8zeS1NmiOftqZTRgdTz	2LqnIQ8brNKkq5UpYasS3M
4NHQUGzhtTLFvgF5SZesLK	uGPcY5hn2lMGTL6wmWuN7l
4NHQUGzhtTLFvgF5SZesLK	2LqnIQ8brNKkq5UpYasS3M
4NHQUGzhtTLFvgF5SZesLK	nHA0eOdA7YqGV1OmKAJV9i
4NHQUGzhtTLFvgF5SZesLK	fHr2y58b2e2XiM9tGbGpvQ
4NHQUGzhtTLFvgF5SZesLK	WjxdlV5uG0qXEqnazAq6D6
5xKp3UyavIBUsGy3DQdXeF	qy8fE1PrAelfZ29K13ZSEG
5xKp3UyavIBUsGy3DQdXeF	MJiWVH1dy7BR2XrCZS1Hpj
5xKp3UyavIBUsGy3DQdXeF	rFBROMeUWoNfNR6AwyhO2N
5xKp3UyavIBUsGy3DQdXeF	U2YMYZk71WSt7QDHHl5BMx
3KV3p5EY4AvKxOlhGHORLg	ITUee9sTXyqtVUFSluX7Xd
3KV3p5EY4AvKxOlhGHORLg	LQZm0woEpsP2lZtzqyfO3K
3KV3p5EY4AvKxOlhGHORLg	paHyw6nLLQP1js37lYmvxD
3KV3p5EY4AvKxOlhGHORLg	MEqeqHl7UI8lyedJMux3Wj
3KV3p5EY4AvKxOlhGHORLg	5x6O4mJLMhXsbI8aUucv2B
3KV3p5EY4AvKxOlhGHORLg	Ag6mEJFMRpkqeVkwTpdGdv
2o5jDhtHVPhrJdv3cEQ99Z	RLwofC9qBR221ghUuoRgkS
2o5jDhtHVPhrJdv3cEQ99Z	PN43AI5RvpmbPGEmPLgM2m
2o5jDhtHVPhrJdv3cEQ99Z	Tz5h6Q9QPW1isVTdZqEzxz
2o5jDhtHVPhrJdv3cEQ99Z	1MmI2gY2e2xo6j1GOwS52A
2o5jDhtHVPhrJdv3cEQ99Z	PXAZ3FP5VbdGWFE9pjGVlG
2o5jDhtHVPhrJdv3cEQ99Z	p347GOssFGeRsh2UDHcz0X
2o5jDhtHVPhrJdv3cEQ99Z	KlPR5t4cPejE6UYRLskAtg
2o5jDhtHVPhrJdv3cEQ99Z	jle8qY6Qb25nVjJZOsBYpb
28j8lBWDdDSHSSt5oPlsX2	1MmI2gY2e2xo6j1GOwS52A
28j8lBWDdDSHSSt5oPlsX2	YxOOM3R5eecR5nKXaAW0Xz
0C8ZW7ezQVs4URX5aX7Kqx	2LqnIQ8brNKkq5UpYasS3M
0C8ZW7ezQVs4URX5aX7Kqx	rZCmSCdlE4mdC3rZnkQI8I
0id62QV2SZZfvBn9xpmuCl	8mNfH1L6k6exhWHFjQdfNo
0id62QV2SZZfvBn9xpmuCl	paHyw6nLLQP1js37lYmvxD
7nDsS0l5ZAzMedVRKPP8F1	KX8AIg1eUdlOT4NrGhk35P
7nDsS0l5ZAzMedVRKPP8F1	p347GOssFGeRsh2UDHcz0X
7nDsS0l5ZAzMedVRKPP8F1	E5t7R5wCxfwLPsV2bBh4Au
7nDsS0l5ZAzMedVRKPP8F1	8h1nry3IY96ZTSOwuHMUZR
0f5nVCcR06GX8Qikz0COtT	KX8AIg1eUdlOT4NrGhk35P
0f5nVCcR06GX8Qikz0COtT	VxQtETZVbYFskEUTsdsDKL
0f5nVCcR06GX8Qikz0COtT	paHyw6nLLQP1js37lYmvxD
0f5nVCcR06GX8Qikz0COtT	V7w4ohCNxr1Ddc3hKRHDWw
0f5nVCcR06GX8Qikz0COtT	MEqeqHl7UI8lyedJMux3Wj
0f5nVCcR06GX8Qikz0COtT	5x6O4mJLMhXsbI8aUucv2B
0f5nVCcR06GX8Qikz0COtT	Ag6mEJFMRpkqeVkwTpdGdv
3hv9jJF3adDNsBSIQDqcjp	8mNfH1L6k6exhWHFjQdfNo
738wLrAtLtCtFOLvQBXOXp	KX8AIg1eUdlOT4NrGhk35P
738wLrAtLtCtFOLvQBXOXp	1MmI2gY2e2xo6j1GOwS52A
738wLrAtLtCtFOLvQBXOXp	YxOOM3R5eecR5nKXaAW0Xz
738wLrAtLtCtFOLvQBXOXp	ILlTKd2YFAPwupxx14GkIA
738wLrAtLtCtFOLvQBXOXp	2LqnIQ8brNKkq5UpYasS3M
738wLrAtLtCtFOLvQBXOXp	p347GOssFGeRsh2UDHcz0X
1Xyo4u8uXC1ZmMpatF05PJ	KV11b7otLS9PvWDLTW8cAQ
1Xyo4u8uXC1ZmMpatF05PJ	wm8hn89gVWDs3sSLr2K7Zu
1Xyo4u8uXC1ZmMpatF05PJ	2LqnIQ8brNKkq5UpYasS3M
5INjqkS1o8h1imAzPqGZBb	D5yLheUsT8zzsoVMJ4c4wR
5INjqkS1o8h1imAzPqGZBb	Da1EKMQQa8bTR2b82MY7ag
5INjqkS1o8h1imAzPqGZBb	pjcsFJvBfng7KmcXaglR0k
5INjqkS1o8h1imAzPqGZBb	nIGGJGaPtlfLiaeQ0DUMhT
6VxCmtR7S3yz4vnzsJqhSV	UrSGGyAt0d2pI5Lh7pnfNC
6VxCmtR7S3yz4vnzsJqhSV	YfroEA85GouAxakcl98NId
1IueXOQyABrMOprrzwQJWN	KX8AIg1eUdlOT4NrGhk35P
1IueXOQyABrMOprrzwQJWN	1MmI2gY2e2xo6j1GOwS52A
1IueXOQyABrMOprrzwQJWN	p347GOssFGeRsh2UDHcz0X
1IueXOQyABrMOprrzwQJWN	xJmSkIp1Q4Dl8pDzOfxVDx
1IueXOQyABrMOprrzwQJWN	8h1nry3IY96ZTSOwuHMUZR
2qxJFvFYMEDqd7ui6kSAcq	7qOyvybcAUPfPJt4DD9cQT
2qxJFvFYMEDqd7ui6kSAcq	1MmI2gY2e2xo6j1GOwS52A
2qxJFvFYMEDqd7ui6kSAcq	ONXFicyTiZTmut1iMLIfu9
2qxJFvFYMEDqd7ui6kSAcq	2LqnIQ8brNKkq5UpYasS3M
2qxJFvFYMEDqd7ui6kSAcq	p347GOssFGeRsh2UDHcz0X
6PXS4YHDkKvl1wkIl4V8DL	K87lZfJGvow9Fpz8PBG1aT
6PXS4YHDkKvl1wkIl4V8DL	LQZm0woEpsP2lZtzqyfO3K
6PXS4YHDkKvl1wkIl4V8DL	V7w4ohCNxr1Ddc3hKRHDWw
6PXS4YHDkKvl1wkIl4V8DL	MEqeqHl7UI8lyedJMux3Wj
6PXS4YHDkKvl1wkIl4V8DL	5x6O4mJLMhXsbI8aUucv2B
69GGBxA162lTqCwzJG5jLp	olqVcznfeC6c5LCW33m8Ix
69GGBxA162lTqCwzJG5jLp	2LqnIQ8brNKkq5UpYasS3M
2h93pZq0e7k5yf4dywlkpM	4Bu7iQsKfKCrmqikvXowwd
2h93pZq0e7k5yf4dywlkpM	RKGu0xs9uJF1u5W1psoj23
7n2wHs1TKAczGzO7Dd2rGr	wm8hn89gVWDs3sSLr2K7Zu
7n2wHs1TKAczGzO7Dd2rGr	2LqnIQ8brNKkq5UpYasS3M
7n2wHs1TKAczGzO7Dd2rGr	U2YMYZk71WSt7QDHHl5BMx
5WUlDfRSoLAfcVSX1WnrxN	5wqS8b6SV9Y7XcLuJNFjpg
5WUlDfRSoLAfcVSX1WnrxN	1PMfLOqFsvN8tSveICzhNJ
5WUlDfRSoLAfcVSX1WnrxN	2LqnIQ8brNKkq5UpYasS3M
540vIaP2JwjQb9dm3aArA4	1MmI2gY2e2xo6j1GOwS52A
540vIaP2JwjQb9dm3aArA4	eWamSWFq3Eak5J9dE5SQIF
540vIaP2JwjQb9dm3aArA4	2LqnIQ8brNKkq5UpYasS3M
540vIaP2JwjQb9dm3aArA4	p347GOssFGeRsh2UDHcz0X
3YQKmKGau1PzlVlkL1iodx	Da1EKMQQa8bTR2b82MY7ag
3YQKmKGau1PzlVlkL1iodx	2LqnIQ8brNKkq5UpYasS3M
3YQKmKGau1PzlVlkL1iodx	rk5tGP58hdo4pxkbh8q86J
3YQKmKGau1PzlVlkL1iodx	nIGGJGaPtlfLiaeQ0DUMhT
25u4wHJWxCA9vO0CzxAbK7	OMX31irZbRKPmRLaBNmWKa
25u4wHJWxCA9vO0CzxAbK7	LNGQsYWJ5Dx7TzYpr6M0gZ
2EMAnMvWE2eb56ToJVfCWs	XcNos4n1PLEv9wmF8e5vH2
2EMAnMvWE2eb56ToJVfCWs	paHyw6nLLQP1js37lYmvxD
2EMAnMvWE2eb56ToJVfCWs	V7w4ohCNxr1Ddc3hKRHDWw
6T5tfhQCknKG4UnH90qGnz	KX8AIg1eUdlOT4NrGhk35P
6T5tfhQCknKG4UnH90qGnz	2LqnIQ8brNKkq5UpYasS3M
60d24wfXkVzDSfLS6hyCjZ	Tz5h6Q9QPW1isVTdZqEzxz
60d24wfXkVzDSfLS6hyCjZ	1MmI2gY2e2xo6j1GOwS52A
60d24wfXkVzDSfLS6hyCjZ	2LqnIQ8brNKkq5UpYasS3M
60d24wfXkVzDSfLS6hyCjZ	p347GOssFGeRsh2UDHcz0X
60d24wfXkVzDSfLS6hyCjZ	DfGFE1USWx7GEiEFiGFsuE
6ydoSd3N2mwgwBHtF6K7eX	2LqnIQ8brNKkq5UpYasS3M
7vk5e3vY1uw9plTHJAMwjN	YxOOM3R5eecR5nKXaAW0Xz
2KsP6tYLJlTBvSUxnwlVWa	KX8AIg1eUdlOT4NrGhk35P
2KsP6tYLJlTBvSUxnwlVWa	2LqnIQ8brNKkq5UpYasS3M
2KsP6tYLJlTBvSUxnwlVWa	p347GOssFGeRsh2UDHcz0X
2KsP6tYLJlTBvSUxnwlVWa	LQZm0woEpsP2lZtzqyfO3K
3rWZHrfrsPBxVy692yAIxF	OeQbml10ezBXw9Odwqv66c
3rWZHrfrsPBxVy692yAIxF	2LqnIQ8brNKkq5UpYasS3M
3rWZHrfrsPBxVy692yAIxF	rZCmSCdlE4mdC3rZnkQI8I
3rWZHrfrsPBxVy692yAIxF	rk5tGP58hdo4pxkbh8q86J
4IWBUUAFIplrNtaOHcJPRM	2LqnIQ8brNKkq5UpYasS3M
4IWBUUAFIplrNtaOHcJPRM	E5t7R5wCxfwLPsV2bBh4Au
4IWBUUAFIplrNtaOHcJPRM	8h1nry3IY96ZTSOwuHMUZR
7keGfmQR4X5w0two1xKZ7d	1MmI2gY2e2xo6j1GOwS52A
7keGfmQR4X5w0two1xKZ7d	p347GOssFGeRsh2UDHcz0X
3NPpFNZtSTHheNBaWC82rB	whRMEhdeuqs0iaMhxx5Smb
3NPpFNZtSTHheNBaWC82rB	Da1EKMQQa8bTR2b82MY7ag
3NPpFNZtSTHheNBaWC82rB	UU8QVhTYWa1uxpC479zrDd
0B3N0ZINFWvizfa8bKiz4v	LpC51HwpGMjBuJsqrdk6PC
26T3LtbuGT1Fu9m0eRq5X3	whRMEhdeuqs0iaMhxx5Smb
26T3LtbuGT1Fu9m0eRq5X3	Da1EKMQQa8bTR2b82MY7ag
26T3LtbuGT1Fu9m0eRq5X3	rk5tGP58hdo4pxkbh8q86J
26T3LtbuGT1Fu9m0eRq5X3	KgpcnXPSTCyBJAMrvW40hu
26T3LtbuGT1Fu9m0eRq5X3	nIGGJGaPtlfLiaeQ0DUMhT
4ON1ruy5ijE7ZPQthbrkgI	YxOOM3R5eecR5nKXaAW0Xz
3mIj9lX2MWuHmhNCA7LSCW	whRMEhdeuqs0iaMhxx5Smb
3mIj9lX2MWuHmhNCA7LSCW	Da1EKMQQa8bTR2b82MY7ag
3mIj9lX2MWuHmhNCA7LSCW	2LqnIQ8brNKkq5UpYasS3M
3mIj9lX2MWuHmhNCA7LSCW	rk5tGP58hdo4pxkbh8q86J
3mIj9lX2MWuHmhNCA7LSCW	nIGGJGaPtlfLiaeQ0DUMhT
4V8Sr092TqfHkfAA5fXXqG	SqiWV5CL9rWp0Z64AlSqGA
4V8Sr092TqfHkfAA5fXXqG	61Hf3FSCEBZj8KEw66ngAQ
6TIYQ3jFPwQSRmorSezPxX	c3gWFzN7qEkecoe3Z6JSJI
6TIYQ3jFPwQSRmorSezPxX	LQZm0woEpsP2lZtzqyfO3K
6MDME20pz9RveH9rEXvrOM	2LqnIQ8brNKkq5UpYasS3M
6MDME20pz9RveH9rEXvrOM	xJmSkIp1Q4Dl8pDzOfxVDx
6MDME20pz9RveH9rEXvrOM	q7GOSyn2ukFdbVxwq8Gk9A
4nDoRrQiYLoBzwC5BhVJzF	KX8AIg1eUdlOT4NrGhk35P
4nDoRrQiYLoBzwC5BhVJzF	2LqnIQ8brNKkq5UpYasS3M
0Y5tJX1MQlPlqiwlOH1tJY	GlCMRz71ZgklFN1OnobcXU
0Y5tJX1MQlPlqiwlOH1tJY	V7w4ohCNxr1Ddc3hKRHDWw
0Y5tJX1MQlPlqiwlOH1tJY	KlPR5t4cPejE6UYRLskAtg
6vXTefBL93Dj5IqAWq6OTv	GlCMRz71ZgklFN1OnobcXU
6vXTefBL93Dj5IqAWq6OTv	LQZm0woEpsP2lZtzqyfO3K
6vXTefBL93Dj5IqAWq6OTv	V7w4ohCNxr1Ddc3hKRHDWw
6vXTefBL93Dj5IqAWq6OTv	MEqeqHl7UI8lyedJMux3Wj
6vXTefBL93Dj5IqAWq6OTv	5x6O4mJLMhXsbI8aUucv2B
4kYGAK2zu9EAomwj3hXkXy	8h1nry3IY96ZTSOwuHMUZR
0c173mlxpT3dSFRgMO8XPh	eQ963SlkrY8qwgmn93yBAt
0c173mlxpT3dSFRgMO8XPh	GlCMRz71ZgklFN1OnobcXU
0c173mlxpT3dSFRgMO8XPh	LQZm0woEpsP2lZtzqyfO3K
0c173mlxpT3dSFRgMO8XPh	paHyw6nLLQP1js37lYmvxD
0c173mlxpT3dSFRgMO8XPh	V7w4ohCNxr1Ddc3hKRHDWw
0c173mlxpT3dSFRgMO8XPh	5x6O4mJLMhXsbI8aUucv2B
5pUo3fmmHT8bhCyHE52hA6	2LqnIQ8brNKkq5UpYasS3M
6qqNVTkY8uBg9cP3Jd7DAH	jnszrK69fmB7DuSbBUYOcz
6qqNVTkY8uBg9cP3Jd7DAH	olqVcznfeC6c5LCW33m8Ix
6qqNVTkY8uBg9cP3Jd7DAH	2LqnIQ8brNKkq5UpYasS3M
246dkjvS1zLTtiykXe5h60	bUhO3s169C99vASWosayYh
246dkjvS1zLTtiykXe5h60	pjblhQJB45QunspXS6ZAOA
246dkjvS1zLTtiykXe5h60	2LqnIQ8brNKkq5UpYasS3M
246dkjvS1zLTtiykXe5h60	V7w4ohCNxr1Ddc3hKRHDWw
3uwAm6vQy7kWPS2bciKWx9	5R5IjnVj1CD9OQutNosuKN
3uwAm6vQy7kWPS2bciKWx9	t15dOujjAvsTDv7NLOJMdK
3uwAm6vQy7kWPS2bciKWx9	MIrdXy4BMTyiqcSI4Mercu
3uwAm6vQy7kWPS2bciKWx9	2LqnIQ8brNKkq5UpYasS3M
3uwAm6vQy7kWPS2bciKWx9	rk5tGP58hdo4pxkbh8q86J
4xRYI6VqpkE3UwrDrAZL8L	4BcJaCA3fGBwot6p3xC1Hn
4xRYI6VqpkE3UwrDrAZL8L	GlCMRz71ZgklFN1OnobcXU
4xRYI6VqpkE3UwrDrAZL8L	LQZm0woEpsP2lZtzqyfO3K
4xRYI6VqpkE3UwrDrAZL8L	V7w4ohCNxr1Ddc3hKRHDWw
7HV2RI2qNug4EcQqLbCAKS	1tE04hUvWs276n65f6BXse
7HV2RI2qNug4EcQqLbCAKS	fX7SJojTn2hVIqOsWA1oD0
7HV2RI2qNug4EcQqLbCAKS	WN8qrP0ZGTM6fYVliKUCYH
7iZtZyCzp3LItcw1wtPI3D	pjblhQJB45QunspXS6ZAOA
7iZtZyCzp3LItcw1wtPI3D	2xqpPLoyyO6rnkbKwtr1WK
7iZtZyCzp3LItcw1wtPI3D	LQZm0woEpsP2lZtzqyfO3K
7iZtZyCzp3LItcw1wtPI3D	V7w4ohCNxr1Ddc3hKRHDWw
7iZtZyCzp3LItcw1wtPI3D	5x6O4mJLMhXsbI8aUucv2B
0A0FS04o6zMoto8OKPsDwY	62G7OOtJTRdi1PryEXZShG
0A0FS04o6zMoto8OKPsDwY	GlCMRz71ZgklFN1OnobcXU
0A0FS04o6zMoto8OKPsDwY	LQZm0woEpsP2lZtzqyfO3K
0A0FS04o6zMoto8OKPsDwY	V7w4ohCNxr1Ddc3hKRHDWw
0A0FS04o6zMoto8OKPsDwY	MEqeqHl7UI8lyedJMux3Wj
0A0FS04o6zMoto8OKPsDwY	5x6O4mJLMhXsbI8aUucv2B
6ueGR6SWhUJfvEhqkvMsVs	OeQbml10ezBXw9Odwqv66c
6ueGR6SWhUJfvEhqkvMsVs	54N9baSXNUahxUCcikv3K6
6ueGR6SWhUJfvEhqkvMsVs	zRxPoppovbdFtrtQUZJMDT
6ueGR6SWhUJfvEhqkvMsVs	RKGu0xs9uJF1u5W1psoj23
6ueGR6SWhUJfvEhqkvMsVs	paHyw6nLLQP1js37lYmvxD
4ScCswdRlyA23odg9thgIO	2LqnIQ8brNKkq5UpYasS3M
4ScCswdRlyA23odg9thgIO	8h1nry3IY96ZTSOwuHMUZR
7jVv8c5Fj3E9VhNjxT4snq	4Bu7iQsKfKCrmqikvXowwd
5IH6FPUwQTxPSXurCrcIov	IG4smdaVC84wz7gwPOEyG4
5IH6FPUwQTxPSXurCrcIov	2LqnIQ8brNKkq5UpYasS3M
5IH6FPUwQTxPSXurCrcIov	rk5tGP58hdo4pxkbh8q86J
26VFTg2z8YR0cCuwLzESi2	olqVcznfeC6c5LCW33m8Ix
26VFTg2z8YR0cCuwLzESi2	v3SyDno1YuSOKxHgott5IN
26VFTg2z8YR0cCuwLzESi2	AQJy0cICgcJ7OAwLkr6Mtr
26VFTg2z8YR0cCuwLzESi2	2LqnIQ8brNKkq5UpYasS3M
3hteYQFiMFbJY7wS0xDymP	24fGvv8QRXLovtu5VbP2gy
3hteYQFiMFbJY7wS0xDymP	fXOuPUBgRaCtKUDTsPaWXN
4GNC7GD6oZMSxPGyXy4MNB	2LqnIQ8brNKkq5UpYasS3M
4GNC7GD6oZMSxPGyXy4MNB	8h1nry3IY96ZTSOwuHMUZR
6l3HvQ5sa6mXTsMTB19rO5	4BcJaCA3fGBwot6p3xC1Hn
6l3HvQ5sa6mXTsMTB19rO5	GlCMRz71ZgklFN1OnobcXU
6l3HvQ5sa6mXTsMTB19rO5	hs5A54oY9fUiTpBHf2HoDI
6l3HvQ5sa6mXTsMTB19rO5	V7w4ohCNxr1Ddc3hKRHDWw
7gOdHgIoIKoe4i9Tta6qdD	CQFwQ9CVGrmSl7IhgEPJxI
7gOdHgIoIKoe4i9Tta6qdD	2LqnIQ8brNKkq5UpYasS3M
20JZFwl6HVl6yg8a4H3ZqK	2LqnIQ8brNKkq5UpYasS3M
1URnnhqYAYcrqrcwql10ft	zRxPoppovbdFtrtQUZJMDT
1URnnhqYAYcrqrcwql10ft	GlCMRz71ZgklFN1OnobcXU
1URnnhqYAYcrqrcwql10ft	V7w4ohCNxr1Ddc3hKRHDWw
1URnnhqYAYcrqrcwql10ft	5x6O4mJLMhXsbI8aUucv2B
4Ga1P7PMIsmqEZqhYZQgDo	pjblhQJB45QunspXS6ZAOA
4Ga1P7PMIsmqEZqhYZQgDo	WLZroBceQZFCG7ljpXflI1
4Ga1P7PMIsmqEZqhYZQgDo	V7w4ohCNxr1Ddc3hKRHDWw
4npEfmQ6YuiwW1GpUmaq3F	2LqnIQ8brNKkq5UpYasS3M
31W5EY0aAly4Qieq6OFu6I	pjblhQJB45QunspXS6ZAOA
31W5EY0aAly4Qieq6OFu6I	V7w4ohCNxr1Ddc3hKRHDWw
31W5EY0aAly4Qieq6OFu6I	5x6O4mJLMhXsbI8aUucv2B
1dfeR4HaWDbWqFHLkxsg1d	c5D7GRT5IyOdGIkBhlplos
1dfeR4HaWDbWqFHLkxsg1d	ZB3H6hTaQPKi1pfxVvOebG
1dfeR4HaWDbWqFHLkxsg1d	nIGGJGaPtlfLiaeQ0DUMhT
3vQ0GE3mI0dAaxIMYe5g7z	CPgPn5DepKQAqStEunofjK
3vQ0GE3mI0dAaxIMYe5g7z	7OTFfc8tiNmSCXXbwPg1Yu
3vQ0GE3mI0dAaxIMYe5g7z	ktrk3k6tCTZNNrlISwX5kO
3vQ0GE3mI0dAaxIMYe5g7z	9w3uqSLrhbvdSfLQ57uLuU
6LuN9FCkKOj5PcnpouEgny	2LqnIQ8brNKkq5UpYasS3M
6LuN9FCkKOj5PcnpouEgny	DinotCxIRVhJe6W4CDECJi
6ASri4ePR7RlsvIQgWPJpS	pjblhQJB45QunspXS6ZAOA
3oSJ7TBVCWMDMiYjXNiCKE	WbSSwtr2CJXi788eXDPYVu
3oSJ7TBVCWMDMiYjXNiCKE	n8VMb4nyFdFHY8Zz0ik1uE
3oSJ7TBVCWMDMiYjXNiCKE	EDF5mqailn2C9hyqQXAcxd
3oSJ7TBVCWMDMiYjXNiCKE	K5fCj9fHKVxf4ddjn16JB8
181bsRPaVXVlUKXrxwZfHK	x16TUa2BYHHDeUbZLhhtuR
181bsRPaVXVlUKXrxwZfHK	2LqnIQ8brNKkq5UpYasS3M
181bsRPaVXVlUKXrxwZfHK	paHyw6nLLQP1js37lYmvxD
181bsRPaVXVlUKXrxwZfHK	V7w4ohCNxr1Ddc3hKRHDWw
181bsRPaVXVlUKXrxwZfHK	E5O6sd9pNHsoIo8A9iZ0fV
1MIVXf74SZHmTIp4V4paH4	2LqnIQ8brNKkq5UpYasS3M
1MIVXf74SZHmTIp4V4paH4	8h1nry3IY96ZTSOwuHMUZR
3Fl1V19tmjt57oBdxXKAjJ	62G7OOtJTRdi1PryEXZShG
3Fl1V19tmjt57oBdxXKAjJ	V7w4ohCNxr1Ddc3hKRHDWw
6KImCVD70vtIoJWnq6nGn3	2LqnIQ8brNKkq5UpYasS3M
5zctI4wO9XSKS8XwcnqEHk	pjblhQJB45QunspXS6ZAOA
5zctI4wO9XSKS8XwcnqEHk	AhaE5fYg9kfiPHde54Q6tD
757aE44tKEUQEqRuT6GnEB	pjblhQJB45QunspXS6ZAOA
757aE44tKEUQEqRuT6GnEB	V7w4ohCNxr1Ddc3hKRHDWw
757aE44tKEUQEqRuT6GnEB	5x6O4mJLMhXsbI8aUucv2B
1XLWox9w1Yvbodui0SRhUQ	pjblhQJB45QunspXS6ZAOA
6bmlMHgSheBauioMgKv2tn	Esk4OKC2M5LYTr1odMWEfo
6bmlMHgSheBauioMgKv2tn	34YJrUJWsk5DlJx1LC4gF3
4Uc8Dsxct0oMqx0P6i60ea	5R5IjnVj1CD9OQutNosuKN
4Uc8Dsxct0oMqx0P6i60ea	2LqnIQ8brNKkq5UpYasS3M
4Uc8Dsxct0oMqx0P6i60ea	rk5tGP58hdo4pxkbh8q86J
5cj0lLjcoR7YOSnhnX0Po5	KX8AIg1eUdlOT4NrGhk35P
5cj0lLjcoR7YOSnhnX0Po5	2LqnIQ8brNKkq5UpYasS3M
3Nrfpe0tUJi4K4DXYWgMUX	DcNk8lp9KZ055xRuGYWXXR
3Nrfpe0tUJi4K4DXYWgMUX	RX4H4axTGaWLS4sZZ6vQWV
3Nrfpe0tUJi4K4DXYWgMUX	2LqnIQ8brNKkq5UpYasS3M
6fWVd57NKTalqvmjRd2t8Z	62G7OOtJTRdi1PryEXZShG
6fWVd57NKTalqvmjRd2t8Z	LQZm0woEpsP2lZtzqyfO3K
0eDvMgVFoNV3TpwtrVCoTj	6aEKX0GcqfCc38OkysSsSP
0eDvMgVFoNV3TpwtrVCoTj	V7w4ohCNxr1Ddc3hKRHDWw
0H39MdGGX6dbnnQPt6NQkZ	pjblhQJB45QunspXS6ZAOA
0H39MdGGX6dbnnQPt6NQkZ	KlPR5t4cPejE6UYRLskAtg
4ETSs924pXMzjIeD6E9b4u	YUW1dEljdN3HULeSkRiOef
4LLpKhyESsyAXpc4laK94U	GlCMRz71ZgklFN1OnobcXU
4LLpKhyESsyAXpc4laK94U	E1dNffWSO2mKOroONjQTNr
4LLpKhyESsyAXpc4laK94U	LQZm0woEpsP2lZtzqyfO3K
4LLpKhyESsyAXpc4laK94U	V7w4ohCNxr1Ddc3hKRHDWw
1McMsnEElThX1knmY4oliG	2LqnIQ8brNKkq5UpYasS3M
0lAWpj5szCSwM4rUMHYmrr	AY8O9R8iNRPBamB1tFght8
0lAWpj5szCSwM4rUMHYmrr	BQktr5JJITJJZ5lgY6CYim
0lAWpj5szCSwM4rUMHYmrr	2LqnIQ8brNKkq5UpYasS3M
7tYKF4w9nC0nq9CsPZTHyP	2LqnIQ8brNKkq5UpYasS3M
7tYKF4w9nC0nq9CsPZTHyP	paHyw6nLLQP1js37lYmvxD
7tYKF4w9nC0nq9CsPZTHyP	V7w4ohCNxr1Ddc3hKRHDWw
2tIP7SsRs7vjIcLrU85W8J	9cvCd1Hdq7wVO4rypEPeCu
4fxd5Ee7UefO4CUXgwJ7IP	paHyw6nLLQP1js37lYmvxD
1uU7g3DNSbsu0QjSEqZtEd	9cvCd1Hdq7wVO4rypEPeCu
5L1lO4eRHmJ7a0Q6csE5cT	DcNk8lp9KZ055xRuGYWXXR
6M2wZ9GZgrQXHCFfjv46we	KX8AIg1eUdlOT4NrGhk35P
6M2wZ9GZgrQXHCFfjv46we	2LqnIQ8brNKkq5UpYasS3M
6M2wZ9GZgrQXHCFfjv46we	8h1nry3IY96ZTSOwuHMUZR
1mcTU81TzQhprhouKaTkpq	61Hf3FSCEBZj8KEw66ngAQ
1mcTU81TzQhprhouKaTkpq	vRFcSUhahCULB7h5aTdeRb
1mcTU81TzQhprhouKaTkpq	ktrk3k6tCTZNNrlISwX5kO
1mcTU81TzQhprhouKaTkpq	9w3uqSLrhbvdSfLQ57uLuU
64H8UqGLbJFHwKtGxiV8OP	5Yr7onU6UVhG1VSU41Nm4r
6TLwD7HPWuiOzvXEa3oCNe	rPPWJB9c7yAToT7rFpgm2f
2WgfkM8S11vg4kxLgDY3F5	vBfFTPAwlJfvsmpUnMp9PD
2WgfkM8S11vg4kxLgDY3F5	EcsffyRILA6Ne7rauVMZLa
4q3ewBCX7sLwd24euuV69X	vRFcSUhahCULB7h5aTdeRb
4q3ewBCX7sLwd24euuV69X	ktrk3k6tCTZNNrlISwX5kO
4q3ewBCX7sLwd24euuV69X	9w3uqSLrhbvdSfLQ57uLuU
1aSxMhuvixZ8h9dK9jIDwL	jnszrK69fmB7DuSbBUYOcz
1aSxMhuvixZ8h9dK9jIDwL	syBGcuT9jWrPfBa7Vh1AsO
1aSxMhuvixZ8h9dK9jIDwL	FS3g1jguh01C3PFkxEDLIK
1aSxMhuvixZ8h9dK9jIDwL	wrRGXCEQsvha5hG2uoKaD0
1aSxMhuvixZ8h9dK9jIDwL	AkD0RYLVh3masDRAmNER7a
1aSxMhuvixZ8h9dK9jIDwL	MJiWVH1dy7BR2XrCZS1Hpj
1aSxMhuvixZ8h9dK9jIDwL	1esd4m69Iex1apATbeolIi
3MZsBdqDrRTJihTHQrO6Dq	U2YMYZk71WSt7QDHHl5BMx
6vWDO969PvNqNYHIOW5v0m	2LqnIQ8brNKkq5UpYasS3M
6vWDO969PvNqNYHIOW5v0m	paHyw6nLLQP1js37lYmvxD
2LIk90788K0zvyj2JJVwkJ	bNWEjL606f7gSiJdxiC8St
2LIk90788K0zvyj2JJVwkJ	XcNos4n1PLEv9wmF8e5vH2
2LIk90788K0zvyj2JJVwkJ	LQZm0woEpsP2lZtzqyfO3K
2LIk90788K0zvyj2JJVwkJ	V7w4ohCNxr1Ddc3hKRHDWw
4yvcSjfu4PC0CYQyLy4wSq	69wc6lt5SwPMAvp4SToVqB
4yvcSjfu4PC0CYQyLy4wSq	iDVo27DQcN9JLSI8enf6vi
4yvcSjfu4PC0CYQyLy4wSq	Da1EKMQQa8bTR2b82MY7ag
4yvcSjfu4PC0CYQyLy4wSq	rk5tGP58hdo4pxkbh8q86J
4yvcSjfu4PC0CYQyLy4wSq	tLsmgA0UBLmbPx6Vo1V5hH
57vWImR43h4CaDao012Ofp	OeQbml10ezBXw9Odwqv66c
2VSHKHBTiXWplO8lxcnUC9	5Yr7onU6UVhG1VSU41Nm4r
56oDRnqbIiwx4mymNEv7dS	LopH6sALrbxJB9jXOAyIHZ
56oDRnqbIiwx4mymNEv7dS	xwwWaXTo5X4mEu2dYcD1EY
56oDRnqbIiwx4mymNEv7dS	2LqnIQ8brNKkq5UpYasS3M
56oDRnqbIiwx4mymNEv7dS	E5O6sd9pNHsoIo8A9iZ0fV
716NhGYqD1jl2wI1Qkgq36	CPgPn5DepKQAqStEunofjK
716NhGYqD1jl2wI1Qkgq36	xQwb2SWGETlHt8ipkkMjVx
716NhGYqD1jl2wI1Qkgq36	7OTFfc8tiNmSCXXbwPg1Yu
716NhGYqD1jl2wI1Qkgq36	ktrk3k6tCTZNNrlISwX5kO
716NhGYqD1jl2wI1Qkgq36	9w3uqSLrhbvdSfLQ57uLuU
7ltDVBr6mKbRvohxheJ9h1	2LqnIQ8brNKkq5UpYasS3M
7ltDVBr6mKbRvohxheJ9h1	Na6i9qIZwUBjh0Ov9tLFw7
3PhoLpVuITZKcymswpck5b	ZB3H6hTaQPKi1pfxVvOebG
3PhoLpVuITZKcymswpck5b	NQeLsgsYpwYBX4aApn5Upx
3PhoLpVuITZKcymswpck5b	MJiWVH1dy7BR2XrCZS1Hpj
3PhoLpVuITZKcymswpck5b	nIGGJGaPtlfLiaeQ0DUMhT
2W8yFh0Ga6Yf3jiayVxwkE	2LqnIQ8brNKkq5UpYasS3M
7FNnA9vBm6EKceENgCGRMb	hCgKRkQTDZo2XHydo4eeOm
7FNnA9vBm6EKceENgCGRMb	206OTeUPpl8N13GNYmddps
7FNnA9vBm6EKceENgCGRMb	CFsePd5hHGWZWffCFWoBPh
7FNnA9vBm6EKceENgCGRMb	2LqnIQ8brNKkq5UpYasS3M
7FNnA9vBm6EKceENgCGRMb	NO19etMNwImOzKIF1N87vH
41MozSoPIsD1dJM0CLPjZF	DcNk8lp9KZ055xRuGYWXXR
41MozSoPIsD1dJM0CLPjZF	uS1hIY0naImftN7PbxANfv
41MozSoPIsD1dJM0CLPjZF	2LqnIQ8brNKkq5UpYasS3M
6VuMaDnrHyPL1p4EHjYLi7	2LqnIQ8brNKkq5UpYasS3M
6VuMaDnrHyPL1p4EHjYLi7	U2YMYZk71WSt7QDHHl5BMx
29PgYEggDV3cDP9QYTogwv	ukfygj1uRINXFakBs6xQ54
790FomKkXshlbRYZFtlgla	vRFcSUhahCULB7h5aTdeRb
790FomKkXshlbRYZFtlgla	oo4zOZrByUfqReFuQ39mue
790FomKkXshlbRYZFtlgla	ktrk3k6tCTZNNrlISwX5kO
790FomKkXshlbRYZFtlgla	9w3uqSLrhbvdSfLQ57uLuU
0EmeFodog0BfCgMzAIvKQp	VvMSF3lVtekGjSLvYLngn6
0EmeFodog0BfCgMzAIvKQp	KX8AIg1eUdlOT4NrGhk35P
0EmeFodog0BfCgMzAIvKQp	SqiWV5CL9rWp0Z64AlSqGA
0EmeFodog0BfCgMzAIvKQp	2LqnIQ8brNKkq5UpYasS3M
4obzFoKoKRHIphyHzJ35G3	SqiWV5CL9rWp0Z64AlSqGA
4obzFoKoKRHIphyHzJ35G3	PrEEMD3yOE9Ek9UqhaJ1O3
4obzFoKoKRHIphyHzJ35G3	bLFepGDnAaTLmJYH7XesAc
4obzFoKoKRHIphyHzJ35G3	vRFcSUhahCULB7h5aTdeRb
4obzFoKoKRHIphyHzJ35G3	ktrk3k6tCTZNNrlISwX5kO
4obzFoKoKRHIphyHzJ35G3	9w3uqSLrhbvdSfLQ57uLuU
3MdXrJWsbVzdn6fe5JYkSQ	E5O6sd9pNHsoIo8A9iZ0fV
5H4yInM5zmHqpKIoMNAx4r	o9GycCqBH9WmBqxLQBg3PA
2hlmm7s2ICUX0LVIhVFlZQ	zRxPoppovbdFtrtQUZJMDT
2hlmm7s2ICUX0LVIhVFlZQ	pjblhQJB45QunspXS6ZAOA
2hlmm7s2ICUX0LVIhVFlZQ	V7w4ohCNxr1Ddc3hKRHDWw
2hlmm7s2ICUX0LVIhVFlZQ	5x6O4mJLMhXsbI8aUucv2B
\.


--
-- TOC entry 4877 (class 0 OID 75887)
-- Dependencies: 219
-- Data for Name: artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artists (artist_id, artist_name, artist_popularity) FROM stdin;
3rWZHrfrsPBxVy692yAIxF	WILLOW	69
6CwfuxIqcltXDGjfZsMd9A	MARINA	70
2aYJ5LAta2ScCdfLhKgZOY	Cobra Starship	55
3CjlHNtplJyTf9npxaPl5w	CHVRCHES	61
0EmeFodog0BfCgMzAIvKQp	Shakira	85
3oSJ7TBVCWMDMiYjXNiCKE	Kane Brown	72
4xRYI6VqpkE3UwrDrAZL8L	Logic	73
1h6Cn3P4NGzXbaXidqURXs	Swedish House Mafia	74
4nDoRrQiYLoBzwC5BhVJzF	Camila Cabello	78
4GNC7GD6oZMSxPGyXy4MNB	Lewis Capaldi	79
3FUY2gzHeIiaesXtOAdB7A	Train	71
26VFTg2z8YR0cCuwLzESi2	Halsey	80
57vWImR43h4CaDao012Ofp	Steve Lacy	79
04gDigrS5kc9YWfZHwBETP	Maroon 5	83
7H55rcKCfwqkyDFH9wpKM6	Christina Perri	69
2RdwBSPQiwcmiDo9kixcl8	Pharrell Williams	77
6VuMaDnrHyPL1p4EHjYLi7	Charlie Puth	80
5IcR3N7QB1j6KBL8eImZ8m	ScHoolboy Q	70
6UE7nl9mha6s8z0wFQFIZ2	Robyn	58
64H8UqGLbJFHwKtGxiV8OP	THE ANXIETY	57
0hYxQe3AK5jBPCr5MumLHD	Sugarland	55
3AuMNF8rQAKOzjYppFNAoB	Kelly Rowland	66
4npEfmQ6YuiwW1GpUmaq3F	Ava Max	78
31W5EY0aAly4Qieq6OFu6I	A Boogie Wit da Hoodie	79
1Cs0zKBU1kc0i8ypK3B9ai	David Guetta	86
7keGfmQR4X5w0two1xKZ7d	Kungs	71
1MIVXf74SZHmTIp4V4paH4	Mabel	65
4fwuXg6XQHfdlOdmw36OHa	Paloma Faith	65
0MlOPi3zIDMVrfA9R04Fe3	American Authors	64
0FWzNDaEu9jdgcYTbcOa4F	3OH!3	60
4ON1ruy5ijE7ZPQthbrkgI	Burak Yeter	55
4ETSs924pXMzjIeD6E9b4u	Surfaces	65
7Ln80lUS6He07XvHI8qqHH	Arctic Monkeys	84
5Y5TRrQiqgUO4S36tzjIRZ	Timbaland	75
0QHgL1lAIqAw0HtD7YldmP	DJ Khaled	74
6bmlMHgSheBauioMgKv2tn	Powfu	67
6nS5roXSAGhTGr34W6n7Et	Disclosure	70
41MozSoPIsD1dJM0CLPjZF	BLACKPINK	83
2NhdGz9EDv2FeUw6udu2g1	The Wanted	63
0qk8MxMzgnfFECvDO3cc0X	Charlene Soraia	39
2iojnBLj0qIMiKPvVhLnsH	Trey Songz	67
4obzFoKoKRHIphyHzJ35G3	Becky G	77
56oDRnqbIiwx4mymNEv7dS	Lizzo	74
0DxeaLnv6SyYk2DOqkLO8c	MAGIC!	65
2wpJOPmf1TIOzrB9mzHifd	Scouting For Girls	53
6ydoSd3N2mwgwBHtF6K7eX	Calum Scott	74
5H4yInM5zmHqpKIoMNAx4r	Central Cee	82
5cj0lLjcoR7YOSnhnX0Po5	Doja Cat	86
6f4XkbvYlXMH0QgVRzW0sM	Waka Flocka Flame	64
1bT7m67vi78r2oqvxrP3X5	Naughty Boy	58
0X2BH1fck6amBIoJhDVmmJ	Ellie Goulding	78
6p5JxpTc7USNnBnLzctyd4	Phillip Phillips	59
73sIBHcqh3Z3NyqHKZ7FOL	Childish Gambino	77
3LpLGlgRS1IKPPwElnpW35	James Morrison	60
6TLwD7HPWuiOzvXEa3oCNe	Oliver Tree	72
0A0FS04o6zMoto8OKPsDwY	YG	72
61lyPtntblHJvA7FMMhi7E	Duke Dumont	63
4BxCuXFJrSWGi1KHcVqaU4	Kodaline	67
3YQKmKGau1PzlVlkL1iodx	Twenty One Pilots	78
5Pwc4xIPtQLFEnJriah9YJ	OneRepublic	81
2wY79sveU1sp5g7SokKOiI	Sam Smith	83
0B3N0ZINFWvizfa8bKiz4v	James TW	62
738wLrAtLtCtFOLvQBXOXp	Major Lazer	73
0hCNtLu0JehylgoiP8L4Gh	Nicki Minaj	86
3XHO7cRUPCLOr6jwp8vsx5	alt-J	68
1yxSLGMDHlW21z4YXirZDS	Black Eyed Peas	78
3TVXtAsR1Inumwj472S9r4	Drake	94
0lAWpj5szCSwM4rUMHYmrr	MÃ¥neskin	78
6fWVd57NKTalqvmjRd2t8Z	24kGoldn	70
6T5tfhQCknKG4UnH90qGnz	DNCE	67
6hyMWrxGBsOx6sWcVj1DqP	Sebastian Ingrosso	60
3iOvXCl6edW5Um0fXEBRXy	The xx	64
6XyY86QOPPrYVGvF9ch6wz	Linkin Park	83
6S2OmqARrzebs0tKUEyXyp	Demi Lovato	77
4phGZZrJZRo4ElhRtViYdl	Jason Mraz	71
6M2wZ9GZgrQXHCFfjv46we	Dua Lipa	86
5zctI4wO9XSKS8XwcnqEHk	Lil Mosey	67
3b8QkneNDz4JHKKKlLgYZg	Florida Georgia Line	73
7jVv8c5Fj3E9VhNjxT4snq	Lil Nas X	76
2WgfkM8S11vg4kxLgDY3F5	StarBoi3	50
0Y5tJX1MQlPlqiwlOH1tJY	Travis Scott	93
5BcAKTbp20cv7tC5VqPFoC	Macklemore & Ryan Lewis	72
5DYAABs8rkY9VhwtENoQCz	Gavin DeGraw	59
1VBflYyxBhnDc9uVib98rw	Icona Pop	65
5YGY8feqx7naU7z4HrwZM6	Miley Cyrus	85
74XFHRwlV6OrjEM0A2NCMF	Paramore	77
3nFkdlSjzX9mRTtwJOzDYB	JAY-Z	82
7pGyQZx9thVa8GxMBeXscB	K'NAAN	59
66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	87
6MDME20pz9RveH9rEXvrOM	Clean Bandit	72
28j8lBWDdDSHSSt5oPlsX2	ZHU	62
2tIP7SsRs7vjIcLrU85W8J	The Kid LAROI	78
23zg3TcAtWQy7J6upgbUnj	USHER	77
085pc2PYOi8bGKj0PNjekA	will.i.am	71
6S0dmVVn4udvppDhZIWxCr	Sean Kingston	68
7t51dSX8ZkKC7VoKRd0lME	Asaf Avidan	56
6MF9fzBmfXghAz953czmBC	Taio Cruz	67
4V8Sr092TqfHkfAA5fXXqG	Luis Fonsi	72
2l35CQqtYRh3d8ZIiBep4v	MKTO	64
1dfeR4HaWDbWqFHLkxsg1d	Queen	82
6ueGR6SWhUJfvEhqkvMsVs	Janelle MonÃ¡e	67
3906URNmNa1VCXEeiJ3DSH	Matt Cardle	29
5fahUm8t5c0GIdeTq0ZaG8	Otto Knows	59
2HcwFjNelS49kFbfvMxQYw	Robbie Williams	69
7n2wHs1TKAczGzO7Dd2rGr	Shawn Mendes	81
2gsggkzM5R49q6jpPvazou	Jessie J	69
1vCWHaC5f2uS3yhpwWbIA6	Avicii	79
0id62QV2SZZfvBn9xpmuCl	Aloe Blacc	63
6jJ0s89eD6GaHleKKya26X	Katy Perry	82
0C8ZW7ezQVs4URX5aX7Kqx	Selena Gomez	83
1mcTU81TzQhprhouKaTkpq	Rauw Alejandro	87
163tK9Wjr9P9DmM0AVK7lm	Lorde	74
2AsusXITU8P25dlRNhcAbG	Gotye	65
6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	88
3jNkaOXasoc7RsxdchvEVq	Chase & Status	67
3uwAm6vQy7kWPS2bciKWx9	girl in red	72
2txHhyCwHjUEpJjWrEyqyX	Tom Odell	73
181bsRPaVXVlUKXrxwZfHK	Megan Thee Stallion	75
360IAlyVv4PCEVjgyMZrxK	Miguel	77
1McMsnEElThX1knmY4oliG	Olivia Rodrigo	85
3whuHq0yGx60atvA2RCVRW	Olly Murs	63
3NPpFNZtSTHheNBaWC82rB	X Ambassadors	69
7ltDVBr6mKbRvohxheJ9h1	ROSALÃA	81
4q3ewBCX7sLwd24euuV69X	Bad Bunny	94
6ASri4ePR7RlsvIQgWPJpS	iann dior	70
01QTIT5P1pFP3QnnFSdsJf	Lupe Fiasco	64
5tKXB9uuebKE34yowVaU3C	Iyaz	63
4xFUf1FHVy696Q1JQZMTRj	Carrie Underwood	70
6DPYiyq5kWVQS4RGwxzPC7	Dr. Dre	78
7qG3b048QCHVRO5Pv1T5lw	Enrique Iglesias	75
3MZsBdqDrRTJihTHQrO6Dq	Joji	79
2ajhZ7EA6Dec0kaWiKCApF	Rizzle Kicks	49
2o5jDhtHVPhrJdv3cEQ99Z	TiÃ«sto	82
540vIaP2JwjQb9dm3aArA4	DJ Snake	76
0TnOYISbd1XYRBk9myaseg	Pitbull	81
7CajNmpbOovFoOoasH2HaY	Calvin Harris	84
1IueXOQyABrMOprrzwQJWN	Sigala	69
1dgdvbogmctybPrGEcnYf6	Route 94	55
6jTnHxhb6cDCaCu4rdvsQ0	Hot Chelle Rae	54
2W8yFh0Ga6Yf3jiayVxwkE	Dove Cameron	69
32WkQRZEVKSzVAAYqukAEA	Lady A	65
1KCSPY1glIKqW2TotWuXOR	P!nk	79
26T3LtbuGT1Fu9m0eRq5X3	Cage The Elephant	71
25u4wHJWxCA9vO0CzxAbK7	Lukas Graham	69
69GGBxA162lTqCwzJG5jLp	The Chainsmokers	78
0hEurMDQu99nJRq8pTxO14	John Mayer	75
4Ga1P7PMIsmqEZqhYZQgDo	Lil Tecca	76
0c173mlxpT3dSFRgMO8XPh	Big Sean	75
60d24wfXkVzDSfLS6hyCjZ	Martin Garrix	74
6vXTefBL93Dj5IqAWq6OTv	French Montana	72
0f5nVCcR06GX8Qikz0COtT	Omarion	59
12Chz98pHFMPJEknJQMWvI	Muse	73
7vk5e3vY1uw9plTHJAMwjN	Alan Walker	79
5pKCCKE2ajJHZ9KAiaK11H	Rihanna	87
1Xyo4u8uXC1ZmMpatF05PJ	The Weeknd	94
0H39MdGGX6dbnnQPt6NQkZ	SAINt JHN	67
2YZyLoL8N0Wb9xBt1NhZWg	Kendrick Lamar	86
1uU7g3DNSbsu0QjSEqZtEd	Masked Wolf	64
6sFIWsNpZYqfjUpaCgueju	Carly Rae Jepsen	72
0aeLcja6hKzb7Uz2ou7ulP	Noah And The Whale	49
2LIk90788K0zvyj2JJVwkJ	Jack Harlow	77
34v5MVKeQnIo0CWYMbbrPf	John Newman	67
3MdXrJWsbVzdn6fe5JYkSQ	Latto	85
4yvcSjfu4PC0CYQyLy4wSq	Glass Animals	74
3AQRLZ9PuTAozP28Skbq8V	The Script	71
2hlmm7s2ICUX0LVIhVFlZQ	Gunna	84
0du5cEVh5yTK9QJze8zA0C	Bruno Mars	86
75FnCoo4FBxH5K1Rrx0k5A	The Band Perry	54
6vWDO969PvNqNYHIOW5v0m	BeyoncÃ©	85
07YZf4WDAMNwqr4jfgOZ8y	Jason Derulo	77
4dpARuHxo51G3z768sgnrY	Adele	83
3mIj9lX2MWuHmhNCA7LSCW	The 1975	75
1uNFoZAHBGtllmzznpCI3s	Justin Bieber	87
3PhoLpVuITZKcymswpck5b	Elton John	81
0q8J3Yj810t5cpAYEJ7gxt	Duck Sauce	50
7iZtZyCzp3LItcw1wtPI3D	Rae Sremmurd	70
63MQldklfxkjYDoUE4Tppz	M83	69
6DIS6PRrLS3wbnZsf7vYic	WALK THE MOON	67
77SW9BnxLY8rJ0RciFqkHh	The Neighbourhood	81
0ZrpamOxcZybMHGg1AYtHP	Robin Thicke	61
00FQb4jTyendYWaN8pK0wa	Lana Del Rey	89
6l3HvQ5sa6mXTsMTB19rO5	J. Cole	84
3hteYQFiMFbJY7wS0xDymP	Gesaffelstein	71
7tYKF4w9nC0nq9CsPZTHyP	SZA	87
2EMAnMvWE2eb56ToJVfCWs	Bryson Tiller	77
4gzpq5DPGxSnKTe4SA8HAU	Coldplay	86
6Vh6UDWfu9PUSXSzAaB3CW	Example	56
06HL4z0CvFAxyc27GXpf02	Taylor Swift	100
5INjqkS1o8h1imAzPqGZBb	Tame Impala	78
2KsP6tYLJlTBvSUxnwlVWa	Mike Posner	68
1EeArivTpzLNCqubV95255	Cali Swag District	49
6PXS4YHDkKvl1wkIl4V8DL	Fetty Wap	68
7nDsS0l5ZAzMedVRKPP8F1	Ella Henderson	72
5nCi3BB41mBaMH9gfr6Su0	fun.	65
7o9Nl7K1Al6NNAHX6jn6iG	Travie McCoy	60
5xKp3UyavIBUsGy3DQdXeF	A Great Big World	59
1XLWox9w1Yvbodui0SRhUQ	StaySolidRocky	57
5he5w2lnU9x7JFhnwcekXX	Skrillex	75
21E3waRsmPlU7jZsS13rcj	Ne-Yo	77
6LuN9FCkKOj5PcnpouEgny	Khalid	82
2h93pZq0e7k5yf4dywlkpM	Frank Ocean	82
5j4HeCoUlzhfWtjAfM1acR	Stromae	69
4IWBUUAFIplrNtaOHcJPRM	James Arthur	80
6VxCmtR7S3yz4vnzsJqhSV	Sheppard	60
5L1lO4eRHmJ7a0Q6csE5cT	LISA	77
20JZFwl6HVl6yg8a4H3ZqK	Panic! At The Disco	75
0BmLNz4nSLfoWYW1cYsElL	Alexandra Stan	59
4fxd5Ee7UefO4CUXgwJ7IP	Giveon	75
2WX2uTcsvV5OnS0inACecP	Birdy	68
4ScCswdRlyA23odg9thgIO	Jess Glynne	70
5IH6FPUwQTxPSXurCrcIov	Alec Benjamin	74
2qxJFvFYMEDqd7ui6kSAcq	Zedd	73
6LqNN22kT3074XbTVUrhzX	Kesha	74
6r20qOqY7qDWI0PPTxVMlC	DJ Fresh	55
2gBjLmx6zQnFGQJCAQpRgw	Nelly	73
3hv9jJF3adDNsBSIQDqcjp	Mark Ronson	72
6prmLEyn4LfHlD9NnXWlf7	Adam Lambert	59
3KV3p5EY4AvKxOlhGHORLg	Jeremih	71
4Uc8Dsxct0oMqx0P6i60ea	Conan Gray	77
1aSxMhuvixZ8h9dK9jIDwL	Kate Bush	67
0RpddSzUHfncUWNJXKOsjy	Neon Trees	63
1HY2Jd0NmPuamShAr6KMms	Lady Gaga	83
4NHQUGzhtTLFvgF5SZesLK	Tove Lo	72
3vQ0GE3mI0dAaxIMYe5g7z	Paulo Londra	74
4dwdTW1Lfiq0cM8nBAqIIz	Of Monsters and Men	66
2VSHKHBTiXWplO8lxcnUC9	GAYLE	65
53XhwfbYqKCa1cC15pYq2q	Imagine Dragons	86
7gOdHgIoIKoe4i9Tta6qdD	Jonas Brothers	77
2feDdbD5araYcm6JhFHHw7	Labrinth	77
2Sqr0DXoaYABbjBo9HaMkM	Sara Bareilles	63
4AK6F7OLvEQ5QYCBNiQWHq	One Direction	82
5ndkK3dpZLKtBklKjxNQwT	B.o.B	71
5pUo3fmmHT8bhCyHE52hA6	Liam Payne	61
4tZwfgrHOc3mvqYlEYSvVi	Daft Punk	79
3ipn9JLAPI5GUEo4y4jcoi	Ludacris	74
6KImCVD70vtIoJWnq6nGn3	Harry Styles	85
55Aa2cqylxrFIXC767Z865	Lil Wayne	84
6TIYQ3jFPwQSRmorSezPxX	Machine Gun Kelly	75
5K4W6rqBFWDnAN6FQUkS6x	Kanye West	89
790FomKkXshlbRYZFtlgla	KAROL G	90
0eDvMgVFoNV3TpwtrVCoTj	Pop Smoke	79
7bXgB6jMjp9ATFy66eO08Z	Chris Brown	84
29PgYEggDV3cDP9QYTogwv	Carolina GaitÃ¡n - La Gaita	56
7HV2RI2qNug4EcQqLbCAKS	Keala Settle	61
4LEiUm1SRbFMgfqnQTwUbQ	Bon Iver	74
5y2Xq6xcjJb2jVM54GHK3t	John Legend	73
0Tob4H0FLtEONHU1MjpUEp	Tinie Tempah	64
1URnnhqYAYcrqrcwql10ft	21 Savage	88
7dGJo4pcD2V6oG8kP0tJRR	Eminem	88
4kYGAK2zu9EAomwj3hXkXy	JP Cooper	64
0jnsk9HBra6NMjO2oANoPY	Flo Rida	76
3Fl1V19tmjt57oBdxXKAjJ	Blueface	65
6JL8zeS1NmiOftqZTRgdTz	Meghan Trainor	75
246dkjvS1zLTtiykXe5h60	Post Malone	89
5WUlDfRSoLAfcVSX1WnrxN	Sia	81
6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	87
757aE44tKEUQEqRuT6GnEB	Roddy Ricch	76
4KkHjCe8ouh8C2P9LPoD4F	Yolanda Be Cool	51
3Nrfpe0tUJi4K4DXYWgMUX	BTS	87
5nLYd9ST4Cnwy6NHaCxbj8	CeeLo Green	63
137W8MRPWKqSmrBGDBFSop	Wiz Khalifa	79
536BYVgOnRky0xjsPT96zl	Two Door Cinema Club	67
4LLpKhyESsyAXpc4laK94U	Mac Miller	81
7FNnA9vBm6EKceENgCGRMb	Anitta	76
3DiDSECUqqY1AuBP8qtaIa	Alicia Keys	75
2dd5mrQZvg6SmahdgVKDzh	PSY	62
0p4nmQO2msCgU4IF37Wi3j	Avril Lavigne	73
4gwpcMTbLWtBUlOijbVpuu	Capital Cities	64
1GxkXlMwML1oSg5eLPiAz3	Michael BublÃ©	71
2ysnwxxNtSgbb9t1m2Ur4j	George Ezra	72
3sgFRtyBnxXD5ESfmbK4dl	LMFAO	65
716NhGYqD1jl2wI1Qkgq36	Bizarrap	83
31TPClRtHm23RisEBtV3X7	Justin Timberlake	78
\.


--
-- TOC entry 4879 (class 0 OID 75911)
-- Dependencies: 221
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (genre_id, genre_name) FROM stdin;
LdVObxEvZiuZuVSXueOZ1P	belgian pop
E5O6sd9pNHsoIo8A9iZ0fV	trap queen
j3YL54mLVZbG9bTgkALwQE	post-grunge
gFnsYxq1x22UUZsL9fWUnW	seattle hip hop
nIGGJGaPtlfLiaeQ0DUMhT	rock
ktrk3k6tCTZNNrlISwX5kO	trap latino
q7GOSyn2ukFdbVxwq8Gk9A	uk funky
MEqeqHl7UI8lyedJMux3Wj	southern hip hop
GlCMRz71ZgklFN1OnobcXU	hip hop
ILlTKd2YFAPwupxx14GkIA	moombahton
z98WlS2KpBloy4ohjZZA2G	country dawn
sE29JgBaVmIObx2DmVRiqf	indie rock
Da1EKMQQa8bTR2b82MY7ag	modern rock
cSaPAuw3Pbj9YYbPOwC9w1	k-rap
NO19etMNwImOzKIF1N87vH	pop nacional
VxQtETZVbYFskEUTsdsDKL	hip pop
2wkHFHGy2fJvAzKS8ppqgL	dance rock
g75PC7NSeFauMtdsPtkiby	downtempo
34YJrUJWsk5DlJx1LC4gF3	sad rap
7qOyvybcAUPfPJt4DD9cQT	complextro
WtrbZflTTOud8ZU8gY3iM3	old school atlanta hip hop
RajifVQECSHb83OFLQxkx7	political hip hop
XL1Ai6HyCV5TWOiifZ9kbE	shimmer pop
tLsmgA0UBLmbPx6Vo1V5hH	shiver pop
ufaJetRQmV06BtOolWkGQO	reggae fusion
DfGFE1USWx7GEiEFiGFsuE	progressive house
v3SyDno1YuSOKxHgott5IN	etherpop
WLZroBceQZFCG7ljpXflI1	pluggnb
ITUee9sTXyqtVUFSluX7Xd	chicago rap
jnszrK69fmB7DuSbBUYOcz	art pop
ONXFicyTiZTmut1iMLIfu9	german techno
x16TUa2BYHHDeUbZLhhtuR	houston rap
62G7OOtJTRdi1PryEXZShG	cali rap
9cvCd1Hdq7wVO4rypEPeCu	australian hip hop
2xqpPLoyyO6rnkbKwtr1WK	mississippi hip hop
HRReE04Frs6Y1KgpaKi5tr	adult standards
LfqiUsgYNyo5Dnlb6QxEQS	grime
AhaE5fYg9kfiPHde54Q6tD	rap conscient
XcNos4n1PLEv9wmF8e5vH2	kentucky hip hop
aVqVL6GHgXDeQA4Pq7us70	new orleans rap
AQJy0cICgcJ7OAwLkr6Mtr	indie poptimism
wm8hn89gVWDs3sSLr2K7Zu	canadian pop
KV11b7otLS9PvWDLTW8cAQ	canadian contemporary r&b
iDVo27DQcN9JLSI8enf6vi	indietronica
PrEEMD3yOE9Ek9UqhaJ1O3	latin viral pop
LQZm0woEpsP2lZtzqyfO3K	pop rap
1esd4m69Iex1apATbeolIi	singer-songwriter
vBfFTPAwlJfvsmpUnMp9PD	slowed and reverb
Na6i9qIZwUBjh0Ov9tLFw7	r&b en espanol
81ZV6b2eZnjKGZts41CQsW	uk contemporary r&b
BQktr5JJITJJZ5lgY6CYim	italian pop
yWuvJvZOJ5MIHTAGrUjl2l	jazz pop
zdy5aiERwBVLsCfk36RhuK	queens hip hop
YoRnYuRATplwTA2WHadVjS	east coast hip hop
FGhbxC5rW4SCZNdzy2Y6JK	alternative rock
U2YMYZk71WSt7QDHHl5BMx	viral pop
Ag6mEJFMRpkqeVkwTpdGdv	urban contemporary
8TjGGi59AnSWHKHUF6Y2GS	st louis rap
1tE04hUvWs276n65f6BXse	broadway
olqVcznfeC6c5LCW33m8Ix	electropop
1PMfLOqFsvN8tSveICzhNJ	australian pop
fXOuPUBgRaCtKUDTsPaWXN	electro trash
WsK8DfEcHbqETfIJ69RS1d	dirty south rap
vRFcSUhahCULB7h5aTdeRb	reggaeton
nHA0eOdA7YqGV1OmKAJV9i	swedish electropop
odvwbwzsetIHXknwT5HEJP	canadian hip hop
ZB3H6hTaQPKi1pfxVvOebG	glam rock
5Yr7onU6UVhG1VSU41Nm4r	modern alternative pop
OeQbml10ezBXw9Odwqv66c	afrofuturism
UrSGGyAt0d2pI5Lh7pnfNC	australian indie
RKGu0xs9uJF1u5W1psoj23	neo soul
o9GycCqBH9WmBqxLQBg3PA	melodic drill
gRUsub3KAT3LzKfepJ3wxC	french shoegaze
jCd9yAjgsHmP5egjlE33FJ	french synthpop
qy8fE1PrAelfZ29K13ZSEG	neo mellow
KJM3kNhtSdNbdMNGGf3d5h	g-house
MaMDqlKoEEwjYAqLjJQNMm	disco house
AY8O9R8iNRPBamB1tFght8	indie rock italiano
eQ963SlkrY8qwgmn93yBAt	detroit hip hop
c5D7GRT5IyOdGIkBhlplos	classic rock
pjcsFJvBfng7KmcXaglR0k	neo-psychedelic
24fGvv8QRXLovtu5VbP2gy	dark clubbing
8h1nry3IY96ZTSOwuHMUZR	uk pop
P4GV1oadwjhHeAQ7qKK3eQ	nu metal
RE12Ku7eAAd6lISO7oBoOh	gangster rap
Ch3LEqStHbk1TgsjjtyieY	dancefloor dnb
evoqUqYGvypPFnAVgc8Ehb	israeli rock
D5yLheUsT8zzsoVMJ4c4wR	australian psych
CgIfe4pLQAEvcyID6h5Ujr	neon pop punk
VvMSF3lVtekGjSLvYLngn6	colombian pop
1jReh01uA4uVM19jZTVyyt	electropowerpop
O4rL3gmxJZ1ubTEry7Dmqu	korean old school hip hop
Tz5h6Q9QPW1isVTdZqEzxz	dutch edm
YUW1dEljdN3HULeSkRiOef	bedroom soul
dObL99TGhq1tMKWObjafye	europop
paHyw6nLLQP1js37lYmvxD	r&b
TE6nPFmStCTQOAlbpYbDc5	neo-singer-songwriter
DinotCxIRVhJe6W4CDECJi	pop r&b
9w3uqSLrhbvdSfLQ57uLuU	urbano latino
RfaDa0ajCygXtBj37Ox8st	lilith
bWTeVmpTsiw5ttEVSETCOM	neo-synthpop
oo4zOZrByUfqReFuQ39mue	reggaeton colombiano
4BcJaCA3fGBwot6p3xC1Hn	conscious hip hop
uSZJVdMWfFSEGkfcmUTnn2	miami hip hop
IG4smdaVC84wz7gwPOEyG4	alt z
TaILWRKGSVMLBALGLgPgXg	alternative metal
KlPR5t4cPejE6UYRLskAtg	slap house
2ClyZecLJceYYdLli7c9Pa	singer-songwriter pop
7aiS44tLtJKjHKjsx14rP6	classic oklahoma country
bUhO3s169C99vASWosayYh	dfw rap
12XRUtBZVdLgcba8y2Be0o	british soul
ab16UTObfH5IybcL2217Cr	acoustic pop
6aEKX0GcqfCc38OkysSsSP	brooklyn drill
rPPWJB9c7yAToT7rFpgm2f	alternative hip hop
GcU1XuaOaeMu1kVMAphgXN	modern country rock
E5t7R5wCxfwLPsV2bBh4Au	talent show
iXxOZuR2UPHmLiW4EpPsWN	dream pop
jle8qY6Qb25nVjJZOsBYpb	trance
FS3g1jguh01C3PFkxEDLIK	baroque pop
mpui95W8Gpqp9pChPu2Kkw	chamber pop
69wc6lt5SwPMAvp4SToVqB	gauze pop
6Tvm7rH1PZAbcPbdSKK0AG	rap metal
E1dNffWSO2mKOroONjQTNr	pittsburgh rap
WjxdlV5uG0qXEqnazAq6D6	swedish synthpop
fHr2y58b2e2XiM9tGbGpvQ	swedish pop
WN8qrP0ZGTM6fYVliKUCYH	show tunes
CqvAnCq2v4Q0aMk9ytWTMp	progressive electro house
1WZCcFSbNtBETKdcflXSQo	melancholia
d51gUfq0plLEythN72HJoH	stomp and holler
Esk4OKC2M5LYTr1odMWEfo	sad lo-fi
lfnwzkeovyEIpy2q0s329x	sheffield indie
eMCIJFba7cLfOuPb7ZZIe7	filter house
UU8QVhTYWa1uxpC479zrDd	stomp pop
LpC51HwpGMjBuJsqrdk6PC	british singer-songwriter
DcNk8lp9KZ055xRuGYWXXR	k-pop
EDF5mqailn2C9hyqQXAcxd	country
HjEUIly1GABqcA3Zpn73vD	romanian pop
8mNfH1L6k6exhWHFjQdfNo	pop soul
pA6b3IJ3XfGvlhbFms2vpW	contemporary r&b
R2MjU4vXbep5wxegAoH4Ot	hip house
2LqnIQ8brNKkq5UpYasS3M	pop
WVAftOScguQs31GXAphyRU	idol
pjblhQJB45QunspXS6ZAOA	melodic rap
OMX31irZbRKPmRLaBNmWKa	danish pop
p347GOssFGeRsh2UDHcz0X	pop dance
m45QR6ueNTjHDukEXoYPJE	dutch house
RLwofC9qBR221ghUuoRgkS	big room
eWamSWFq3Eak5J9dE5SQIF	electronic trap
61Hf3FSCEBZj8KEw66ngAQ	puerto rican pop
EcsffyRILA6Ne7rauVMZLa	viral rap
LNGQsYWJ5Dx7TzYpr6M0gZ	scandipop
1MmI2gY2e2xo6j1GOwS52A	edm
4Bu7iQsKfKCrmqikvXowwd	lgbtq+ hip hop
NQeLsgsYpwYBX4aApn5Upx	mellow gold
YxOOM3R5eecR5nKXaAW0Xz	electro house
uGPcY5hn2lMGTL6wmWuN7l	metropopolis
PN43AI5RvpmbPGEmPLgM2m	brostep
1Qn6xdLSrQ7FLHkjyU0L4G	uk hip hop
KX8AIg1eUdlOT4NrGhk35P	dance pop
7OTFfc8tiNmSCXXbwPg1Yu	trap argentino
xDUH5ifXyXjeN2dLLknJ31	uk alternative pop
whRMEhdeuqs0iaMhxx5Smb	modern alternative rock
WbSSwtr2CJXi788eXDPYVu	black americana
MIrdXy4BMTyiqcSI4Mercu	norwegian indie
xJL83wL7lphcryKvMy8DWS	chill pop
KExNJCTjwIr6n4eWyeg9pe	west coast rap
fX7SJojTn2hVIqOsWA1oD0	hollywood
CFsePd5hHGWZWffCFWoBPh	pagode baiano
CQFwQ9CVGrmSl7IhgEPJxI	boy band
pKhTWOvK3Y6IeyDnci4KDu	pop punk
hCgKRkQTDZo2XHydo4eeOm	funk pop
SqiWV5CL9rWp0Z64AlSqGA	latin pop
xwwWaXTo5X4mEu2dYcD1EY	minnesota hip hop
t15dOujjAvsTDv7NLOJMdK	indie pop
rZCmSCdlE4mdC3rZnkQI8I	post-teen pop
bNWEjL606f7gSiJdxiC8St	deep underground hip hop
qs2C5lpYrx5TV82rT0llCf	bass house
2SLoZRdP1aI7I1QRPgMUGL	south carolina hip hop
SJAqPg5xR7LTmJQve15FSd	pixie
AkD0RYLVh3masDRAmNER7a	permanent wave
ukfygj1uRINXFakBs6xQ54	movie tunes
G6WqxqvB3oEBm7ti8lUvnS	lounge
206OTeUPpl8N13GNYmddps	funk rj
K87lZfJGvow9Fpz8PBG1aT	new jersey rap
T3bfHQGBZ3RAoPs2QTgsk3	pop emo
5wqS8b6SV9Y7XcLuJNFjpg	australian dance
53QoB8xceU8mWXCorSBO5W	northern irish indie
0eCk6UEHfgIEiOzO6c9QQq	indie folk
ovnmTdhAsBPp0XT7dVhu0r	australian house
Crp9K0upoGcJYeORjknaq4	mexican pop
xSyoi3lZsvwVVqvY9CA42l	garage rock
81l4y0ay9bqlEbuKU08K6W	g funk
Caw5218qJm8ANBXTb6oaDx	drum and bass
ME3FgRwQZx7XcxftUC8t53	candy pop
hs5A54oY9fUiTpBHf2HoDI	north carolina hip hop
3gLRg9YjdFQFgIxNPyrDXK	eau claire indie
K5fCj9fHKVxf4ddjn16JB8	country road
1cbJ3J9HHbAMLgkQbz7S4x	israeli pop
bLFepGDnAaTLmJYH7XesAc	rap latina
5R5IjnVj1CD9OQutNosuKN	bedroom pop
PJzZvwuDj5AjJMnlDNF4Rh	electro
L256hjbDPpaDSMH8aNiD9k	celtic rock
uS1hIY0naImftN7PbxANfv	k-pop girl group
CPgPn5DepKQAqStEunofjK	argentine hip hop
xJmSkIp1Q4Dl8pDzOfxVDx	uk dance
RJadUUEPQF39ZfoYVFNREl	country pop
onleIBJY94wm7JXtwDU6CS	nz pop
PXAZ3FP5VbdGWFE9pjGVlG	house
rk5tGP58hdo4pxkbh8q86J	pov: indie
n8VMb4nyFdFHY8Zz0ik1uE	contemporary country
RX4H4axTGaWLS4sZZ6vQWV	k-pop boy group
MJiWVH1dy7BR2XrCZS1Hpj	piano rock
syBGcuT9jWrPfBa7Vh1AsO	art rock
E4Q265b3EmpKqVQoCQ8ASc	irish rock
wrRGXCEQsvha5hG2uoKaD0	new wave pop
5x6O4mJLMhXsbI8aUucv2B	trap
xQwb2SWGETlHt8ipkkMjVx	pop venezolano
V7w4ohCNxr1Ddc3hKRHDWw	rap
8k2RTdUrFX1cbjDsRNERHV	barbadian pop
LopH6sALrbxJB9jXOAyIHZ	escape room
zRxPoppovbdFtrtQUZJMDT	atl hip hop
c3gWFzN7qEkecoe3Z6JSJI	ohio hip hop
WDMAEHHMMKmH3PDpnQVVog	irish pop
54N9baSXNUahxUCcikv3K6	alternative r&b
YfroEA85GouAxakcl98NId	folk-pop
KgpcnXPSTCyBJAMrvW40hu	punk blues
rFBROMeUWoNfNR6AwyhO2N	pop rock
\.


--
-- TOC entry 4878 (class 0 OID 75894)
-- Dependencies: 220
-- Data for Name: playlist_tracks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playlist_tracks (playlist_id, track_id) FROM stdin;
Z3d7ZvFizjczhqkQnb7RXg	7BqBn9nzAq8spo5e7cZ0dJ
Z3d7ZvFizjczhqkQnb7RXg	15JINEqzVMv3SvJTAXAKED
Z3d7ZvFizjczhqkQnb7RXg	4HlFJV71xXKIGcU3kRyttv
Z3d7ZvFizjczhqkQnb7RXg	2GYHyAoLWpkxLVa4oYTVko
Z3d7ZvFizjczhqkQnb7RXg	0HPD5WQqrq7wPWR7P7Dw1i
Z3d7ZvFizjczhqkQnb7RXg	4dTaAiV9xFFCxnPur9c9yL
Z3d7ZvFizjczhqkQnb7RXg	3ZdJffjzJWFimSQyxgGIxN
Z3d7ZvFizjczhqkQnb7RXg	3GBApU0NuzH4hKZq4NOSdA
Z3d7ZvFizjczhqkQnb7RXg	1bM50INir8voAkVoKuvEUI
Z3d7ZvFizjczhqkQnb7RXg	2M9ULmQwTaTGmAdXaXpfz5
Z3d7ZvFizjczhqkQnb7RXg	5jzKL4BDMClWqRguW5qZvh
Z3d7ZvFizjczhqkQnb7RXg	4TCL0qqKyqsMZml0G3M9IM
Z3d7ZvFizjczhqkQnb7RXg	5vlEg2fT4cFWAqU5QptIpQ
Z3d7ZvFizjczhqkQnb7RXg	6lV2MSQmRIkycDScNtrBXO
Z3d7ZvFizjczhqkQnb7RXg	4AYX69oFP3UOS1CFmV9UfO
Z3d7ZvFizjczhqkQnb7RXg	6DkXLzBQT7cwXmTyzAB1DJ
Z3d7ZvFizjczhqkQnb7RXg	1HHeOs6zRdF8Ck58easiAY
Z3d7ZvFizjczhqkQnb7RXg	5sra5UY6sD658OabHL3QtI
Z3d7ZvFizjczhqkQnb7RXg	6BdgtqiV3oXNqBikezwdvC
Z3d7ZvFizjczhqkQnb7RXg	7ElF5zxOwYP4qVSWVvse3W
Z3d7ZvFizjczhqkQnb7RXg	6wN4nT2qy3MQc098yL3Eu9
Z3d7ZvFizjczhqkQnb7RXg	4YYHgF9dWyVSor0GtrBzdf
Z3d7ZvFizjczhqkQnb7RXg	61LtVmmkGr8P9I2tSPvdpf
Z3d7ZvFizjczhqkQnb7RXg	0WCiI0ddWiu5F2kSHgfw5S
Z3d7ZvFizjczhqkQnb7RXg	2DHc2e5bBn4UzY0ENVFrUl
Z3d7ZvFizjczhqkQnb7RXg	4BycRneKmOs6MhYG9THsuX
Z3d7ZvFizjczhqkQnb7RXg	4u26EevCNXMhlvE1xFBJwX
Z3d7ZvFizjczhqkQnb7RXg	0oJMv049q8hEkes9w0L1J4
Z3d7ZvFizjczhqkQnb7RXg	7HacCTm33hZYYN8DXpCYuG
Z3d7ZvFizjczhqkQnb7RXg	0JcKdUGNR7zI4jJDLyYXbi
Z3d7ZvFizjczhqkQnb7RXg	030OCtLMrljNhp8OWHBWW3
Z3d7ZvFizjczhqkQnb7RXg	7hR5toSPEgwFZ78jfHdANM
Z3d7ZvFizjczhqkQnb7RXg	2r6DdaSbkbwoPzuK6NjLPn
Z3d7ZvFizjczhqkQnb7RXg	45O0tUN9Bh6LH4eNxQ07AT
Z3d7ZvFizjczhqkQnb7RXg	37dYAkMa4lzRCH6kDbMT1L
Z3d7ZvFizjczhqkQnb7RXg	7AqISujIaWcY3h5zrOqt5v
Z3d7ZvFizjczhqkQnb7RXg	1hBM2D1ULT3aeKuddSwPsK
Z3d7ZvFizjczhqkQnb7RXg	0dBW6ZsW8skfvoRfgeerBF
Z3d7ZvFizjczhqkQnb7RXg	07WEDHF2YwVgYuBugi2ECO
Z3d7ZvFizjczhqkQnb7RXg	4gs07VlJST4bdxGbBsXVue
Z3d7ZvFizjczhqkQnb7RXg	3uIGef7OSXkFdqxjFWn2o6
Z3d7ZvFizjczhqkQnb7RXg	2fQ6sBFWaLv2Gxos4igHLy
Z3d7ZvFizjczhqkQnb7RXg	1WtTLtofvcjQM3sXSMkDdX
Z3d7ZvFizjczhqkQnb7RXg	2rDwdvBma1O1eLzo29p2cr
Z3d7ZvFizjczhqkQnb7RXg	5BoIP8Eha5hwmRVURkC2Us
Z3d7ZvFizjczhqkQnb7RXg	17tDv8WA8IhqE8qzuQn707
Z3d7ZvFizjczhqkQnb7RXg	6KBYk8OFtod7brGuZ3Y67q
Z3d7ZvFizjczhqkQnb7RXg	41KPpw0EZCytxNkmEMJVgr
Z3d7ZvFizjczhqkQnb7RXg	1yK9LISg5uBOOW5bT2Wm0i
Z3d7ZvFizjczhqkQnb7RXg	3VA8T3rNy5V24AXxNK5u9E
Z3d7ZvFizjczhqkQnb7RXg	09ZcYBGFX16X8GMDrvqQwt
Z3d7ZvFizjczhqkQnb7RXg	7g13jf3zqlP5S68Voo5v9m
Z3d7ZvFizjczhqkQnb7RXg	6GgPsuz0HEO0nrO2T0QhDv
Z3d7ZvFizjczhqkQnb7RXg	0zREtnLmVnt8KUJZZbSdla
Z3d7ZvFizjczhqkQnb7RXg	2tNE4DP5nL85XUJv1glO0a
Z3d7ZvFizjczhqkQnb7RXg	5ZFVacinyPxz19eK2vTodL
Z3d7ZvFizjczhqkQnb7RXg	5e0dZqrrTaoj6AIL7VjnBM
Z3d7ZvFizjczhqkQnb7RXg	0XvjOhwCnXXFOSlBbV9jPN
Z3d7ZvFizjczhqkQnb7RXg	31zeLcKH2x3UCMHT75Gk5C
Z3d7ZvFizjczhqkQnb7RXg	6FSxwdN08PvzimGApFjRnY
wOvFE37RYJBq423MAkmUPr	1c8gk2PeTE04A1pIDH9YMk
wOvFE37RYJBq423MAkmUPr	7LcfRTgAVTs5pQGEQgUEzN
wOvFE37RYJBq423MAkmUPr	0IkKz2J93C94Ei4BvDop7P
wOvFE37RYJBq423MAkmUPr	4r6eNCsrZnQWJzzvFh4nlg
wOvFE37RYJBq423MAkmUPr	2tJulUYLDKOg9XrtVkMgcJ
wOvFE37RYJBq423MAkmUPr	0JXXNGljqupsJaZsgSbMZV
wOvFE37RYJBq423MAkmUPr	6nek1Nin9q48AVZcWs9e9D
wOvFE37RYJBq423MAkmUPr	1eyzqe2QqGZUmfcPZtrIyt
wOvFE37RYJBq423MAkmUPr	5Qy6a5KzM4XlRxsNcGYhgH
wOvFE37RYJBq423MAkmUPr	4RL77hMWUq35NYnPLXBpih
wOvFE37RYJBq423MAkmUPr	3hsmbFKT5Cujb5GQjqEU39
wOvFE37RYJBq423MAkmUPr	6DkXLzBQT7cwXmTyzAB1DJ
wOvFE37RYJBq423MAkmUPr	3LUWWox8YYykohBbHUrrxd
wOvFE37RYJBq423MAkmUPr	2U8g9wVcUu9wsg6i7sFSv8
wOvFE37RYJBq423MAkmUPr	2i0AUcEnsDm3dsqLrFWUCq
wOvFE37RYJBq423MAkmUPr	4NTWZqvfQTlOMitlVn6tew
wOvFE37RYJBq423MAkmUPr	0aBKFfdyOD1Ttvgv0cfjjJ
wOvFE37RYJBq423MAkmUPr	608a1wIsSd5KzMEqm1O7w3
wOvFE37RYJBq423MAkmUPr	70ATm56tH7OrQ1zurYssz0
wOvFE37RYJBq423MAkmUPr	16Of7eeW44kt0a1M0nitHM
wOvFE37RYJBq423MAkmUPr	4fINc8dnfcz7AdhFYVA4i7
wOvFE37RYJBq423MAkmUPr	6r2BECwMgEoRb5yLfp0Hca
wOvFE37RYJBq423MAkmUPr	3pYDZTJM2tVBUhIRifWVzI
wOvFE37RYJBq423MAkmUPr	2OXidlnDThZR3zf36k6DVL
wOvFE37RYJBq423MAkmUPr	2TUzU4IkfH8kcvY2MUlsd2
wOvFE37RYJBq423MAkmUPr	1r3myKmjWoOqRip99CmSj1
wOvFE37RYJBq423MAkmUPr	1PAYgOjp1c9rrZ2kVQg2vN
wOvFE37RYJBq423MAkmUPr	53DB6LJV9B8sz0p1s6tlGS
wOvFE37RYJBq423MAkmUPr	36cmM3MBMWWCFIiQ90U4J8
wOvFE37RYJBq423MAkmUPr	04OxTCLGgDKfO0MMA2lcxv
wOvFE37RYJBq423MAkmUPr	5E6CDAxnBqc9V9Y6t5wTUE
wOvFE37RYJBq423MAkmUPr	1f8UCzB3RqIgNkW7QIiIeP
wOvFE37RYJBq423MAkmUPr	3SxiAdI8dP9AaaEz1Z24mn
wOvFE37RYJBq423MAkmUPr	0IF7bHzCXCZoKNog5vBC4g
wOvFE37RYJBq423MAkmUPr	1Fxp4LBWsNC58NwnGAXJld
wOvFE37RYJBq423MAkmUPr	35KiiILklye1JRRctaLUb4
wOvFE37RYJBq423MAkmUPr	3FrX3mx8qq7SZX2NYbzDoj
wOvFE37RYJBq423MAkmUPr	6y468DyY1V67RBNCwzrMrC
wOvFE37RYJBq423MAkmUPr	7mdNKXxia7AeSuJqjjA2rb
hYKylhpPiH1VPodagRTNzu	3w3y8KPTfNeOKPiqUTakBh
hYKylhpPiH1VPodagRTNzu	3TGRqZ0a2l1LRblBkJoaDx
hYKylhpPiH1VPodagRTNzu	7a86XRg84qjasly9f6bPSD
hYKylhpPiH1VPodagRTNzu	1z9kQ14XBSN0r2v6fx4IdG
hYKylhpPiH1VPodagRTNzu	4cluDES4hQEUhmXj6TXkSo
hYKylhpPiH1VPodagRTNzu	6nek1Nin9q48AVZcWs9e9D
hYKylhpPiH1VPodagRTNzu	2V65y3PX4DkRhy1djlxd9p
hYKylhpPiH1VPodagRTNzu	1gihuPhrLraKYrJMAEONyc
hYKylhpPiH1VPodagRTNzu	6VObnIkLVruX4UVyxWhlqm
hYKylhpPiH1VPodagRTNzu	6lanRgr6wXibZr8KgzXxBl
hYKylhpPiH1VPodagRTNzu	5UqCQaDshqbIk3pkhy4Pjg
hYKylhpPiH1VPodagRTNzu	2iUmqdfGZcHIhS3b9E9EWq
hYKylhpPiH1VPodagRTNzu	6FB3v4YcR57y4tXFcdxI1E
hYKylhpPiH1VPodagRTNzu	0U10zFw4GlBacOy9VDGfGL
hYKylhpPiH1VPodagRTNzu	0KAiuUOrLTIkzkpfpn9jb9
hYKylhpPiH1VPodagRTNzu	1NpW5kyvO4XrNJ3rnfcNy3
hYKylhpPiH1VPodagRTNzu	1auxYwYrFRqZP7t3s7w4um
hYKylhpPiH1VPodagRTNzu	4wCmqSrbyCgxEXROQE6vtV
hYKylhpPiH1VPodagRTNzu	4Kz4RdRCceaA9VgTqBhBfa
hYKylhpPiH1VPodagRTNzu	1oHNvJVbFkexQc0BpQp7Y4
hYKylhpPiH1VPodagRTNzu	7oVEtyuv9NBmnytsCIsY5I
hYKylhpPiH1VPodagRTNzu	6s8nHXTJVqFjXE4yVZPDHR
hYKylhpPiH1VPodagRTNzu	1nZzRJbFvCEct3uzu04ZoL
hYKylhpPiH1VPodagRTNzu	03UrZgTINDqvnUMbbIMhql
hYKylhpPiH1VPodagRTNzu	0TAmnCzOtqRfvA38DDLTjj
hYKylhpPiH1VPodagRTNzu	56sxN1yKg1dgOZXBcAHkJG
hYKylhpPiH1VPodagRTNzu	4sOX1nhpKwFWPvoMMExi3q
hYKylhpPiH1VPodagRTNzu	3n69hLUdIsSa1WlRmjMZlW
hYKylhpPiH1VPodagRTNzu	3tyPOhuVnt5zd5kGfxbCyL
hYKylhpPiH1VPodagRTNzu	6Vh03bkEfXqekWp7Y1UBRb
hYKylhpPiH1VPodagRTNzu	4qikXelSRKvoCqFcHLB2H2
hYKylhpPiH1VPodagRTNzu	3oL3XRtkP1WVbMxf7dtTdu
hYKylhpPiH1VPodagRTNzu	53QF56cjZA9RTuuMZDrSA6
hYKylhpPiH1VPodagRTNzu	4P0osvTXoSYZZC2n8IFH3c
hYKylhpPiH1VPodagRTNzu	1DunhgeZSEgWiIYbHqXl0c
hYKylhpPiH1VPodagRTNzu	1EAgPzRbK9YmdOESSMUm6P
hYKylhpPiH1VPodagRTNzu	6HZ9VeI5IRFCNQLXhpF4bq
hYKylhpPiH1VPodagRTNzu	3sP3c86WFjOzHHnbhhZcLA
hYKylhpPiH1VPodagRTNzu	6VRhkROS2SZHGlp0pxndbJ
hYKylhpPiH1VPodagRTNzu	0lHAMNU8RGiIObScrsRgmP
hYKylhpPiH1VPodagRTNzu	4HXOBjwv2RnLpGG4xWOO6N
hYKylhpPiH1VPodagRTNzu	2sEk5R8ErGIFxbZ7rX6S2S
hYKylhpPiH1VPodagRTNzu	6KuHjfXHkfnIjdmcIvt9r0
hYKylhpPiH1VPodagRTNzu	6t6oULCRS6hnI7rm0h5gwl
hYKylhpPiH1VPodagRTNzu	5g7rJvWYVrloJZwKiShqlS
hYKylhpPiH1VPodagRTNzu	5ujh1I7NZH5agbwf7Hp8Hc
hYKylhpPiH1VPodagRTNzu	0RUGuh2uSNFJpGMSsD1F5C
hYKylhpPiH1VPodagRTNzu	3WD91HQDBIavSapet3ZpjG
hYKylhpPiH1VPodagRTNzu	25cUhiAod71TIQSNicOaW3
hYKylhpPiH1VPodagRTNzu	5NlFXQ0si6U87gXs6hq81B
hYKylhpPiH1VPodagRTNzu	2EcsgXlxz99UMDSPg5T8RF
hYKylhpPiH1VPodagRTNzu	4kte3OcW800TPvOVgrLLj8
hYKylhpPiH1VPodagRTNzu	68rcszAg5pbVaXVvR7LFNh
hYKylhpPiH1VPodagRTNzu	5JLv62qFIS1DR3zGEcApRt
hYKylhpPiH1VPodagRTNzu	4b4c0oH7PtrPsI86drzgFs
hYKylhpPiH1VPodagRTNzu	439TlnnznSiBbQbgXiBqAd
hYKylhpPiH1VPodagRTNzu	0MOiv7WTXCqvm89lVCf9C8
hYKylhpPiH1VPodagRTNzu	0c4IEciLCDdXEhhKxj4ThA
hYKylhpPiH1VPodagRTNzu	5wEreUfwxZxWnEol61ulIi
hYKylhpPiH1VPodagRTNzu	2NniAhAtkRACaMeYt48xlD
hYKylhpPiH1VPodagRTNzu	6j7hih15xG2cdYwIJnQXsq
hYKylhpPiH1VPodagRTNzu	06h3McKzmxS8Bx58USHiMq
hYKylhpPiH1VPodagRTNzu	0obBFrPYkSoBJbvHfUIhkv
hYKylhpPiH1VPodagRTNzu	0ZyfiFudK9Si2n2G9RkiWj
hYKylhpPiH1VPodagRTNzu	78JKJfKsqgeBDBF58gv1SF
hYKylhpPiH1VPodagRTNzu	7B1Dl3tXqySkB8OPEwVvSu
hYKylhpPiH1VPodagRTNzu	28GUjBGqZVcAV4PHSYzkj2
hYKylhpPiH1VPodagRTNzu	5kcE7pp02ezLZaUbbMv3Iq
hYKylhpPiH1VPodagRTNzu	1RMRkCn07y2xtBip9DzwmC
hYKylhpPiH1VPodagRTNzu	3zsRP8rH1kaIAo9fmiP4El
hYKylhpPiH1VPodagRTNzu	0vFMQi8ZnOM2y8cuReZTZ2
hYKylhpPiH1VPodagRTNzu	2L7rZWg9RLxIwnysmxm4xk
hYKylhpPiH1VPodagRTNzu	3e0yTP5trHBBVvV32jwXqF
h9t7HfmUClwEKkUc7f34jH	4rHZZAmHpZrA3iH5zx8frV
h9t7HfmUClwEKkUc7f34jH	5PUvinSo4MNqW7vmomGRS7
h9t7HfmUClwEKkUc7f34jH	2dLLR6qlu5UJ5gk0dKz0h3
h9t7HfmUClwEKkUc7f34jH	2QjOHCTQ1Jl3zawyYOpxh6
h9t7HfmUClwEKkUc7f34jH	3JvKfv6T31zO0ini8iNItO
h9t7HfmUClwEKkUc7f34jH	3w3y8KPTfNeOKPiqUTakBh
h9t7HfmUClwEKkUc7f34jH	0nrRP2bk19rLc0orkWPQk2
h9t7HfmUClwEKkUc7f34jH	5FVd6KXrgO9B3JPmC8OPst
h9t7HfmUClwEKkUc7f34jH	6Z8R6UsFuGXGtiIxiD8ISb
h9t7HfmUClwEKkUc7f34jH	4G8gkOterJn0Ywt6uhqbhp
h9t7HfmUClwEKkUc7f34jH	0nJW01T7XtvILxQgC5J7Wh
h9t7HfmUClwEKkUc7f34jH	2XHzzp1j4IfTNp1FTn7YFg
h9t7HfmUClwEKkUc7f34jH	1mKXFLRA179hdOWQBwUk9e
h9t7HfmUClwEKkUc7f34jH	1yjY7rpaAQvKwpdUliHx0d
h9t7HfmUClwEKkUc7f34jH	3bidbhpOYeV4knp8AIu8Xn
h9t7HfmUClwEKkUc7f34jH	2Foc5Q5nqNiosCNqttzHof
h9t7HfmUClwEKkUc7f34jH	086myS9r57YsLbJpU0TgK9
h9t7HfmUClwEKkUc7f34jH	6lanRgr6wXibZr8KgzXxBl
h9t7HfmUClwEKkUc7f34jH	190jyVPHYjAqEaOGmMzdyk
h9t7HfmUClwEKkUc7f34jH	2vwlzO0Qp8kfEtzTsCXfyE
h9t7HfmUClwEKkUc7f34jH	55h7vJchibLdUkxdlX3fK7
h9t7HfmUClwEKkUc7f34jH	0NlGoUyOJSuSHmngoibVAs
h9t7HfmUClwEKkUc7f34jH	2ihCaVdNZmnHZWt0fvAM7B
h9t7HfmUClwEKkUc7f34jH	6CjtS2JZH9RkDz5UVInsa9
h9t7HfmUClwEKkUc7f34jH	6FB3v4YcR57y4tXFcdxI1E
h9t7HfmUClwEKkUc7f34jH	5cc9Zbfp9u10sfJeKZ3h16
h9t7HfmUClwEKkUc7f34jH	5CMjjywI0eZMixPeqNd75R
h9t7HfmUClwEKkUc7f34jH	5DI9jxTHrEiFAhStG7VA8E
h9t7HfmUClwEKkUc7f34jH	0qwcGscxUHGZTgq0zcaqk1
h9t7HfmUClwEKkUc7f34jH	0S4RKPbRDA72tvKwVdXQqe
h9t7HfmUClwEKkUc7f34jH	0mvkwaZMP2gAy2ApQLtZRv
h9t7HfmUClwEKkUc7f34jH	1KtD0xaLAikgIt5tPbteZQ
h9t7HfmUClwEKkUc7f34jH	5jyUBKpmaH670zrXrE0wmO
h9t7HfmUClwEKkUc7f34jH	6KkyuDhrEhR5nJVKtv9mCf
h9t7HfmUClwEKkUc7f34jH	3Tu7uWBecS6GsLsL8UONKn
h9t7HfmUClwEKkUc7f34jH	01TuObJVd7owWchVRuQbQw
h9t7HfmUClwEKkUc7f34jH	5VSCgNlSmTV2Yq5lB40Eaw
h9t7HfmUClwEKkUc7f34jH	2QD4C6RRHgRNRAyrfnoeAo
h9t7HfmUClwEKkUc7f34jH	1oHxIPqJyvAYHy0PVrDU98
h9t7HfmUClwEKkUc7f34jH	1zVhMuH7agsRe6XkljIY4U
h9t7HfmUClwEKkUc7f34jH	5zdkUzguZYAfBH9fnWn3Zl
h9t7HfmUClwEKkUc7f34jH	5FljCWR0cys07PQ9277GTz
h9t7HfmUClwEKkUc7f34jH	5BhsEd82G0Mnim0IUH6xkT
h9t7HfmUClwEKkUc7f34jH	0s0JMUkb2WCxIJsRB3G7Hd
h9t7HfmUClwEKkUc7f34jH	52gvlDnre9craz9dKGObp8
h9t7HfmUClwEKkUc7f34jH	5vL0yvddknhGj7IrBc6UTj
h9t7HfmUClwEKkUc7f34jH	2FV7Exjr70J652JcGucCtE
KUBSaE6ulYu49hAg7vmNAR	5O2P9iiztwhomNh8xkR9lJ
KUBSaE6ulYu49hAg7vmNAR	2tpWsVSb9UEmDRxAl1zhX1
KUBSaE6ulYu49hAg7vmNAR	0FDzzruyVECATHXKHFs9eJ
KUBSaE6ulYu49hAg7vmNAR	1HNkqx9Ahdgi1Ixy2xkKkL
KUBSaE6ulYu49hAg7vmNAR	3U4isOIWM3VvDubwSI3y7a
KUBSaE6ulYu49hAg7vmNAR	7795WJLVKJoAyVoOtCWqXN
KUBSaE6ulYu49hAg7vmNAR	4gbVRS8gloEluzf0GzDOFc
KUBSaE6ulYu49hAg7vmNAR	6YUTL4dYpB9xZO5qExPf05
KUBSaE6ulYu49hAg7vmNAR	3cHyrEgdyYRjgJKSOiOtcS
KUBSaE6ulYu49hAg7vmNAR	4nVBt6MZDDP6tRVdQTgxJg
KUBSaE6ulYu49hAg7vmNAR	6RtPijgfPKROxEzTHNRiDp
KUBSaE6ulYu49hAg7vmNAR	62ke5zFUJN6RvtXZgVH0F8
KUBSaE6ulYu49hAg7vmNAR	34gCuhDGsG4bRPIf9bb02f
KUBSaE6ulYu49hAg7vmNAR	5Nm9ERjJZ5oyfXZTECKmRt
KUBSaE6ulYu49hAg7vmNAR	6FE2iI43OZnszFLuLtvvmg
KUBSaE6ulYu49hAg7vmNAR	2iuZJX9X9P0GKaE93xcPjk
KUBSaE6ulYu49hAg7vmNAR	60nZcImufyMA1MKQY3dcCH
KUBSaE6ulYu49hAg7vmNAR	2ixsaeFioXJmMgkkbd4uj1
KUBSaE6ulYu49hAg7vmNAR	5Hroj5K7vLpIG4FNCRIjbP
KUBSaE6ulYu49hAg7vmNAR	2Bs4jQEGMycglOfWPBqrVG
KUBSaE6ulYu49hAg7vmNAR	0puf9yIluy9W0vpMEUoAnN
KUBSaE6ulYu49hAg7vmNAR	7vS3Y0IKjde7Xg85LWIEdP
KUBSaE6ulYu49hAg7vmNAR	4N1MFKjziFHH4IS3RYYUrU
KUBSaE6ulYu49hAg7vmNAR	5lF0pHbsJ0QqyIrLweHJPW
KUBSaE6ulYu49hAg7vmNAR	5jE48hhRu8E6zBDPRSkEq7
KUBSaE6ulYu49hAg7vmNAR	5BrTUo0xP1wKXLJWUaGFtk
KUBSaE6ulYu49hAg7vmNAR	14OxJlLdcHNpgsm4DRwDOB
KUBSaE6ulYu49hAg7vmNAR	6Vc5wAMmXdKIAM7WUoEb7N
KUBSaE6ulYu49hAg7vmNAR	0Dc7J9VPV4eOInoxUiZrsL
KUBSaE6ulYu49hAg7vmNAR	5KONnBIQ9LqCxyeSPin26k
KUBSaE6ulYu49hAg7vmNAR	5BJSZocnCeSNeYMj3iVqM7
KUBSaE6ulYu49hAg7vmNAR	7m3povhdMDLZwuEKak0l0n
KUBSaE6ulYu49hAg7vmNAR	39lS97papXAI72StGRtZBo
KUBSaE6ulYu49hAg7vmNAR	2GQEM9JuHu30sGFvRYeCxz
KUBSaE6ulYu49hAg7vmNAR	69gQgkobVW8bWjoCjBYQUd
KUBSaE6ulYu49hAg7vmNAR	1fu5IQSRgPxJL2OTP7FVLW
KUBSaE6ulYu49hAg7vmNAR	2dRvMEW4EwySxRUtEamSfG
KUBSaE6ulYu49hAg7vmNAR	2stPxcgjdSImK7Gizl8ZUN
KUBSaE6ulYu49hAg7vmNAR	2sLwPnIP3CUVmIuHranJZU
KUBSaE6ulYu49hAg7vmNAR	4z7gh3aIZV9arbL9jJSc5J
KUBSaE6ulYu49hAg7vmNAR	3nB82yGjtbQFSU0JLAwLRH
KUBSaE6ulYu49hAg7vmNAR	6p5abLu89ZSSpRQnbK9Wqs
9wnrC2T34VLxtL7vdC8hVE	32OlwWuMpZ6b0aN2RZOeMS
9wnrC2T34VLxtL7vdC8hVE	34gCuhDGsG4bRPIf9bb02f
9wnrC2T34VLxtL7vdC8hVE	2JzZzZUQj3Qff7wapcbKjc
9wnrC2T34VLxtL7vdC8hVE	4B0JvthVoAAuygILe3n4Bs
9wnrC2T34VLxtL7vdC8hVE	1Lim1Py7xBgbAkAys3AGAG
9wnrC2T34VLxtL7vdC8hVE	2PIvq1pGrUjY007X5y1UpM
9wnrC2T34VLxtL7vdC8hVE	3zHq9ouUJQFQRf3cm1rRLu
9wnrC2T34VLxtL7vdC8hVE	0ct6r3EGTcMLPtrXHDvVjc
9wnrC2T34VLxtL7vdC8hVE	6K4t31amVTZDgR3sKmwUJJ
9wnrC2T34VLxtL7vdC8hVE	5E30LdtzQTGqRvNd7l6kG5
9wnrC2T34VLxtL7vdC8hVE	7aXuop4Qambx5Oi3ynsKQr
9wnrC2T34VLxtL7vdC8hVE	19cL3SOKpwnwoKkII7U3Wh
9wnrC2T34VLxtL7vdC8hVE	5s7xgzXtmY4gMjeSlgisjy
9wnrC2T34VLxtL7vdC8hVE	1JDIArrcepzWDTAWXdGYmP
9wnrC2T34VLxtL7vdC8hVE	2S5LNtRVRPbXk01yRQ14sZ
9wnrC2T34VLxtL7vdC8hVE	1WoOzgvz6CgH4pX6a1RKGp
dRZrPqTJ2iw75iSpHG7KnI	7MXVkk9YMctZqd1Srtv4MB
dRZrPqTJ2iw75iSpHG7KnI	1zi7xx7UVEFkmKfv06H8x0
dRZrPqTJ2iw75iSpHG7KnI	50kpGaPAhYJ3sGmk6vplg0
dRZrPqTJ2iw75iSpHG7KnI	7BKLCZ1jbUBVqRi2FVlTVw
dRZrPqTJ2iw75iSpHG7KnI	62PaSfnXSMyLshYJrlTuL3
dRZrPqTJ2iw75iSpHG7KnI	3xKsf9qdS1CyvXSMEid6g8
dRZrPqTJ2iw75iSpHG7KnI	3QGsuHI8jO1Rx4JWLUh9jd
dRZrPqTJ2iw75iSpHG7KnI	6b3b7lILUJqXcp6w9wNQSm
dRZrPqTJ2iw75iSpHG7KnI	0lYBSQXN6rCTvUZvg9S0lU
dRZrPqTJ2iw75iSpHG7KnI	72TFWvU3wUYdUuxejTTIzt
dRZrPqTJ2iw75iSpHG7KnI	2Z8WuEywRWYTKe1NybPQEW
dRZrPqTJ2iw75iSpHG7KnI	09CtPGIpYB4BrO8qb1RGsF
dRZrPqTJ2iw75iSpHG7KnI	5kqIPrATaCc2LqxVWzQGbk
dRZrPqTJ2iw75iSpHG7KnI	3RiPr603aXAoi4GHyXx0uy
dRZrPqTJ2iw75iSpHG7KnI	0azC730Exh71aQlOt9Zj3y
dRZrPqTJ2iw75iSpHG7KnI	3pXF1nA74528Edde4of9CC
dRZrPqTJ2iw75iSpHG7KnI	76hfruVvmfQbw0eYn1nmeC
dRZrPqTJ2iw75iSpHG7KnI	4pAl7FkDMNBsjykPXo91B3
dRZrPqTJ2iw75iSpHG7KnI	1i1fxkWeaMmKEB4T7zqbzK
dRZrPqTJ2iw75iSpHG7KnI	6i0V12jOa3mr6uu4WYhUBr
dRZrPqTJ2iw75iSpHG7KnI	23L5CiUhw2jV1OIMwthR3S
dRZrPqTJ2iw75iSpHG7KnI	2BOqDYLOJBiMOXShCV1neZ
dRZrPqTJ2iw75iSpHG7KnI	698ItKASDavgwZ3WjaWjtz
dRZrPqTJ2iw75iSpHG7KnI	0vbtURX4qv1l7besfwmnD8
dRZrPqTJ2iw75iSpHG7KnI	0y60itmpH0aPKsFiGxmtnh
dRZrPqTJ2iw75iSpHG7KnI	0VhgEqMTNZwYL1ARDLLNCX
dRZrPqTJ2iw75iSpHG7KnI	1A8j067qyiNwQnZT0bzUpZ
dRZrPqTJ2iw75iSpHG7KnI	3O8NlPh2LByMU9lSRSHedm
dRZrPqTJ2iw75iSpHG7KnI	0t7fVeEJxO2Xi4H2K5Svc9
dRZrPqTJ2iw75iSpHG7KnI	7lGKEWMXVWWTt3X71Bv44I
dRZrPqTJ2iw75iSpHG7KnI	2GyA33q5rti5IxkMQemRDH
dRZrPqTJ2iw75iSpHG7KnI	0TXNKTzawI6VgLoA9UauRp
dRZrPqTJ2iw75iSpHG7KnI	5n0CTysih20NYdT2S0Wpe8
dRZrPqTJ2iw75iSpHG7KnI	7EVk9tRb6beJLTHrg6AkY9
dRZrPqTJ2iw75iSpHG7KnI	27GmP9AWRs744SzKcpJsTZ
dRZrPqTJ2iw75iSpHG7KnI	5hc71nKsUgtwQ3z52KEKQk
LgCTGYUwup3J1TSMRyObZA	7qiZfU4dY1lWllzX7mPBI3
LgCTGYUwup3J1TSMRyObZA	0pqnGHJpmpxLKifKRmU6WP
LgCTGYUwup3J1TSMRyObZA	6habFhsOp2NvshLv26DqMb
LgCTGYUwup3J1TSMRyObZA	1PSBzsahR2AKwLJgx8ehBj
LgCTGYUwup3J1TSMRyObZA	5knuzwU65gJK7IF5yJsuaW
LgCTGYUwup3J1TSMRyObZA	1rfofaqEpACxVEHIZBJe6W
LgCTGYUwup3J1TSMRyObZA	1zB4vmk8tFRmM9UULNzbLB
LgCTGYUwup3J1TSMRyObZA	1nueTG77MzNkJTKQ0ZdGzT
LgCTGYUwup3J1TSMRyObZA	0KKkJNfGyhkQ5aFogxQAPU
LgCTGYUwup3J1TSMRyObZA	0tgVpDi06FyKpA1z0VMD4v
LgCTGYUwup3J1TSMRyObZA	7JJmb5XwzOO8jgpou264Ml
LgCTGYUwup3J1TSMRyObZA	5uCax9HTNlzGybIStD3vDh
LgCTGYUwup3J1TSMRyObZA	5mCPDVBb16L4XQwDdbRUpz
LgCTGYUwup3J1TSMRyObZA	6gBFPUFcJLzWGx4lenP6h2
LgCTGYUwup3J1TSMRyObZA	1mXVgsBdtIVeCLJnSnmtdV
LgCTGYUwup3J1TSMRyObZA	1P17dC1amhFzptugyAO7Il
LgCTGYUwup3J1TSMRyObZA	7KXjTSCq5nL1LoYtL7XAwS
LgCTGYUwup3J1TSMRyObZA	3B54sVLJ402zGa6Xm4YGNe
LgCTGYUwup3J1TSMRyObZA	5oO3drDxtziYU2H1X23ZIp
LgCTGYUwup3J1TSMRyObZA	0jdny0dhgjUwoIp5GkqEaA
LgCTGYUwup3J1TSMRyObZA	0zbzrhfVS9S2TszW3wLQZ7
LgCTGYUwup3J1TSMRyObZA	0SGkqnVQo9KPytSri1H6cF
LgCTGYUwup3J1TSMRyObZA	29JrmE89KgRyCxBIzq2Ocw
LgCTGYUwup3J1TSMRyObZA	45XhKYRRkyeqoW3teSOkCM
Jp4YMIf936KasPLNEymvB3	2qT1uLXPVPzGgFOx4jtEuo
Jp4YMIf936KasPLNEymvB3	0u2P5u6lvoDfwTYjAADbn4
Jp4YMIf936KasPLNEymvB3	7ef4DlsgrMEH11cDZd32M6
Jp4YMIf936KasPLNEymvB3	6NFyWDv5CjfwuzoCkw47Xf
Jp4YMIf936KasPLNEymvB3	5OCJzvD7sykQEKHH7qAC3C
Jp4YMIf936KasPLNEymvB3	6DCZcSspjsKoFjzjrWoCdn
Jp4YMIf936KasPLNEymvB3	2xLMifQCjDGFmkHkpNLD9h
Jp4YMIf936KasPLNEymvB3	0e7ipj03S05BNilyu5bRzt
Jp4YMIf936KasPLNEymvB3	6IPwKM3fUUzlElbvKw2sKl
Jp4YMIf936KasPLNEymvB3	3GCdLUSnKSMJhs4Tj6CV3s
Jp4YMIf936KasPLNEymvB3	58kZ9spgxmlEznXGu6FPdQ
Jp4YMIf936KasPLNEymvB3	4EAV2cKiqKP5UPZmY6dejk
Jp4YMIf936KasPLNEymvB3	6V1bu6o1Yo5ZXnsCJU8Ovk
Jp4YMIf936KasPLNEymvB3	2xGjteMU3E1tkEPVFBO08U
Jp4YMIf936KasPLNEymvB3	5WvAo7DNuPRmk4APhdPzi8
Jp4YMIf936KasPLNEymvB3	1BuZAIO8WZpavWVbbq3Lci
Jp4YMIf936KasPLNEymvB3	0ZNrc4kNeQYD9koZ3KvCsy
Jp4YMIf936KasPLNEymvB3	5gW5dSy3vXJxgzma4rQuzH
Jp4YMIf936KasPLNEymvB3	083Qf6hn6sFL6xiOHlZUyn
QlNM9gC3Z9AwcKBBdmOIUm	2YpeDb67231RjR0MgVLzsG
QlNM9gC3Z9AwcKBBdmOIUm	2Fxmhks0bxGSBdJ92vM42m
QlNM9gC3Z9AwcKBBdmOIUm	6v3KW9xbzN5yKLt9YKDYA2
QlNM9gC3Z9AwcKBBdmOIUm	1BxfuPKGuaTgP7aM0Bbdwr
QlNM9gC3Z9AwcKBBdmOIUm	21jGcNKet2qwijlDFuPiPb
QlNM9gC3Z9AwcKBBdmOIUm	2qxmye6gAegTMjLKEBoR3d
QlNM9gC3Z9AwcKBBdmOIUm	5p7ujcrUXASCNwRaWNHR1C
QlNM9gC3Z9AwcKBBdmOIUm	0u2P5u6lvoDfwTYjAADbn4
QlNM9gC3Z9AwcKBBdmOIUm	2xLMifQCjDGFmkHkpNLD9h
QlNM9gC3Z9AwcKBBdmOIUm	2vXKRlJBXyOcvZYTdNeckS
QlNM9gC3Z9AwcKBBdmOIUm	7qEHsqek33rTcFNT9PFqLf
QlNM9gC3Z9AwcKBBdmOIUm	0Oqc0kKFsQ6MhFOLBNZIGX
QlNM9gC3Z9AwcKBBdmOIUm	2JvzF1RMd7lE3KmFlsyZD8
QlNM9gC3Z9AwcKBBdmOIUm	1dGr1c8CrMLDpV6mPbImSI
QlNM9gC3Z9AwcKBBdmOIUm	43zdsphuZLzwA9k4DJhU0I
QlNM9gC3Z9AwcKBBdmOIUm	7xQAfvXzm3AkraOtGPWIZg
QlNM9gC3Z9AwcKBBdmOIUm	22vgEDb5hykfaTwLuskFGD
QlNM9gC3Z9AwcKBBdmOIUm	4l0Mvzj72xxOpRrp6h8nHi
QlNM9gC3Z9AwcKBBdmOIUm	3e9HZxeyfWwjeyPAMmWSSQ
QlNM9gC3Z9AwcKBBdmOIUm	1rqqCSm0Qe4I9rUvWncaom
QlNM9gC3Z9AwcKBBdmOIUm	6RRNNciQGZEXnqk8SQ9yv5
QlNM9gC3Z9AwcKBBdmOIUm	7dt6x5M1jzdTEt8oCbisTK
QlNM9gC3Z9AwcKBBdmOIUm	2t8yVaLvJ0RenpXUIAC52d
QlNM9gC3Z9AwcKBBdmOIUm	1lOe9qE0vR9zwWQAOk6CoO
QlNM9gC3Z9AwcKBBdmOIUm	7DnAm9FOTWE3cUvso43HhI
QlNM9gC3Z9AwcKBBdmOIUm	1wJRveJZLSb1rjhnUHQiv6
QlNM9gC3Z9AwcKBBdmOIUm	7tFiyTwD0nx5a1eklYtX2J
QlNM9gC3Z9AwcKBBdmOIUm	132ALUzVLmqYB4UsBj5qD6
QlNM9gC3Z9AwcKBBdmOIUm	0DiDStADDVh3SvAsoJAFMk
QlNM9gC3Z9AwcKBBdmOIUm	5itOtNx0WxtJmi1TQ3RuRd
QlNM9gC3Z9AwcKBBdmOIUm	2Xnv3GntqbBH1juvUYSpHG
QlNM9gC3Z9AwcKBBdmOIUm	0pEkK8MqbmGSX7fT8WLMbR
QlNM9gC3Z9AwcKBBdmOIUm	6TqXcAFInzjp0bODyvrWEq
QlNM9gC3Z9AwcKBBdmOIUm	1000nHvUdawXuUHgBod4Wv
QlNM9gC3Z9AwcKBBdmOIUm	5ls62WNKHUUrdF3r1cv83T
QlNM9gC3Z9AwcKBBdmOIUm	19kUPdKTp85q9RZNwaXM15
QlNM9gC3Z9AwcKBBdmOIUm	5N1o6d8zGcSZSeMFkOUQOk
QlNM9gC3Z9AwcKBBdmOIUm	3iH29NcCxYgI5shlkZrUoB
QlNM9gC3Z9AwcKBBdmOIUm	6ImEBuxsbuTowuHmg3Z2FO
QlNM9gC3Z9AwcKBBdmOIUm	1AI7UPw3fgwAFkvAlZWhE0
QlNM9gC3Z9AwcKBBdmOIUm	5GBuCHuPKx6UC7VsSPK0t3
ndfd917VUIq2bOQToxPcqS	0sf12qNH5qcw8qpgymFOqD
ndfd917VUIq2bOQToxPcqS	4LEK9rD7TWIG4FCL1s27XC
ndfd917VUIq2bOQToxPcqS	7igeByaBM0MgGsgXtNxDJ7
ndfd917VUIq2bOQToxPcqS	6UelLqGlWMcVH1E5c4H7lY
ndfd917VUIq2bOQToxPcqS	22LAwLoDA5b4AaGSkg6bKW
ndfd917VUIq2bOQToxPcqS	0nbXyq5TXYPCO7pr3N8S4I
ndfd917VUIq2bOQToxPcqS	127QTOFJsJQp5LbJbu3A1y
ndfd917VUIq2bOQToxPcqS	5RqR4ZCCKJDcBLIn4sih9l
ndfd917VUIq2bOQToxPcqS	7eJMfftS33KTjuF7lTsMCx
ndfd917VUIq2bOQToxPcqS	4xqrdfXkTW4T0RauPLv3WA
ndfd917VUIq2bOQToxPcqS	3ZCTVFBt2Brf31RLEnCkWJ
ndfd917VUIq2bOQToxPcqS	3Dv1eDb0MEgF93GpLXlucZ
ndfd917VUIq2bOQToxPcqS	0v1x6rN6JHRapa03JElljE
ndfd917VUIq2bOQToxPcqS	3tjFYV6RSFtuktYl3ZtYcq
ndfd917VUIq2bOQToxPcqS	0PvFJmanyNQMseIFrU708S
ndfd917VUIq2bOQToxPcqS	2Wo6QQD1KMDWeFkkjLqwx5
ndfd917VUIq2bOQToxPcqS	1Cv1YLb4q0RzL6pybtaMLo
ndfd917VUIq2bOQToxPcqS	3jjujdWJ72nww5eGnfs2E7
ndfd917VUIq2bOQToxPcqS	2SAqBLGA283SUiwJ3xOUVI
ndfd917VUIq2bOQToxPcqS	2Z8yfpFX0ZMavHkcIeHiO1
ndfd917VUIq2bOQToxPcqS	1DWZUa5Mzf2BwzpHtgbHPY
ndfd917VUIq2bOQToxPcqS	2ygvZOXrIeVL4xZmAWJT2C
pcclfKySeZMYGS2V6uxNLn	7lPN2DXiMsVn7XUKtOW1CS
pcclfKySeZMYGS2V6uxNLn	67BtfxlNbhBmCDR2L2l8qd
pcclfKySeZMYGS2V6uxNLn	3Wrjm47oTz2sjIgck11l5e
pcclfKySeZMYGS2V6uxNLn	37BZB0z9T8Xu7U3e65qxFy
pcclfKySeZMYGS2V6uxNLn	4iJyoBOLtHqaGxP12qzhQI
pcclfKySeZMYGS2V6uxNLn	7MAibcTli4IisCtbHKrGMh
pcclfKySeZMYGS2V6uxNLn	61KpQadow081I2AsbeLcsb
pcclfKySeZMYGS2V6uxNLn	3YJJjQPAbDT7mGpX3WtQ9A
pcclfKySeZMYGS2V6uxNLn	6PQ88X9TkUIAUIZJHW2upE
pcclfKySeZMYGS2V6uxNLn	5HCyWlXZPP0y6Gqq8TgA20
pcclfKySeZMYGS2V6uxNLn	5Z9KJZvQzH6PFmb8SNkxuk
pcclfKySeZMYGS2V6uxNLn	748mdHapucXQri7IAO8yFK
pcclfKySeZMYGS2V6uxNLn	6PERP62TejQjgHu81OHxgM
pcclfKySeZMYGS2V6uxNLn	3FAJ6O0NOHQV8Mc5Ri6ENp
pcclfKySeZMYGS2V6uxNLn	0gplL1WMoJ6iYaPgMCL0gX
pcclfKySeZMYGS2V6uxNLn	5enxwA8aAbwZbf5qCHORXi
pcclfKySeZMYGS2V6uxNLn	4RVwu0g32PAqgUiJoXsdF8
pcclfKySeZMYGS2V6uxNLn	40iJIUlhi6renaREYGeIDS
pcclfKySeZMYGS2V6uxNLn	6Uj1ctrBOjOas8xZXGqKk4
pcclfKySeZMYGS2V6uxNLn	3Ofmpyhv5UAQ70mENzB277
pcclfKySeZMYGS2V6uxNLn	7hU3IHwjX150XLoTVmjD0q
pcclfKySeZMYGS2V6uxNLn	3VqeTFIvhxu3DIe4eZVzGq
pcclfKySeZMYGS2V6uxNLn	463CkQjx2Zk1yXoBuierM9
pcclfKySeZMYGS2V6uxNLn	4fSIb4hdOQ151TILNsSEaF
pcclfKySeZMYGS2V6uxNLn	6Im9k8u9iIzKMrmV7BWtlF
pcclfKySeZMYGS2V6uxNLn	10hcDov7xmcRviA8jLwEaI
pcclfKySeZMYGS2V6uxNLn	4pt5fDVTg5GhEvEtlz9dKk
pcclfKySeZMYGS2V6uxNLn	0z8hI3OPS8ADPWtoCjjLl6
pcclfKySeZMYGS2V6uxNLn	07MDkzWARZaLEdKxo6yArG
pcclfKySeZMYGS2V6uxNLn	0eu4C55hL6x29mmeAjytzC
pcclfKySeZMYGS2V6uxNLn	3nY8AqaMNNHHLYV4380ol0
pcclfKySeZMYGS2V6uxNLn	0WSEq9Ko4kFPt8yo3ICd6T
pZxQbhuIGcA5v4a4eMVxDI	4LRPiXqCikLlN15c3yImP7
pZxQbhuIGcA5v4a4eMVxDI	1IHWl5LamUGEuP4ozKQSXZ
pZxQbhuIGcA5v4a4eMVxDI	0V3wPSX9ygBnCm8psDIegu
pZxQbhuIGcA5v4a4eMVxDI	3nqQXoyQOWXiESFLlDF1hG
pZxQbhuIGcA5v4a4eMVxDI	29d0nY7TzCoi22XBqDQkiP
pZxQbhuIGcA5v4a4eMVxDI	6xGruZOHLs39ZbVccQTuPZ
pZxQbhuIGcA5v4a4eMVxDI	1xzi1Jcr7mEi9K2RfzLOqS
pZxQbhuIGcA5v4a4eMVxDI	1rDQ4oMwGJI7B4tovsBOxc
pZxQbhuIGcA5v4a4eMVxDI	02MWAaffLxlfxAUY7c5dvx
pZxQbhuIGcA5v4a4eMVxDI	4k6Uh1HXdhtusDW5y8Gbvy
pZxQbhuIGcA5v4a4eMVxDI	6I3mqTwhRpn34SLVafSH7G
pZxQbhuIGcA5v4a4eMVxDI	4fouWK6XVHhzl78KzQ1UjL
pZxQbhuIGcA5v4a4eMVxDI	1qEmFfgcLObUfQm0j1W2CK
pZxQbhuIGcA5v4a4eMVxDI	5CZ40GBx1sQ9agT82CLQCT
pZxQbhuIGcA5v4a4eMVxDI	6Sq7ltF9Qa7SNFBsV5Cogx
pZxQbhuIGcA5v4a4eMVxDI	4C6Uex2ILwJi9sZXRdmqXp
pZxQbhuIGcA5v4a4eMVxDI	1PckUlxKqWQs3RlWXVBLw3
pZxQbhuIGcA5v4a4eMVxDI	27NovPIUIRrOZoCHxABJwK
pZxQbhuIGcA5v4a4eMVxDI	2tTmW7RDtMQtBk7m2rYeSw
pZxQbhuIGcA5v4a4eMVxDI	5ildQOEKmJuWGl2vRkFdYc
pZxQbhuIGcA5v4a4eMVxDI	7rglLriMNBPAyuJOMGwi39
pZxQbhuIGcA5v4a4eMVxDI	5IgjP7X4th6nMNDh4akUHb
pZxQbhuIGcA5v4a4eMVxDI	59CfNbkERJ3NoTXDvoURjj
pZxQbhuIGcA5v4a4eMVxDI	5jQI2r1RdgtuT8S3iG8zFC
pZxQbhuIGcA5v4a4eMVxDI	3IAfUEeaXRX9s9UdKOJrFI
pZxQbhuIGcA5v4a4eMVxDI	0skYUMpS0AcbpjcGsAbRGj
pZxQbhuIGcA5v4a4eMVxDI	0e8nrvls4Qqv5Rfa2UhqmO
pZxQbhuIGcA5v4a4eMVxDI	4h9wh7iOZ0GGn8QVp4RAOB
pZxQbhuIGcA5v4a4eMVxDI	0mBP9X2gPCuapvpZ7TGDk3
pZxQbhuIGcA5v4a4eMVxDI	35ovElsgyAtQwYPYnZJECg
pZxQbhuIGcA5v4a4eMVxDI	52xJxFP6TqMuO4Yt0eOkMz
pZxQbhuIGcA5v4a4eMVxDI	2KukL7UlQ8TdvpaA7bY3ZJ
pZxQbhuIGcA5v4a4eMVxDI	6Uj1ctrBOjOas8xZXGqKk4
pZxQbhuIGcA5v4a4eMVxDI	7dSZ6zGTQx66c2GF91xCrb
pZxQbhuIGcA5v4a4eMVxDI	2rurDawMfoKP4uHyb2kJBt
pZxQbhuIGcA5v4a4eMVxDI	6Xom58OOXk2SoU711L2IXO
pZxQbhuIGcA5v4a4eMVxDI	0ARKW62l9uWIDYMZTUmJHF
pZxQbhuIGcA5v4a4eMVxDI	1ri9ZUkBJVFUdgwzCnfcYs
pZxQbhuIGcA5v4a4eMVxDI	7mFj0LlWtEJaEigguaWqYh
pZxQbhuIGcA5v4a4eMVxDI	1oFAF1hdPOickyHgbuRjyX
pZxQbhuIGcA5v4a4eMVxDI	34ZAzO78a5DAVNrYIGWcPm
pZxQbhuIGcA5v4a4eMVxDI	3F5CgOj3wFlRv51JsHbxhe
pZxQbhuIGcA5v4a4eMVxDI	3rWDp9tBPQR9z6U5YyRSK4
pZxQbhuIGcA5v4a4eMVxDI	2g6tReTlM2Akp41g0HaeXN
pZxQbhuIGcA5v4a4eMVxDI	4pi1G1x8tl9VfdD9bL3maT
pZxQbhuIGcA5v4a4eMVxDI	3LtpKP5abr2qqjunvjlX5i
pZxQbhuIGcA5v4a4eMVxDI	3XOalgusokruzA5ZBA2Qcb
pZxQbhuIGcA5v4a4eMVxDI	1r8ZCjfrQxoy2wVaBUbpwg
\.


--
-- TOC entry 4875 (class 0 OID 75873)
-- Dependencies: 217
-- Data for Name: playlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playlists (playlist_id, year_, playlist_url) FROM stdin;
dRZrPqTJ2iw75iSpHG7KnI	2016	https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R
hYKylhpPiH1VPodagRTNzu	2012	https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3
ndfd917VUIq2bOQToxPcqS	2020	https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ
9wnrC2T34VLxtL7vdC8hVE	2015	https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ
LgCTGYUwup3J1TSMRyObZA	2017	https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW
Jp4YMIf936KasPLNEymvB3	2018	https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8
h9t7HfmUClwEKkUc7f34jH	2013	https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer
QlNM9gC3Z9AwcKBBdmOIUm	2019	https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9
wOvFE37RYJBq423MAkmUPr	2011	https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ
pcclfKySeZMYGS2V6uxNLn	2021	https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se
pZxQbhuIGcA5v4a4eMVxDI	2022	https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7
KUBSaE6ulYu49hAg7vmNAR	2014	https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4
Z3d7ZvFizjczhqkQnb7RXg	2010	https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj
\.


--
-- TOC entry 4874 (class 0 OID 16441)
-- Dependencies: 216
-- Data for Name: playlists_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playlists_data (playlist_url, year_, track_id, track_name, track_popularity, album, artist_id, artist_name, artist_genres, artist_popularity, danceability, energy, key_, loudness, mode_, speechiness, acousticness, instrumentalness, liveness, valence, tempo, duration_ms, time_signature) FROM stdin;
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	7BqBn9nzAq8spo5e7cZ0dJ	Just the Way You Are	86	Doo-Wops & Hooligans	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.635	0.841	5	-5.379	1	0.0422	0.0134	0	0.0622	0.424	109.021	220734	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	15JINEqzVMv3SvJTAXAKED	Love The Way You Lie	85	Recovery	7dGJo4pcD2V6oG8kP0tJRR	Eminem	['detroit hip hop', 'hip hop', 'rap']	88	0.749	0.925	10	-5.034	1	0.227	0.241	0	0.52	0.641	86.989	263373	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	4HlFJV71xXKIGcU3kRyttv	Hey, Soul Sister	85	Save Me, San Francisco (Golden Gate Edition)	3FUY2gzHeIiaesXtOAdB7A	Train	['dance pop', 'neo mellow', 'pop', 'pop rock']	71	0.673	0.886	1	-4.44	0	0.0431	0.185	0	0.0826	0.795	97.012	216773	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	2GYHyAoLWpkxLVa4oYTVko	Alors on danse - Radio Edit	80	Cheese	5j4HeCoUlzhfWtjAfM1acR	Stromae	['belgian pop', 'g-house']	69	0.791	0.59	1	-9.206	0	0.0793	0.0994	0.00203	0.065	0.714	119.951	206067	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	0HPD5WQqrq7wPWR7P7Dw1i	TiK ToK	84	Animal (Expanded Edition)	6LqNN22kT3074XbTVUrhzX	Kesha	['dance pop', 'pop']	74	0.755	0.837	2	-2.718	0	0.142	0.0991	0	0.289	0.714	120.028	199693	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	4dTaAiV9xFFCxnPur9c9yL	Memories (feat. Kid Cudi)	70	One Love (Deluxe)	1Cs0zKBU1kc0i8ypK3B9ai	David Guetta	['big room', 'dance pop', 'edm', 'pop', 'pop dance']	86	0.561	0.87	8	-6.103	1	0.343	0.0015	2.82e-06	0.246	0.498	129.98	210093	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	3ZdJffjzJWFimSQyxgGIxN	Just A Dream	77	5	2gBjLmx6zQnFGQJCAQpRgw	Nelly	['dance pop', 'gangster rap', 'hip hop', 'pop rap', 'rap', 'st louis rap', 'urban contemporary']	73	0.531	0.752	1	-6.161	1	0.0305	0.0421	0	0.12	0.103	89.917	237800	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	3GBApU0NuzH4hKZq4NOSdA	What You Know	76	Tourist History	536BYVgOnRky0xjsPT96zl	Two Door Cinema Club	['indie rock', 'indietronica', 'irish rock', 'modern alternative rock', 'modern rock', 'northern irish indie']	67	0.563	0.739	6	-4.239	0	0.0416	0.00073	1.45e-05	0.0822	0.775	139	191707	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	1bM50INir8voAkVoKuvEUI	OMG (feat. will.i.am)	76	Raymond v Raymond (Expanded Edition)	23zg3TcAtWQy7J6upgbUnj	USHER	['atl hip hop', 'contemporary r&b', 'dance pop', 'pop', 'r&b', 'rap', 'south carolina hip hop', 'urban contemporary']	77	0.781	0.745	4	-5.81	0	0.0332	0.198	1.14e-05	0.36	0.326	129.998	269493	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	2M9ULmQwTaTGmAdXaXpfz5	Billionaire (feat. Bruno Mars)	75	Billionaire (feat. Bruno Mars)	7o9Nl7K1Al6NNAHX6jn6iG	Travie McCoy	['pop rap']	60	0.633	0.673	6	-6.403	0	0.258	0.297	0	0.206	0.659	86.776	211160	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	5jzKL4BDMClWqRguW5qZvh	Teenage Dream	76	Teenage Dream	6jJ0s89eD6GaHleKKya26X	Katy Perry	['pop']	82	0.719	0.798	10	-4.582	1	0.0361	0.0162	2.34e-06	0.134	0.591	120.011	227741	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	4TCL0qqKyqsMZml0G3M9IM	Telephone	75	The Fame Monster (Deluxe Edition)	1HY2Jd0NmPuamShAr6KMms	Lady Gaga	['art pop', 'dance pop', 'pop']	83	0.824	0.836	3	-5.903	1	0.0404	0.00521	0.000817	0.112	0.716	122.014	220640	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	5vlEg2fT4cFWAqU5QptIpQ	Replay	74	Replay	5tKXB9uuebKE34yowVaU3C	Iyaz	['dance pop', 'pop rap', 'post-teen pop']	63	0.706	0.751	9	-6.323	1	0.0708	0.173	0	0.168	0.195	91.031	182307	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	6lV2MSQmRIkycDScNtrBXO	Airplanes (feat. Hayley Williams of Paramore)	78	B.o.B Presents: The Adventures of Bobby Ray	5ndkK3dpZLKtBklKjxNQwT	B.o.B	['atl hip hop', 'dance pop', 'pop rap', 'rap', 'southern hip hop']	71	0.66	0.867	6	-4.285	0	0.116	0.11	0	0.0368	0.377	93.033	180480	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	4AYX69oFP3UOS1CFmV9UfO	Bottoms Up (feat. Nicki Minaj)	74	Passion, Pain & Pleasure (Deluxe Version)	2iojnBLj0qIMiKPvVhLnsH	Trey Songz	['dance pop', 'r&b', 'southern hip hop', 'trap', 'urban contemporary']	67	0.844	0.601	1	-5.283	1	0.157	0.0205	0	0.385	0.331	73.989	242013	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	6DkXLzBQT7cwXmTyzAB1DJ	What's My Name?	74	Loud (Japan Version)	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.689	0.784	2	-2.972	1	0.074	0.182	0	0.0843	0.561	99.954	263173	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	1HHeOs6zRdF8Ck58easiAY	Alejandro	74	The Fame Monster (Deluxe Edition)	1HY2Jd0NmPuamShAr6KMms	Lady Gaga	['art pop', 'dance pop', 'pop']	83	0.623	0.793	11	-6.63	0	0.0462	0.000397	0.0015	0.375	0.36	98.998	274213	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	5sra5UY6sD658OabHL3QtI	Empire State of Mind (Part II) Broken Down	73	The Element Of Freedom	3DiDSECUqqY1AuBP8qtaIa	Alicia Keys	['neo soul', 'pop', 'r&b']	75	0.484	0.368	6	-7.784	1	0.0341	0.74	3.82e-05	0.118	0.142	92.923	216480	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	6BdgtqiV3oXNqBikezwdvC	Over	73	Thank Me Later	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.35	0.845	7	-5.614	1	0.2	0.0107	0	0.123	0.45	99.643	233560	5
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	7ElF5zxOwYP4qVSWVvse3W	Break Your Heart	73	The Rokstarr Hits Collection	6MF9fzBmfXghAz953czmBC	Taio Cruz	['dance pop', 'pop', 'pop rap']	67	0.607	0.934	3	-4.217	1	0.0314	0.0327	0	0.0909	0.568	122.01	201547	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	6wN4nT2qy3MQc098yL3Eu9	Deuces (feat. Tyga & Kevin McCall)	71	F.A.M.E. (Expanded Edition)	7bXgB6jMjp9ATFy66eO08Z	Chris Brown	['pop rap', 'r&b', 'rap']	84	0.692	0.736	1	-5.109	1	0.11	0.0324	0	0.0787	0.217	73.987	276560	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	4YYHgF9dWyVSor0GtrBzdf	Te Amo	71	Rated R	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.567	0.707	8	-5.455	0	0.0818	0.541	0.000176	0.1	0.751	171.917	208427	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	61LtVmmkGr8P9I2tSPvdpf	Teach Me How to Dougie	70	The Kickback	1EeArivTpzLNCqubV95255	Cali Swag District	['pop rap']	49	0.846	0.438	11	-4.981	1	0.141	0.2	9.43e-05	0.0939	0.512	85.013	237480	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	0WCiI0ddWiu5F2kSHgfw5S	Take It Off	70	Animal (Expanded Edition)	6LqNN22kT3074XbTVUrhzX	Kesha	['dance pop', 'pop']	74	0.729	0.675	5	-5.292	0	0.0286	4.14e-05	0.00126	0.0867	0.74	125.036	215200	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	2DHc2e5bBn4UzY0ENVFrUl	Carry Out (Featuring Justin Timberlake)	70	Shock Value II	5Y5TRrQiqgUO4S36tzjIRZ	Timbaland	['dance pop', 'pop', 'pop rap']	75	0.531	0.574	10	-6.693	0	0.113	0.114	0.0308	0.256	0.272	115.68	232467	5
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	4BycRneKmOs6MhYG9THsuX	Find Your Love	70	Thank Me Later	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.627	0.614	6	-6.006	0	0.17	0.0211	0	0.0286	0.758	96.038	208947	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	4u26EevCNXMhlvE1xFBJwX	If I Die Young	69	The Band Perry	75FnCoo4FBxH5K1Rrx0k5A	The Band Perry	['contemporary country', 'country', 'country dawn', 'country road']	54	0.606	0.497	4	-6.611	1	0.0277	0.348	0	0.275	0.362	130.739	222773	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	0oJMv049q8hEkes9w0L1J4	Imma Be	68	THE E.N.D. (THE ENERGY NEVER DIES)	1yxSLGMDHlW21z4YXirZDS	Black Eyed Peas	['dance pop', 'pop', 'pop rap']	78	0.597	0.517	0	-6.963	1	0.366	0.179	0	0.307	0.413	92.035	257560	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	7HacCTm33hZYYN8DXpCYuG	I Like It	67	Euphoria	7qG3b048QCHVRO5Pv1T5lw	Enrique Iglesias	['dance pop', 'latin pop', 'mexican pop']	75	0.648	0.942	10	-2.881	0	0.0878	0.021	0	0.0594	0.73	129.007	231373	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	0JcKdUGNR7zI4jJDLyYXbi	Stuck Like Glue	67	The Incredible Machine	0hYxQe3AK5jBPCr5MumLHD	Sugarland	['contemporary country', 'country', 'country dawn', 'country road']	55	0.702	0.795	1	-4.764	1	0.0568	0.329	0	0.0505	0.836	83.961	247587	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	030OCtLMrljNhp8OWHBWW3	Hey Daddy (Daddy's Home)	67	Raymond v Raymond (Expanded Edition)	23zg3TcAtWQy7J6upgbUnj	USHER	['atl hip hop', 'contemporary r&b', 'dance pop', 'pop', 'r&b', 'rap', 'south carolina hip hop', 'urban contemporary']	77	0.59	0.698	11	-4.262	1	0.0286	0.000176	0	0.107	0.352	95.975	224093	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	7hR5toSPEgwFZ78jfHdANM	Half of My Heart	67	Battle Studies	0hEurMDQu99nJRq8pTxO14	John Mayer	['neo mellow', 'singer-songwriter']	75	0.681	0.593	5	-9.327	1	0.0251	0.435	0.000117	0.106	0.731	115.058	250373	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	2r6DdaSbkbwoPzuK6NjLPn	Can't Be Tamed	67	Can't Be Tamed	5YGY8feqx7naU7z4HrwZM6	Miley Cyrus	['pop']	85	0.63	0.91	11	-2.919	0	0.144	0.0287	0	0.196	0.743	116.98	168213	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	45O0tUN9Bh6LH4eNxQ07AT	Eenie Meenie	67	Eenie Meenie EP	6S0dmVVn4udvppDhZIWxCr	Sean Kingston	['dance pop', 'miami hip hop', 'pop']	68	0.734	0.639	1	-3.241	1	0.0316	0.0348	0	0.102	0.836	121.212	201653	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	37dYAkMa4lzRCH6kDbMT1L	We No Speak Americano (Edit)	66	We No Speak Americano	4KkHjCe8ouh8C2P9LPoD4F	Yolanda Be Cool	['australian dance', 'australian house', 'bass house']	51	0.902	0.805	6	-5.003	1	0.0468	0.0748	0.0823	0.0914	0.745	124.985	157438	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	7AqISujIaWcY3h5zrOqt5v	Forget You	66	The Lady Killer	5nLYd9ST4Cnwy6NHaCxbj8	CeeLo Green	['atl hip hop']	63	0.696	0.875	0	-3.682	1	0.0649	0.134	0	0.159	0.772	127.39	222733	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	1hBM2D1ULT3aeKuddSwPsK	STARSTRUKK (feat. Katy Perry)	66	WANT (Deluxe)	0FWzNDaEu9jdgcYTbcOa4F	3OH!3	['dance pop', 'electropowerpop', 'pop punk', 'pop rap', 'post-teen pop']	60	0.607	0.805	11	-5.579	0	0.0608	0.00175	0	0.231	0.232	139.894	202667	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	0dBW6ZsW8skfvoRfgeerBF	Mine	66	Speak Now	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.624	0.757	7	-2.94	1	0.0296	0.00265	1.87e-06	0.189	0.658	121.07	230707	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	07WEDHF2YwVgYuBugi2ECO	Kickstarts	65	Won't Go Quietly	6Vh6UDWfu9PUSXSzAaB3CW	Example	['hip house', 'uk dance']	56	0.61	0.836	5	-4.455	1	0.0573	0.00374	0	0.358	0.657	126.056	181827	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	4gs07VlJST4bdxGbBsXVue	Heartbreak Warfare	66	Battle Studies	0hEurMDQu99nJRq8pTxO14	John Mayer	['neo mellow', 'singer-songwriter']	75	0.624	0.554	2	-8.113	1	0.0225	0.191	0.00131	0.299	0.311	97.031	269720	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	3uIGef7OSXkFdqxjFWn2o6	Gold Dust - Radio Edit	65	Gold Dust	6r20qOqY7qDWI0PPTxVMlC	DJ Fresh	['dancefloor dnb', 'drum and bass', 'uk dance']	55	0.451	0.948	0	-0.74	1	0.147	0.255	0	0.392	0.295	176.985	192447	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	2fQ6sBFWaLv2Gxos4igHLy	Say Aah (feat. Fabolous)	65	Ready (Deluxe)	2iojnBLj0qIMiKPvVhLnsH	Trey Songz	['dance pop', 'r&b', 'southern hip hop', 'trap', 'urban contemporary']	67	0.724	0.87	1	-3.614	0	0.113	0.00453	0	0.833	0.81	93.01	207547	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	1WtTLtofvcjQM3sXSMkDdX	How Low	65	Battle Of The Sexes (Deluxe)	3ipn9JLAPI5GUEo4y4jcoi	Ludacris	['atl hip hop', 'dance pop', 'dirty south rap', 'hip hop', 'old school atlanta hip hop', 'pop rap', 'rap', 'southern hip hop', 'trap']	74	0.785	0.498	1	-6.977	1	0.0533	0.00248	1.23e-06	0.224	0.418	143.96	201587	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	2rDwdvBma1O1eLzo29p2cr	Whataya Want from Me	64	For Your Entertainment	6prmLEyn4LfHlD9NnXWlf7	Adam Lambert	['dance pop', 'idol', 'pop', 'post-teen pop']	59	0.44	0.683	11	-4.732	0	0.0489	0.00706	0	0.0593	0.445	185.948	227320	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	5BoIP8Eha5hwmRVURkC2Us	In My Head	64	Jason Derulo	07YZf4WDAMNwqr4jfgOZ8y	Jason Derulo	['dance pop', 'pop']	77	0.762	0.748	0	-4.15	0	0.033	0.0266	0	0.348	0.851	110.009	199027	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	17tDv8WA8IhqE8qzuQn707	My First Kiss (feat. Ke$ha)	64	Streets Of Gold	0FWzNDaEu9jdgcYTbcOa4F	3OH!3	['dance pop', 'electropowerpop', 'pop punk', 'pop rap', 'post-teen pop']	60	0.682	0.889	0	-4.166	1	0.0804	0.00564	0	0.36	0.827	138.021	192440	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	6KBYk8OFtod7brGuZ3Y67q	Misery	64	Hands All Over (Deluxe)	04gDigrS5kc9YWfZHwBETP	Maroon 5	['pop']	83	0.704	0.81	4	-4.874	0	0.0425	0.000315	0	0.216	0.726	102.98	216200	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	41KPpw0EZCytxNkmEMJVgr	One - Radio Edit	63	One (Your Name)	1h6Cn3P4NGzXbaXidqURXs	Swedish House Mafia	['edm', 'pop dance', 'progressive electro house']	74	0.802	0.781	0	-6.564	1	0.0368	0.0075	0.825	0.147	0.622	125.026	169920	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	1yK9LISg5uBOOW5bT2Wm0i	Try Sleeping with a Broken Heart	63	The Element Of Freedom	3DiDSECUqqY1AuBP8qtaIa	Alicia Keys	['neo soul', 'pop', 'r&b']	75	0.496	0.821	5	-5.155	1	0.112	0.158	0.246	0.13	0.549	110.977	249013	5
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	3VA8T3rNy5V24AXxNK5u9E	King of Anything	63	Kaleidoscope Heart	2Sqr0DXoaYABbjBo9HaMkM	Sara Bareilles	['acoustic pop', 'lilith', 'neo mellow', 'pop rock', 'post-teen pop']	63	0.676	0.762	1	-4.172	1	0.0351	0.461	0	0.0574	0.81	119.003	207493	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	09ZcYBGFX16X8GMDrvqQwt	For the First Time	62	Science & Faith	3AQRLZ9PuTAozP28Skbq8V	The Script	['celtic rock', 'pop']	71	0.396	0.629	9	-4.78	1	0.0287	0.0328	0	0.183	0.358	173.794	252853	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	7g13jf3zqlP5S68Voo5v9m	Dancing On My Own - Radio Edit	62	Body Talk	6UE7nl9mha6s8z0wFQFIZ2	Robyn	['dance pop', 'electropop', 'neo-synthpop', 'scandipop', 'swedish electropop', 'swedish pop']	58	0.573	0.926	6	-6.045	1	0.0342	0.00202	0.0117	0.127	0.219	117.047	278080	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	6GgPsuz0HEO0nrO2T0QhDv	No Hands (feat. Roscoe Dash & Wale)	61	No Hands (feat. Roscoe Dash & Wale)	6f4XkbvYlXMH0QgVRzW0sM	Waka Flocka Flame	['atl hip hop', 'dirty south rap', 'pop rap', 'rap', 'southern hip hop', 'trap']	64	0.76	0.595	1	-6.366	1	0.0391	0.00544	0	0.241	0.361	131.497	263773	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	0zREtnLmVnt8KUJZZbSdla	Wavin' Flag	61	Troubadour	7pGyQZx9thVa8GxMBeXscB	K'NAAN	['reggae fusion']	59	0.625	0.699	0	-6.416	1	0.0729	0.13	0	0.238	0.717	75.974	220520	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	2tNE4DP5nL85XUJv1glO0a	This Ain't a Love Song	49	Ten Add Ten: The Very Best of Scouting For Girls	2wpJOPmf1TIOzrB9mzHifd	Scouting For Girls	[]	53	0.458	0.905	0	-4.157	1	0.0451	0.000431	0	0.378	0.553	176.667	210680	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	5ZFVacinyPxz19eK2vTodL	Miami 2 Ibiza - Swedish House Mafia vs. Tinie Tempah	48	Disc-Overy	1h6Cn3P4NGzXbaXidqURXs	Swedish House Mafia	['edm', 'pop dance', 'progressive electro house']	74	0.736	0.929	7	-5.89	0	0.0674	0.00237	1.11e-05	0.402	0.658	125.03	206461	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	5e0dZqrrTaoj6AIL7VjnBM	Written in the Stars (feat. Eric Turner)	48	Disc-Overy	0Tob4H0FLtEONHU1MjpUEp	Tinie Tempah	['dance pop', 'grime', 'pop rap']	64	0.619	0.971	7	-3.045	1	0.13	0.0526	0	0.196	0.295	122.552	207600	5
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	0XvjOhwCnXXFOSlBbV9jPN	Barbra Streisand - Radio Edit	46	Barbra Streisand	0q8J3Yj810t5cpAYEJ7gxt	Duck Sauce	['disco house']	50	0.769	0.922	1	-1.966	1	0.108	0.000939	0.197	0.233	0.506	127.965	196533	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	31zeLcKH2x3UCMHT75Gk5C	Commander	46	Here I Am (Deluxe Version)	3AuMNF8rQAKOzjYppFNAoB	Kelly Rowland	['atl hip hop', 'dance pop', 'hip pop', 'r&b', 'urban contemporary']	66	0.395	0.876	11	-3.859	0	0.138	0.0173	8.46e-06	0.362	0.567	124.638	218107	4
https://open.spotify.com/playlist/37i9dQZF1DXc6IFF23C9jj	2010	6FSxwdN08PvzimGApFjRnY	When We Collide	44	Letters (Deluxe Edition)	3906URNmNa1VCXEeiJ3DSH	Matt Cardle	['talent show']	29	0.443	0.683	2	-5.521	1	0.0343	0.0198	5.26e-06	0.313	0.447	81.986	226000	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	1c8gk2PeTE04A1pIDH9YMk	Rolling in the Deep	82	21	4dpARuHxo51G3z768sgnrY	Adele	['british soul', 'pop', 'pop soul', 'uk pop']	83	0.73	0.769	8	-5.114	1	0.0298	0.138	0	0.0473	0.507	104.948	228093	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	7LcfRTgAVTs5pQGEQgUEzN	Moves Like Jagger - Studio Recording From "The Voice" Performance	74	Hands All Over	04gDigrS5kc9YWfZHwBETP	Maroon 5	['pop']	83	0.722	0.758	11	-4.477	0	0.0471	0.0111	0	0.308	0.62	128.047	201160	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	0IkKz2J93C94Ei4BvDop7P	Party Rock Anthem	71	Sorry For Party Rocking	3sgFRtyBnxXD5ESfmbK4dl	LMFAO	['dance pop', 'pop', 'pop rap']	65	0.75	0.727	5	-4.21	0	0.142	0.0189	0	0.266	0.359	129.993	262173	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	4r6eNCsrZnQWJzzvFh4nlg	Firework	73	Teenage Dream	6jJ0s89eD6GaHleKKya26X	Katy Perry	['pop']	82	0.638	0.832	8	-5.039	1	0.049	0.141	0	0.113	0.648	124.071	227893	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	2tJulUYLDKOg9XrtVkMgcJ	Grenade	80	Doo-Wops & Hooligans	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.704	0.558	2	-7.273	0	0.0542	0.148	0	0.107	0.245	110.444	222091	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	0JXXNGljqupsJaZsgSbMZV	Sure Thing	89	All I Want Is You	360IAlyVv4PCEVjgyMZrxK	Miguel	['r&b']	77	0.684	0.607	11	-8.127	0	0.1	0.0267	0.000307	0.191	0.498	81.001	195373	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	6nek1Nin9q48AVZcWs9e9D	Paradise	86	Mylo Xyloto	4gzpq5DPGxSnKTe4SA8HAU	Coldplay	['permanent wave', 'pop']	86	0.449	0.585	5	-6.761	1	0.0268	0.0509	8.75e-05	0.0833	0.212	139.631	278719	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	1eyzqe2QqGZUmfcPZtrIyt	Midnight City	74	Hurry Up, We're Dreaming	63MQldklfxkjYDoUE4Tppz	M83	['french shoegaze', 'french synthpop', 'indietronica', 'metropopolis', 'neo-synthpop']	69	0.526	0.712	11	-6.525	0	0.0356	0.0161	0	0.179	0.32	105.009	241440	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	5Qy6a5KzM4XlRxsNcGYhgH	6 Foot 7 Foot	74	Tha Carter IV (Complete Edition)	55Aa2cqylxrFIXC767Z865	Lil Wayne	['hip hop', 'new orleans rap', 'pop rap', 'rap', 'trap']	84	0.364	0.752	2	-5.429	1	0.304	0.0007	0	0.318	0.606	79.119	248587	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	4RL77hMWUq35NYnPLXBpih	Skinny Love	74	Birdy	2WX2uTcsvV5OnS0inACecP	Birdy	['neo mellow', 'uk pop']	68	0.379	0.29	4	-8.485	1	0.051	0.952	0.00106	0.118	0.169	166.467	201080	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	3hsmbFKT5Cujb5GQjqEU39	Look At Me Now (feat. Lil' Wayne & Busta Rhymes)	74	F.A.M.E. (Expanded Edition)	7bXgB6jMjp9ATFy66eO08Z	Chris Brown	['pop rap', 'r&b', 'rap']	84	0.767	0.677	11	-6.128	0	0.184	0.0339	5.51e-06	0.144	0.538	146.155	222587	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	6DkXLzBQT7cwXmTyzAB1DJ	What's My Name?	74	Loud (Japan Version)	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.689	0.784	2	-2.972	1	0.074	0.182	0	0.0843	0.561	99.954	263173	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	3LUWWox8YYykohBbHUrrxd	We R Who We R	74	Cannibal (Expanded Edition)	6LqNN22kT3074XbTVUrhzX	Kesha	['dance pop', 'pop']	74	0.736	0.817	8	-4.9	1	0.0407	0.00987	0.00167	0.117	0.653	119.95	204760	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	2U8g9wVcUu9wsg6i7sFSv8	Every Teardrop Is a Waterfall	73	Mylo Xyloto	4gzpq5DPGxSnKTe4SA8HAU	Coldplay	['permanent wave', 'pop']	86	0.425	0.732	9	-6.883	1	0.0396	0.00194	0.0103	0.171	0.333	117.98	240796	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	2i0AUcEnsDm3dsqLrFWUCq	Tonight Tonight	73	Whatever	6jTnHxhb6cDCaCu4rdvsQ0	Hot Chelle Rae	['dance rock', 'neon pop punk', 'post-teen pop']	54	0.686	0.783	4	-4.977	1	0.119	0.0764	0	0.163	0.814	99.978	200467	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	4NTWZqvfQTlOMitlVn6tew	The Show Goes On	72	Lasers	01QTIT5P1pFP3QnnFSdsJf	Lupe Fiasco	['chicago rap', 'conscious hip hop', 'hip hop', 'political hip hop', 'pop rap', 'rap', 'southern hip hop']	64	0.591	0.889	7	-3.839	1	0.115	0.0189	0	0.155	0.65	143.067	239613	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	0aBKFfdyOD1Ttvgv0cfjjJ	More - RedOne Jimmy Joker Remix	72	More	23zg3TcAtWQy7J6upgbUnj	USHER	['atl hip hop', 'contemporary r&b', 'dance pop', 'pop', 'r&b', 'rap', 'south carolina hip hop', 'urban contemporary']	77	0.551	0.893	7	-2.628	1	0.0543	0.00166	0	0.348	0.794	125.083	219987	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	608a1wIsSd5KzMEqm1O7w3	I'm On One	72	We The Best Forever	0QHgL1lAIqAw0HtD7YldmP	DJ Khaled	['hip hop', 'miami hip hop', 'pop rap', 'rap']	74	0.413	0.807	11	-3.499	0	0.318	0.0536	0	0.631	0.438	149.33	296147	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	70ATm56tH7OrQ1zurYssz0	I Need A Doctor	72	I Need A Doctor	6DPYiyq5kWVQS4RGwxzPC7	Dr. Dre	['g funk', 'gangster rap', 'hip hop', 'rap', 'west coast rap']	78	0.594	0.946	3	-4.521	1	0.452	0.0869	0	0.306	0.397	155.826	283733	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	16Of7eeW44kt0a1M0nitHM	You Make Me Feel... (feat. Sabi)	72	Night Shades	2aYJ5LAta2ScCdfLhKgZOY	Cobra Starship	['neon pop punk', 'pop punk', 'post-teen pop']	55	0.668	0.857	7	-2.944	0	0.0535	0.0191	6.71e-06	0.0385	0.748	131.959	215693	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	4fINc8dnfcz7AdhFYVA4i7	It Girl	71	Future History (Deluxe Edition)	07YZf4WDAMNwqr4jfgOZ8y	Jason Derulo	['dance pop', 'pop']	77	0.668	0.718	1	-4.736	0	0.0605	0.0165	0	0.104	0.345	91.993	192200	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	6r2BECwMgEoRb5yLfp0Hca	Born This Way	71	Born This Way (Special Edition)	1HY2Jd0NmPuamShAr6KMms	Lady Gaga	['art pop', 'dance pop', 'pop']	83	0.587	0.828	11	-5.108	1	0.161	0.00327	0	0.331	0.494	123.907	260253	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	3pYDZTJM2tVBUhIRifWVzI	Blow	71	Cannibal (Expanded Edition)	6LqNN22kT3074XbTVUrhzX	Kesha	['dance pop', 'pop']	74	0.753	0.729	11	-3.862	0	0.0392	0.00334	5.66e-05	0.073	0.812	120.013	219973	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	2OXidlnDThZR3zf36k6DVL	Just A Kiss	65	Own The Night	32WkQRZEVKSzVAAYqukAEA	Lady A	['contemporary country', 'country', 'country dawn', 'country pop', 'country road']	65	0.593	0.639	1	-5.826	1	0.0307	0.446	0	0.0998	0.332	142.881	218840	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	2TUzU4IkfH8kcvY2MUlsd2	I Won't Let You Go	65	The Awakening	3LpLGlgRS1IKPPwElnpW35	James Morrison	['neo mellow']	60	0.537	0.611	0	-6.427	1	0.0304	0.229	0	0.146	0.161	105.955	229303	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	1r3myKmjWoOqRip99CmSj1	Don't Wanna Go Home	64	Future History (Deluxe Edition)	07YZf4WDAMNwqr4jfgOZ8y	Jason Derulo	['dance pop', 'pop']	77	0.671	0.808	2	-4.861	0	0.0652	0.02	0	0.134	0.637	121.956	206080	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	1PAYgOjp1c9rrZ2kVQg2vN	Changed the Way You Kiss Me - Radio Edit	64	Playing In The Shadows	6Vh6UDWfu9PUSXSzAaB3CW	Example	['hip house', 'uk dance']	56	0.578	0.857	4	-3.78	0	0.041	0.00548	0.00162	0.0948	0.188	126.979	195467	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	53DB6LJV9B8sz0p1s6tlGS	Roll Up	64	Rolling Papers	137W8MRPWKqSmrBGDBFSop	Wiz Khalifa	['hip hop', 'pittsburgh rap', 'pop rap', 'rap', 'southern hip hop', 'trap']	79	0.523	0.805	3	-5.473	1	0.192	0.0524	0	0.0914	0.602	125.358	227773	5
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	36cmM3MBMWWCFIiQ90U4J8	Bounce (feat. Kelis) - Radio Edit	64	18 Months	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.779	0.963	2	-2.125	0	0.0399	0.0334	0.493	0.664	0.759	127.941	222187	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	04OxTCLGgDKfO0MMA2lcxv	Blind Faith	63	No More Idols	3jNkaOXasoc7RsxdchvEVq	Chase & Status	['dancefloor dnb', 'drum and bass', 'uk dance']	67	0.45	0.846	9	-4.712	0	0.0472	0.00523	0	0.228	0.402	140.042	233667	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	5E6CDAxnBqc9V9Y6t5wTUE	Mr. Saxobeat - Radio Edit	63	Come Into My World	0BmLNz4nSLfoWYW1cYsElL	Alexandra Stan	['romanian pop']	59	0.732	0.925	11	-4.165	0	0.051	0.0276	0.000238	0.14	0.782	127.012	195105	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	1f8UCzB3RqIgNkW7QIiIeP	Heart Skips a Beat (feat. Rizzle Kicks)	63	In Case You Didn't Know	3whuHq0yGx60atvA2RCVRW	Olly Murs	['dance pop', 'pop', 'talent show']	63	0.843	0.881	9	-3.951	1	0.0581	0.14	0	0.0765	0.876	110.621	202267	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	3SxiAdI8dP9AaaEz1Z24mn	Earthquake (feat. Tinie Tempah)	62	Electronic Earth (Expanded Edition)	2feDdbD5araYcm6JhFHHw7	Labrinth	['indie poptimism', 'pop']	77	0.54	0.856	0	-3.966	0	0.1	0.109	0	0.276	0.258	153.071	274600	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	0IF7bHzCXCZoKNog5vBC4g	Wherever You Will Go	60	Wherever You Will Go	0qk8MxMzgnfFECvDO3cc0X	Charlene Soraia	['neo-singer-songwriter']	39	0.597	0.115	9	-9.217	1	0.0334	0.82	0.000215	0.111	0.128	111.202	197577	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	1Fxp4LBWsNC58NwnGAXJld	Down With The Trumpets	60	Stereo Typical	2ajhZ7EA6Dec0kaWiKCApF	Rizzle Kicks	['uk hip hop']	49	0.753	0.88	4	-4.689	0	0.0806	0.087	0	0.24	0.794	115.057	186851	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	35KiiILklye1JRRctaLUb4	Holocene	59	Bon Iver	4LEiUm1SRbFMgfqnQTwUbQ	Bon Iver	['chamber pop', 'eau claire indie', 'indie folk', 'melancholia', 'modern rock']	74	0.374	0.304	1	-14.52	1	0.0302	0.943	0.298	0.126	0.147	147.969	336613	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	3FrX3mx8qq7SZX2NYbzDoj	Who's That Chick? (feat. Rihanna)	59	Who's That Chick?	1Cs0zKBU1kc0i8ypK3B9ai	David Guetta	['big room', 'dance pop', 'edm', 'pop', 'pop dance']	86	0.675	0.601	11	-4.733	0	0.116	0.00372	0	0.0458	0.931	127.938	201040	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	6y468DyY1V67RBNCwzrMrC	L.I.F.E.G.O.E.S.O.N.	58	Last Night On Earth	0aeLcja6hKzb7Uz2ou7ulP	Noah And The Whale	['stomp and holler']	49	0.603	0.745	4	-5.79	1	0.0368	0.207	0	0.348	0.606	81.981	228000	4
https://open.spotify.com/playlist/37i9dQZF1DXcagnSNtrGuJ	2011	7mdNKXxia7AeSuJqjjA2rb	Beautiful People	55	2010s Hits	7bXgB6jMjp9ATFy66eO08Z	Chris Brown	['pop rap', 'r&b', 'rap']	84	0.415	0.775	5	-6.366	0	0.161	0.0658	0.00431	0.0843	0.536	127.898	225881	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3w3y8KPTfNeOKPiqUTakBh	Locked out of Heaven	90	Unorthodox Jukebox	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.726	0.698	5	-4.165	1	0.0431	0.049	0	0.309	0.867	143.994	233478	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3TGRqZ0a2l1LRblBkJoaDx	Call Me Maybe	76	Kiss (Deluxe)	6sFIWsNpZYqfjUpaCgueju	Carly Rae Jepsen	['canadian pop', 'dance pop', 'pop']	72	0.783	0.58	7	-6.548	1	0.0408	0.0114	2.28e-06	0.108	0.66	120.021	193400	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	7a86XRg84qjasly9f6bPSD	We Are Young (feat. Janelle MonÃ¡e)	76	Some Nights	5nCi3BB41mBaMH9gfr6Su0	fun.	['baroque pop', 'metropopolis']	65	0.378	0.638	10	-5.576	1	0.075	0.02	7.66e-05	0.0849	0.735	184.086	250627	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1z9kQ14XBSN0r2v6fx4IdG	Diamonds	77	Unapologetic (Edited Version)	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.564	0.71	11	-4.92	0	0.0461	0.00125	0	0.109	0.393	91.972	225147	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4cluDES4hQEUhmXj6TXkSo	What Makes You Beautiful	86	Up All Night	4AK6F7OLvEQ5QYCBNiQWHq	One Direction	['boy band', 'pop', 'post-teen pop', 'talent show']	82	0.726	0.787	4	-2.494	1	0.0737	0.009	0	0.0596	0.888	124.99	199987	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6nek1Nin9q48AVZcWs9e9D	Paradise	86	Mylo Xyloto	4gzpq5DPGxSnKTe4SA8HAU	Coldplay	['permanent wave', 'pop']	86	0.449	0.585	5	-6.761	1	0.0268	0.0509	8.75e-05	0.0833	0.212	139.631	278719	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	2V65y3PX4DkRhy1djlxd9p	Don't You Worry Child - Radio Edit	84	Don't You Worry Child	1h6Cn3P4NGzXbaXidqURXs	Swedish House Mafia	['edm', 'pop dance', 'progressive electro house']	74	0.612	0.84	11	-3.145	0	0.0509	0.112	0	0.116	0.438	129.042	212862	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1gihuPhrLraKYrJMAEONyc	Feel So Close - Radio Edit	83	18 Months	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.707	0.924	7	-2.842	1	0.031	0.000972	0.00703	0.204	0.919	127.937	206413	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6VObnIkLVruX4UVyxWhlqm	Skyfall	83	Skyfall	4dpARuHxo51G3z768sgnrY	Adele	['british soul', 'pop', 'pop soul', 'uk pop']	83	0.346	0.552	0	-6.864	0	0.0282	0.417	0	0.114	0.0789	75.881	286480	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6lanRgr6wXibZr8KgzXxBl	A Thousand Years	83	A Thousand Years	7H55rcKCfwqkyDFH9wpKM6	Christina Perri	['pop']	69	0.421	0.407	10	-7.445	1	0.0267	0.309	0.000961	0.11	0.161	139.028	285120	3
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	5UqCQaDshqbIk3pkhy4Pjg	Levels - Radio Edit	82	Levels	1vCWHaC5f2uS3yhpwWbIA6	Avicii	['edm', 'pop', 'pop dance']	79	0.584	0.889	1	-5.941	0	0.0343	0.0462	0.828	0.309	0.464	126.04	199907	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	2iUmqdfGZcHIhS3b9E9EWq	Everybody Talks	81	Picture Show	0RpddSzUHfncUWNJXKOsjy	Neon Trees	['modern rock', 'neo mellow', 'pop rock', 'pov: indie']	63	0.471	0.924	8	-3.906	1	0.0586	0.00301	0	0.313	0.725	154.961	177280	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6FB3v4YcR57y4tXFcdxI1E	I Knew You Were Trouble.	81	Red (Big Machine Radio Release Special)	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.622	0.469	3	-6.798	0	0.0363	0.00454	2.25e-06	0.0335	0.679	77.019	219720	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0U10zFw4GlBacOy9VDGfGL	We Found Love	82	Talk That Talk	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.735	0.766	1	-4.485	1	0.0383	0.025	0.00138	0.108	0.6	127.985	215227	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0KAiuUOrLTIkzkpfpn9jb9	Drive By	80	California 37	3FUY2gzHeIiaesXtOAdB7A	Train	['dance pop', 'neo mellow', 'pop', 'pop rock']	71	0.765	0.837	1	-3.113	0	0.032	0.00107	1.06e-05	0.0801	0.721	122.028	195973	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1NpW5kyvO4XrNJ3rnfcNy3	Wild Ones (feat. Sia)	80	Wild Ones	0jnsk9HBra6NMjO2oANoPY	Flo Rida	['dance pop', 'miami hip hop', 'pop', 'pop rap']	76	0.608	0.86	5	-5.324	0	0.0554	0.0991	0	0.262	0.437	127.075	232947	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1auxYwYrFRqZP7t3s7w4um	Ni**as In Paris	77	Watch The Throne	3nFkdlSjzX9mRTtwJOzDYB	JAY-Z	['east coast hip hop', 'gangster rap', 'hip hop', 'pop rap', 'rap']	82	0.789	0.858	1	-5.542	1	0.311	0.127	0	0.349	0.775	140.022	219333	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4wCmqSrbyCgxEXROQE6vtV	Somebody That I Used To Know	77	Making Mirrors	2AsusXITU8P25dlRNhcAbG	Gotye	['australian pop']	65	0.864	0.495	0	-7.036	1	0.037	0.591	0.000133	0.0992	0.72	129.062	244973	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4Kz4RdRCceaA9VgTqBhBfa	The Motto	77	Take Care (Deluxe)	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.766	0.442	1	-8.558	1	0.356	0.000107	6.12e-05	0.111	0.39	201.8	181573	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1oHNvJVbFkexQc0BpQp7Y4	Starships	77	Pink Friday ... Roman Reloaded	0hCNtLu0JehylgoiP8L4Gh	Nicki Minaj	['hip pop', 'pop', 'queens hip hop', 'rap']	86	0.747	0.716	11	-2.457	0	0.075	0.135	0	0.251	0.751	125.008	210627	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	7oVEtyuv9NBmnytsCIsY5I	BURN IT DOWN	77	LIVING THINGS	6XyY86QOPPrYVGvF9ch6wz	Linkin Park	['alternative metal', 'nu metal', 'post-grunge', 'rap metal', 'rock']	83	0.585	0.972	9	-4.45	0	0.0534	0.0143	0	0.0707	0.585	110.006	230253	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6s8nHXTJVqFjXE4yVZPDHR	Troublemaker (feat. Flo Rida)	77	Right Place Right Time (Expanded Edition)	3whuHq0yGx60atvA2RCVRW	Olly Murs	['dance pop', 'pop', 'talent show']	63	0.762	0.863	0	-3.689	0	0.0561	0.015	0	0.125	0.965	106.012	185587	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1nZzRJbFvCEct3uzu04ZoL	Part Of Me	76	Teenage Dream: The Complete Confection	6jJ0s89eD6GaHleKKya26X	Katy Perry	['pop']	82	0.678	0.918	5	-4.63	1	0.0355	0.000417	0	0.0744	0.769	130.028	216160	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	03UrZgTINDqvnUMbbIMhql	Gangnam Style	76	Gangnam Style	2dd5mrQZvg6SmahdgVKDzh	PSY	['k-rap', 'korean old school hip hop']	62	0.727	0.937	11	-2.871	0	0.286	0.00417	0	0.091	0.749	132.067	219493	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0TAmnCzOtqRfvA38DDLTjj	Little Things	76	Take Me Home (Expanded Edition)	4AK6F7OLvEQ5QYCBNiQWHq	One Direction	['boy band', 'pop', 'post-teen pop', 'talent show']	82	0.709	0.22	7	-11.856	1	0.0327	0.811	0	0.175	0.53	110.076	219040	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	56sxN1yKg1dgOZXBcAHkJG	Gone, Gone, Gone	75	The World From The Side Of The Moon	6p5JxpTc7USNnBnLzctyd4	Phillip Phillips	['folk-pop', 'neo mellow', 'pop rock']	59	0.664	0.642	6	-5.961	1	0.038	0.129	0	0.114	0.501	118.002	209693	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4sOX1nhpKwFWPvoMMExi3q	Primadonna	74	Electra Heart (Deluxe)	6CwfuxIqcltXDGjfZsMd9A	MARINA	['metropopolis', 'pop', 'pov: indie', 'uk alternative pop']	70	0.66	0.689	4	-2.671	0	0.0337	0.0884	0	0.0922	0.427	127.98	221075	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3n69hLUdIsSa1WlRmjMZlW	Breezeblocks	74	An Awesome Wave	3XHO7cRUPCLOr6jwp8vsx5	alt-J	['indie rock', 'indietronica', 'modern alternative rock', 'modern rock', 'rock']	68	0.615	0.658	5	-7.299	1	0.0343	0.096	0.000911	0.205	0.293	150.093	227080	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3tyPOhuVnt5zd5kGfxbCyL	Where Have You Been	74	Talk That Talk	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.719	0.847	0	-6.34	0	0.0916	0.00201	0.0204	0.223	0.444	127.963	242680	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6Vh03bkEfXqekWp7Y1UBRb	Live While We're Young	76	Take Me Home (Expanded Edition)	4AK6F7OLvEQ5QYCBNiQWHq	One Direction	['boy band', 'pop', 'post-teen pop', 'talent show']	82	0.663	0.857	2	-2.16	1	0.0544	0.0542	0	0.144	0.931	126.039	200213	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4qikXelSRKvoCqFcHLB2H2	Mercy	74	Mercy	5K4W6rqBFWDnAN6FQUkS6x	Kanye West	['chicago rap', 'hip hop', 'rap']	89	0.563	0.496	6	-9.381	0	0.406	0.0685	5.8e-05	0.173	0.426	139.993	329320	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3oL3XRtkP1WVbMxf7dtTdu	The One That Got Away	73	Teenage Dream: The Complete Confection	6jJ0s89eD6GaHleKKya26X	Katy Perry	['pop']	82	0.687	0.792	1	-4.023	0	0.0353	0.000802	0	0.2	0.864	133.962	227333	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	53QF56cjZA9RTuuMZDrSA6	I Won't Give Up	73	Love Is a Four Letter Word (Deluxe Edition)	4phGZZrJZRo4ElhRtViYdl	Jason Mraz	['acoustic pop', 'dance pop', 'neo mellow', 'pop']	71	0.483	0.303	4	-10.058	1	0.0429	0.694	0	0.115	0.139	133.406	240166	3
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4P0osvTXoSYZZC2n8IFH3c	Payphone	73	Overexposed (Deluxe)	04gDigrS5kc9YWfZHwBETP	Maroon 5	['pop']	83	0.739	0.756	4	-4.828	1	0.0394	0.0136	0	0.37	0.523	110.028	231387	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1DunhgeZSEgWiIYbHqXl0c	Latch	73	Settle (Deluxe)	6nS5roXSAGhTGr34W6n7Et	Disclosure	['edm', 'house', 'indietronica', 'uk dance']	70	0.729	0.735	1	-5.455	1	0.0919	0.0178	0.000193	0.089	0.544	121.986	255867	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1EAgPzRbK9YmdOESSMUm6P	Home	73	The World From The Side Of The Moon	6p5JxpTc7USNnBnLzctyd4	Phillip Phillips	['folk-pop', 'neo mellow', 'pop rock']	59	0.606	0.826	0	-6.04	1	0.0307	0.0256	1.56e-05	0.117	0.322	121.04	210173	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6HZ9VeI5IRFCNQLXhpF4bq	I Love It (feat. Charli XCX)	73	THIS IS... ICONA POP	1VBflYyxBhnDc9uVib98rw	Icona Pop	['candy pop', 'dance pop', 'electropop', 'metropopolis', 'swedish electropop', 'swedish synthpop']	65	0.711	0.906	8	-2.671	1	0.0284	0.00952	1.64e-05	0.153	0.824	125.916	157153	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3sP3c86WFjOzHHnbhhZcLA	Give Your Heart a Break	72	Unbroken	6S2OmqARrzebs0tKUEyXyp	Demi Lovato	['pop', 'post-teen pop']	77	0.651	0.695	6	-3.218	1	0.0487	0.23	0	0.144	0.569	123.008	205347	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6VRhkROS2SZHGlp0pxndbJ	Bangarang (feat. Sirah)	72	Bangarang EP	5he5w2lnU9x7JFhnwcekXX	Skrillex	['brostep', 'complextro', 'edm', 'electro', 'pop dance']	75	0.716	0.972	7	-2.302	1	0.196	0.0145	3.22e-05	0.317	0.576	110.026	215253	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0lHAMNU8RGiIObScrsRgmP	Titanium (feat. Sia)	72	Nothing but the Beat 2.0	1Cs0zKBU1kc0i8ypK3B9ai	David Guetta	['big room', 'dance pop', 'edm', 'pop', 'pop dance']	86	0.604	0.788	0	-3.673	0	0.103	0.0678	0.153	0.127	0.301	126.06	245040	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4HXOBjwv2RnLpGG4xWOO6N	Princess of China	72	Mylo Xyloto	4gzpq5DPGxSnKTe4SA8HAU	Coldplay	['permanent wave', 'pop']	86	0.42	0.69	9	-6.221	0	0.0347	0.00385	0.015	0.287	0.237	85.014	239216	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	2sEk5R8ErGIFxbZ7rX6S2S	How to Be a Heartbreaker	71	Electra Heart (Deluxe)	6CwfuxIqcltXDGjfZsMd9A	MARINA	['metropopolis', 'pop', 'pov: indie', 'uk alternative pop']	70	0.69	0.897	11	-4.696	0	0.0506	0.0142	0	0.108	0.849	140.05	221493	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6KuHjfXHkfnIjdmcIvt9r0	On Top Of The World	71	Night Visions (Deluxe)	53XhwfbYqKCa1cC15pYq2q	Imagine Dragons	['modern rock', 'pop', 'rock']	86	0.635	0.926	0	-5.589	1	0.151	0.0893	4.53e-06	0.0928	0.761	100.048	189840	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6t6oULCRS6hnI7rm0h5gwl	Some Nights	71	Some Nights	5nCi3BB41mBaMH9gfr6Su0	fun.	['baroque pop', 'metropopolis']	65	0.672	0.738	0	-7.045	1	0.0506	0.0178	6.75e-05	0.0927	0.392	107.938	277040	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	5g7rJvWYVrloJZwKiShqlS	Dirty Paws	71	My Head Is An Animal	4dwdTW1Lfiq0cM8nBAqIIz	Of Monsters and Men	['folk-pop', 'metropopolis', 'modern rock', 'stomp and holler']	66	0.359	0.649	3	-7.06	1	0.0349	0.107	0.0124	0.0555	0.133	111.709	278373	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	5ujh1I7NZH5agbwf7Hp8Hc	Swimming Pools (Drank) - Extended Version	71	good kid, m.A.A.d city (Deluxe)	2YZyLoL8N0Wb9xBt1NhZWg	Kendrick Lamar	['conscious hip hop', 'hip hop', 'rap', 'west coast rap']	86	0.716	0.485	1	-7.745	1	0.404	0.123	2.69e-05	0.604	0.26	74.132	313787	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0RUGuh2uSNFJpGMSsD1F5C	It Will Rain	71	The Twilight Saga: Breaking Dawn - Part 1 (Original Motion Picture Soundtrack)	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.576	0.835	2	-6.826	1	0.0486	0.337	0	0.082	0.476	150.017	257720	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3WD91HQDBIavSapet3ZpjG	Video Games	71	Born To Die â€“ Paradise Edition (Special Version)	00FQb4jTyendYWaN8pK0wa	Lana Del Rey	['art pop', 'pop']	89	0.39	0.252	6	-9.666	0	0.0298	0.808	0	0.0887	0.181	122.053	281947	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	25cUhiAod71TIQSNicOaW3	Adorn	71	Kaleidoscope Dream	360IAlyVv4PCEVjgyMZrxK	Miguel	['r&b']	77	0.625	0.576	11	-5.693	0	0.175	0.0543	4.07e-05	0.187	0.235	179.063	193147	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	5NlFXQ0si6U87gXs6hq81B	Candy	71	Take The Crown (Deluxe Edition)	2HcwFjNelS49kFbfvMxQYw	Robbie Williams	['dance rock', 'europop']	69	0.715	0.791	10	-6.63	1	0.0414	0.0368	0	0.0694	0.879	116.043	201053	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	2EcsgXlxz99UMDSPg5T8RF	Beneath Your Beautiful (feat. Emeli SandÃ©)	70	Electronic Earth (Expanded Edition)	2feDdbD5araYcm6JhFHHw7	Labrinth	['indie poptimism', 'pop']	77	0.561	0.522	2	-5.857	1	0.0318	0.227	0	0.104	0.238	83.962	271813	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4kte3OcW800TPvOVgrLLj8	Let Me Love You (Until You Learn To Love Yourself)	70	R.E.D. (Deluxe Edition)	21E3waRsmPlU7jZsS13rcj	Ne-Yo	['dance pop', 'pop', 'r&b', 'urban contemporary']	77	0.658	0.677	5	-6.628	1	0.0393	0.248	0	0.368	0.248	124.91	251627	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	68rcszAg5pbVaXVvR7LFNh	One Day / Reckoning Song (Wankelmut Remix) - Radio Edit	70	One Day / Reckoning Song (Wankelmut Remix)	7t51dSX8ZkKC7VoKRd0lME	Asaf Avidan	['israeli pop', 'israeli rock']	56	0.826	0.668	3	-6.329	0	0.0571	0.223	6.92e-05	0.167	0.534	118.99	215187	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	5JLv62qFIS1DR3zGEcApRt	Wide Awake	70	Teenage Dream: The Complete Confection	6jJ0s89eD6GaHleKKya26X	Katy Perry	['pop']	82	0.514	0.683	5	-5.099	1	0.0367	0.0749	2.64e-06	0.392	0.575	159.814	220947	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	4b4c0oH7PtrPsI86drzgFs	Chasing The Sun	70	The Wanted (Special Edition)	2NhdGz9EDv2FeUw6udu2g1	The Wanted	['boy band', 'dance pop', 'pop', 'post-teen pop']	63	0.637	0.732	7	-6.209	0	0.0965	0.244	0	0.498	0.68	128.108	198800	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	439TlnnznSiBbQbgXiBqAd	m.A.A.d city	70	good kid, m.A.A.d city	2YZyLoL8N0Wb9xBt1NhZWg	Kendrick Lamar	['conscious hip hop', 'hip hop', 'rap', 'west coast rap']	86	0.487	0.729	2	-6.815	1	0.271	0.0538	4.07e-06	0.44	0.217	91.048	350120	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0MOiv7WTXCqvm89lVCf9C8	Million Voices - Radio Edit	70	Million Voices	5fahUm8t5c0GIdeTq0ZaG8	Otto Knows	['dutch house', 'edm', 'electro house', 'pop dance', 'progressive electro house', 'progressive house']	59	0.582	0.894	8	-6.298	1	0.041	0.0022	0.0223	0.0664	0.0694	125.946	192867	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0c4IEciLCDdXEhhKxj4ThA	Madness	70	The 2nd Law	12Chz98pHFMPJEknJQMWvI	Muse	['alternative rock', 'modern rock', 'permanent wave', 'rock']	73	0.502	0.417	10	-7.665	1	0.0718	0.127	0.00419	0.106	0.218	180.301	281040	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	5wEreUfwxZxWnEol61ulIi	Born To Die	69	Born To Die â€“ Paradise Edition (Special Version)	00FQb4jTyendYWaN8pK0wa	Lana Del Rey	['art pop', 'pop']	89	0.393	0.634	4	-6.629	0	0.0378	0.2	0.000166	0.198	0.395	85.767	286253	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	2NniAhAtkRACaMeYt48xlD	50 Ways to Say Goodbye	69	California 37	3FUY2gzHeIiaesXtOAdB7A	Train	['dance pop', 'neo mellow', 'pop', 'pop rock']	71	0.591	0.935	6	-2.664	1	0.0478	0.000284	0.000278	0.142	0.736	140.043	247947	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	6j7hih15xG2cdYwIJnQXsq	Not Over You	67	Sweeter	5DYAABs8rkY9VhwtENoQCz	Gavin DeGraw	['neo mellow', 'pop rock']	59	0.63	0.894	10	-4.592	1	0.0544	0.255	0	0.181	0.364	142.051	218520	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	06h3McKzmxS8Bx58USHiMq	Silhouettes - Original Radio Edit	67	Silhouettes	1vCWHaC5f2uS3yhpwWbIA6	Avicii	['edm', 'pop', 'pop dance']	79	0.605	0.8	5	-6.235	0	0.0545	0.155	0.0562	0.121	0.836	128.074	211880	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0obBFrPYkSoBJbvHfUIhkv	Sexy And I Know It	66	Sorry For Party Rocking (Deluxe Version)	3sgFRtyBnxXD5ESfmbK4dl	LMFAO	['dance pop', 'pop', 'pop rap']	65	0.707	0.861	7	-4.225	1	0.316	0.1	0	0.191	0.795	130.021	199480	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0ZyfiFudK9Si2n2G9RkiWj	Ride	66	Born To Die â€“ Paradise Edition (Special Version)	00FQb4jTyendYWaN8pK0wa	Lana Del Rey	['art pop', 'pop']	89	0.373	0.686	0	-5.52	1	0.034	0.128	1.96e-06	0.383	0.189	93.763	289080	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	78JKJfKsqgeBDBF58gv1SF	Hands on the Wheel (feat. Asap Rocky)	66	Habits & Contradictions	5IcR3N7QB1j6KBL8eImZ8m	ScHoolboy Q	['gangster rap', 'hip hop', 'pop rap', 'rap', 'southern hip hop', 'trap']	70	0.646	0.784	1	-7.471	0	0.108	0.0166	0	0.0721	0.179	127.839	197132	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	7B1Dl3tXqySkB8OPEwVvSu	We'll Be Coming Back (feat. Example)	66	18 Months	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.596	0.952	7	-4.364	1	0.0873	0.00131	0	0.598	0.571	127.945	234360	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	28GUjBGqZVcAV4PHSYzkj2	So Good	66	Strange Clouds	5ndkK3dpZLKtBklKjxNQwT	B.o.B	['atl hip hop', 'dance pop', 'pop rap', 'rap', 'southern hip hop']	71	0.66	0.9	7	-5.02	1	0.14	0.0403	0	0.219	0.591	85.51	213253	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	5kcE7pp02ezLZaUbbMv3Iq	Pound The Alarm	66	Pink Friday ... Roman Reloaded (Deluxe)	0hCNtLu0JehylgoiP8L4Gh	Nicki Minaj	['hip pop', 'pop', 'queens hip hop', 'rap']	86	0.728	0.858	9	-3.686	1	0.0609	0.0403	4.09e-06	0.0241	0.591	125.055	205640	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	1RMRkCn07y2xtBip9DzwmC	Turn Up the Music	65	Fortune (Expanded Edition)	7bXgB6jMjp9ATFy66eO08Z	Chris Brown	['pop rap', 'r&b', 'rap']	84	0.594	0.841	1	-5.792	1	0.102	0.000238	2.22e-06	0.156	0.643	129.925	227973	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3zsRP8rH1kaIAo9fmiP4El	Angels	65	Coexist	3iOvXCl6edW5Um0fXEBRXy	The xx	['downtempo', 'dream pop', 'indietronica']	64	0.424	0.157	9	-18.141	1	0.0428	0.95	0.0593	0.101	0.342	91.537	171653	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	0vFMQi8ZnOM2y8cuReZTZ2	Blown Away	65	Blown Away	4xFUf1FHVy696Q1JQZMTRj	Carrie Underwood	['classic oklahoma country', 'contemporary country', 'country', 'country dawn', 'country road', 'dance pop']	70	0.531	0.843	9	-2.569	0	0.0429	0.0909	0	0.0283	0.392	136.991	240133	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	2L7rZWg9RLxIwnysmxm4xk	Boyfriend	65	Believe (Deluxe Edition)	1uNFoZAHBGtllmzznpCI3s	Justin Bieber	['canadian pop', 'pop']	87	0.717	0.55	10	-6.019	0	0.0519	0.0358	0.00198	0.126	0.331	96.979	171333	4
https://open.spotify.com/playlist/37i9dQZF1DX0yEZaMOXna3	2012	3e0yTP5trHBBVvV32jwXqF	Anna Sun	65	Walk The Moon	6DIS6PRrLS3wbnZsf7vYic	WALK THE MOON	['dance rock', 'modern rock', 'pop']	67	0.472	0.844	10	-6.578	1	0.054	0.00173	0	0.24	0.34	140.034	321280	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	4rHZZAmHpZrA3iH5zx8frV	Mirrors	81	The 20/20 Experience (Deluxe Version)	31TPClRtHm23RisEBtV3X7	Justin Timberlake	['dance pop', 'pop']	78	0.574	0.512	5	-6.664	0	0.0503	0.234	0	0.0946	0.512	76.899	484147	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5PUvinSo4MNqW7vmomGRS7	Blurred Lines	58	Blurred Lines	0ZrpamOxcZybMHGg1AYtHP	Robin Thicke	['dance pop', 'neo soul', 'pop rap', 'r&b', 'urban contemporary']	61	0.861	0.504	7	-7.707	1	0.0489	0.00412	1.78e-05	0.0783	0.881	120	263053	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	2dLLR6qlu5UJ5gk0dKz0h3	Royals	82	Pure Heroine	163tK9Wjr9P9DmM0AVK7lm	Lorde	['art pop', 'metropopolis', 'nz pop', 'pop']	74	0.674	0.428	7	-9.504	1	0.122	0.121	0	0.132	0.337	84.878	190185	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	2QjOHCTQ1Jl3zawyYOpxh6	Sweater Weather	91	I Love You.	77SW9BnxLY8rJ0RciFqkHh	The Neighbourhood	['modern alternative rock', 'modern rock', 'pop']	81	0.612	0.807	10	-2.81	1	0.0336	0.0495	0.0177	0.101	0.398	124.053	240400	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	3JvKfv6T31zO0ini8iNItO	Another Love	91	Long Way Down (Deluxe)	2txHhyCwHjUEpJjWrEyqyX	Tom Odell	['chill pop']	73	0.445	0.537	4	-8.532	0	0.04	0.695	1.65e-05	0.0944	0.131	122.769	244360	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	3w3y8KPTfNeOKPiqUTakBh	Locked out of Heaven	90	Unorthodox Jukebox	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.726	0.698	5	-4.165	1	0.0431	0.049	0	0.309	0.867	143.994	233478	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	0nrRP2bk19rLc0orkWPQk2	Wake Me Up	88	TRUE	1vCWHaC5f2uS3yhpwWbIA6	Avicii	['edm', 'pop', 'pop dance']	79	0.532	0.783	2	-5.697	1	0.0523	0.0038	0.0012	0.161	0.643	124.08	247427	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5FVd6KXrgO9B3JPmC8OPst	Do I Wanna Know?	89	AM	7Ln80lUS6He07XvHI8qqHH	Arctic Monkeys	['garage rock', 'modern rock', 'permanent wave', 'rock', 'sheffield indie']	84	0.548	0.532	5	-7.596	1	0.0323	0.186	0.000263	0.217	0.405	85.03	272394	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	6Z8R6UsFuGXGtiIxiD8ISb	Safe And Sound	85	In A Tidal Wave Of Mystery (Deluxe Edition)	4gwpcMTbLWtBUlOijbVpuu	Capital Cities	['metropopolis', 'modern rock']	64	0.655	0.819	0	-4.852	1	0.0316	0.000176	0.00374	0.104	0.766	117.956	192790	5
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	4G8gkOterJn0Ywt6uhqbhp	Radioactive	75	Night Visions	53XhwfbYqKCa1cC15pYq2q	Imagine Dragons	['modern rock', 'pop', 'rock']	86	0.448	0.784	9	-3.686	1	0.0627	0.106	0.000108	0.668	0.236	136.245	186813	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	0nJW01T7XtvILxQgC5J7Wh	When I Was Your Man	89	Unorthodox Jukebox	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.612	0.28	0	-8.648	1	0.0434	0.932	0	0.088	0.387	72.795	213827	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	2XHzzp1j4IfTNp1FTn7YFg	Love Me	84	I Am Not A Human Being II (Deluxe)	55Aa2cqylxrFIXC767Z865	Lil Wayne	['hip hop', 'new orleans rap', 'pop rap', 'rap', 'trap']	84	0.669	0.634	11	-6.476	1	0.0327	0.0125	0	0.0946	0.496	124.906	255053	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	1mKXFLRA179hdOWQBwUk9e	Just Give Me a Reason (feat. Nate Ruess)	84	The Truth About Love	1KCSPY1glIKqW2TotWuXOR	P!nk	['dance pop', 'pop']	79	0.778	0.547	2	-7.273	1	0.0489	0.346	0.000302	0.132	0.441	95.002	242733	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	1yjY7rpaAQvKwpdUliHx0d	Still into You	83	Paramore	74XFHRwlV6OrjEM0A2NCMF	Paramore	['candy pop', 'pixie', 'pop', 'pop emo', 'pop punk', 'rock']	77	0.602	0.923	5	-3.763	1	0.044	0.0098	0	0.0561	0.765	136.01	216013	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	3bidbhpOYeV4knp8AIu8Xn	Can't Hold Us (feat. Ray Dalton)	83	The Heist	5BcAKTbp20cv7tC5VqPFoC	Macklemore & Ryan Lewis	['pop rap', 'seattle hip hop']	72	0.641	0.922	2	-4.457	1	0.0786	0.0291	0	0.0862	0.847	146.078	258343	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	2Foc5Q5nqNiosCNqttzHof	Get Lucky (Radio Edit) [feat. Pharrell Williams and Nile Rodgers]	83	Get Lucky (Radio Edit) [feat. Pharrell Williams and Nile Rodgers]	4tZwfgrHOc3mvqYlEYSvVi	Daft Punk	['electro', 'filter house', 'rock']	79	0.794	0.811	6	-8.966	0	0.038	0.0426	1.07e-06	0.101	0.862	116.047	248413	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	086myS9r57YsLbJpU0TgK9	Why'd You Only Call Me When You're High?	89	AM	7Ln80lUS6He07XvHI8qqHH	Arctic Monkeys	['garage rock', 'modern rock', 'permanent wave', 'rock', 'sheffield indie']	84	0.691	0.631	2	-6.478	1	0.0368	0.0483	1.13e-05	0.104	0.8	92.004	161124	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	6lanRgr6wXibZr8KgzXxBl	A Thousand Years	83	A Thousand Years	7H55rcKCfwqkyDFH9wpKM6	Christina Perri	['pop']	69	0.421	0.407	10	-7.445	1	0.0267	0.309	0.000961	0.11	0.161	139.028	285120	3
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	190jyVPHYjAqEaOGmMzdyk	Beauty And A Beat	83	Believe (Deluxe Edition)	1uNFoZAHBGtllmzznpCI3s	Justin Bieber	['canadian pop', 'pop']	87	0.602	0.843	0	-4.831	1	0.0593	0.000688	5.27e-05	0.0682	0.526	128.003	227987	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	2vwlzO0Qp8kfEtzTsCXfyE	Wrecking Ball	82	Bangerz (Deluxe Version)	5YGY8feqx7naU7z4HrwZM6	Miley Cyrus	['pop']	85	0.53	0.422	5	-6.262	1	0.0342	0.407	0	0.107	0.349	119.964	221360	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	55h7vJchibLdUkxdlX3fK7	Treasure	83	Unorthodox Jukebox	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.874	0.692	5	-5.28	0	0.0431	0.0412	7.24e-05	0.324	0.937	116.017	178560	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	0NlGoUyOJSuSHmngoibVAs	All I Want	82	In A Perfect World (Expanded Edition)	4BxCuXFJrSWGi1KHcVqaU4	Kodaline	['irish pop', 'modern rock']	67	0.188	0.411	0	-9.733	1	0.0484	0.174	0.153	0.0843	0.159	187.376	305747	3
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	2ihCaVdNZmnHZWt0fvAM7B	Little Talks	82	My Head Is An Animal	4dwdTW1Lfiq0cM8nBAqIIz	Of Monsters and Men	['folk-pop', 'metropopolis', 'modern rock', 'stomp and holler']	66	0.457	0.757	1	-5.177	1	0.032	0.0206	0	0.146	0.417	102.961	266600	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	6CjtS2JZH9RkDz5UVInsa9	Thrift Shop (feat. Wanz)	81	The Heist	5BcAKTbp20cv7tC5VqPFoC	Macklemore & Ryan Lewis	['pop rap', 'seattle hip hop']	72	0.781	0.526	6	-6.986	0	0.293	0.0633	0	0.0457	0.665	94.993	235613	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	6FB3v4YcR57y4tXFcdxI1E	I Knew You Were Trouble.	81	Red (Big Machine Radio Release Special)	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.622	0.469	3	-6.798	0	0.0363	0.00454	2.25e-06	0.0335	0.679	77.019	219720	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5cc9Zbfp9u10sfJeKZ3h16	3005	80	Because the Internet	73sIBHcqh3Z3NyqHKZ7FOL	Childish Gambino	['atl hip hop', 'hip hop', 'rap']	77	0.664	0.447	6	-7.272	0	0.289	0.112	0	0.091	0.659	83.138	234215	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5CMjjywI0eZMixPeqNd75R	Lose Yourself to Dance (feat. Pharrell Williams)	70	Random Access Memories	4tZwfgrHOc3mvqYlEYSvVi	Daft Punk	['electro', 'filter house', 'rock']	79	0.832	0.659	10	-7.828	0	0.057	0.0839	0.00114	0.0753	0.674	100.163	353893	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5DI9jxTHrEiFAhStG7VA8E	Started From the Bottom	70	Nothing Was The Same	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.793	0.524	8	-7.827	1	0.156	0.0319	0	0.156	0.579	86.325	174133	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	0qwcGscxUHGZTgq0zcaqk1	Here's to Never Growing Up	70	Avril Lavigne (Expanded Edition)	0p4nmQO2msCgU4IF37Wi3j	Avril Lavigne	['canadian pop', 'candy pop', 'pop']	73	0.482	0.873	0	-3.145	1	0.0853	0.0111	0	0.409	0.737	165.084	214320	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	0S4RKPbRDA72tvKwVdXQqe	The Way	70	Yours Truly	66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	['pop']	87	0.645	0.878	5	-3.208	0	0.113	0.294	0	0.076	0.862	82.324	227027	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	0mvkwaZMP2gAy2ApQLtZRv	It's a Beautiful Day	69	To Be Loved	1GxkXlMwML1oSg5eLPiAz3	Michael BublÃ©	['adult standards', 'canadian pop', 'jazz pop', 'lounge']	71	0.532	0.795	1	-3.979	1	0.0358	0.0559	0	0.295	0.78	143.837	199267	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	1KtD0xaLAikgIt5tPbteZQ	Thinking About You (feat. Ayah Marar)	69	18 Months	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.725	0.874	0	-3.715	0	0.0396	0.00262	0.000412	0.0958	0.748	127.985	247933	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5jyUBKpmaH670zrXrE0wmO	Reload - Radio Edit	69	Reload (Vocal Version / Radio Edit)	6hyMWrxGBsOx6sWcVj1DqP	Sebastian Ingrosso	['dutch house', 'edm', 'electro house', 'pop dance', 'progressive electro house', 'progressive house']	60	0.485	0.724	9	-4.633	0	0.0521	0.0736	0	0.0631	0.433	128.045	221273	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	6KkyuDhrEhR5nJVKtv9mCf	High Hopes	68	In A Perfect World (Expanded Edition)	4BxCuXFJrSWGi1KHcVqaU4	Kodaline	['irish pop', 'modern rock']	67	0.488	0.487	4	-6.371	1	0.0305	0.577	0	0.193	0.219	77.278	230267	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	3Tu7uWBecS6GsLsL8UONKn	Don't Stop the Party (feat. TJR)	68	Global Warming: Meltdown (Deluxe Version)	0TnOYISbd1XYRBk9myaseg	Pitbull	['dance pop', 'miami hip hop', 'pop']	81	0.722	0.958	4	-3.617	1	0.0912	0.00726	0	0.375	0.952	127.008	206120	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	01TuObJVd7owWchVRuQbQw	#thatPOWER	68	#willpower (Deluxe)	085pc2PYOi8bGKj0PNjekA	will.i.am	['dance pop', 'pop']	71	0.797	0.608	6	-6.096	0	0.0584	0.00112	7.66e-05	0.0748	0.402	127.999	279507	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5VSCgNlSmTV2Yq5lB40Eaw	Love Me Again	68	Tribute	34v5MVKeQnIo0CWYMbbrPf	John Newman	['dance pop']	67	0.495	0.894	2	-4.814	0	0.0441	0.00453	0.000596	0.103	0.213	126.03	239894	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	2QD4C6RRHgRNRAyrfnoeAo	Play Hard (feat. Ne-Yo & Akon)	63	Nothing but the Beat 2.0	1Cs0zKBU1kc0i8ypK3B9ai	David Guetta	['big room', 'dance pop', 'edm', 'pop', 'pop dance']	86	0.691	0.921	8	-1.702	0	0.0535	0.174	0	0.331	0.802	130.072	201000	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	1oHxIPqJyvAYHy0PVrDU98	Drinking from the Bottle (feat. Tinie Tempah)	62	18 Months	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.665	0.886	9	-4.175	0	0.0514	0.0469	6.24e-05	0.0525	0.53	128.062	240347	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	1zVhMuH7agsRe6XkljIY4U	human	62	human	7H55rcKCfwqkyDFH9wpKM6	Christina Perri	['pop']	69	0.439	0.489	8	-6.286	1	0.0368	0.132	0.000643	0.114	0.253	143.808	250707	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5zdkUzguZYAfBH9fnWn3Zl	Need U (100%) (feat. A*M*E) - Radio Edit	61	Need U (100%) (feat. A*M*E) [Remixes]	61lyPtntblHJvA7FMMhi7E	Duke Dumont	['edm', 'house', 'pop dance', 'progressive house', 'uk dance']	63	0.67	0.848	0	-5.103	0	0.0538	0.00172	0.00168	0.385	0.457	124.031	174122	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5FljCWR0cys07PQ9277GTz	The Other Side	61	Talk Dirty	07YZf4WDAMNwqr4jfgOZ8y	Jason Derulo	['dance pop', 'pop']	77	0.561	0.836	9	-3.939	1	0.1	0.0525	0	0.136	0.517	127.923	226987	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5BhsEd82G0Mnim0IUH6xkT	Cruise	61	Here's To The Good Times	3b8QkneNDz4JHKKKlLgYZg	Florida Georgia Line	['contemporary country', 'country', 'country pop', 'country road', 'modern country rock']	73	0.457	0.948	10	-3.364	1	0.0354	0.0191	0	0.0536	0.878	148	208960	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	0s0JMUkb2WCxIJsRB3G7Hd	Dear Darlin'	61	Right Place Right Time (Expanded Edition)	3whuHq0yGx60atvA2RCVRW	Olly Murs	['dance pop', 'pop', 'talent show']	63	0.512	0.828	11	-4.672	0	0.0454	0.00627	8.73e-06	0.119	0.34	124.021	206373	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	52gvlDnre9craz9dKGObp8	La La La	60	La La La	1bT7m67vi78r2oqvxrP3X5	Naughty Boy	['uk contemporary r&b']	58	0.754	0.677	6	-4.399	0	0.0316	0.112	0	0.111	0.254	124.988	220779	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	5vL0yvddknhGj7IrBc6UTj	This Is How We Do	60	PRISM (Deluxe)	6jJ0s89eD6GaHleKKya26X	Katy Perry	['pop']	82	0.69	0.636	9	-6.028	0	0.0457	0.0203	0	0.147	0.8	96	204285	4
https://open.spotify.com/playlist/37i9dQZF1DX3Sp0P28SIer	2013	2FV7Exjr70J652JcGucCtE	The Mother We Share	59	The Bones of What You Believe	3CjlHNtplJyTf9npxaPl5w	CHVRCHES	['indietronica', 'metropopolis', 'neo-synthpop', 'shimmer pop']	61	0.45	0.677	1	-6.428	1	0.0313	0.0319	3.02e-06	0.126	0.324	174.027	191294	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	5O2P9iiztwhomNh8xkR9lJ	Night Changes	89	FOUR (Deluxe)	4AK6F7OLvEQ5QYCBNiQWHq	One Direction	['boy band', 'pop', 'post-teen pop', 'talent show']	82	0.672	0.52	8	-7.747	1	0.0353	0.859	0	0.115	0.37	120.001	226600	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	2tpWsVSb9UEmDRxAl1zhX1	Counting Stars	88	Native	5Pwc4xIPtQLFEnJriah9YJ	OneRepublic	['piano rock', 'pop']	81	0.664	0.705	1	-4.972	0	0.0382	0.0654	0	0.118	0.477	122.016	257267	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	0FDzzruyVECATHXKHFs9eJ	A Sky Full of Stars	87	Ghost Stories	4gzpq5DPGxSnKTe4SA8HAU	Coldplay	['permanent wave', 'pop']	86	0.545	0.675	6	-6.474	1	0.0279	0.00617	0.00197	0.209	0.162	124.97	267867	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	1HNkqx9Ahdgi1Ixy2xkKkL	Photograph	87	x (Deluxe Edition)	6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	['pop', 'singer-songwriter pop', 'uk pop']	87	0.614	0.379	4	-10.48	1	0.0476	0.607	0.000464	0.0986	0.201	107.989	258987	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	3U4isOIWM3VvDubwSI3y7a	All of Me	87	Love In The Future (Expanded Edition)	5y2Xq6xcjJb2jVM54GHK3t	John Legend	['neo soul', 'pop', 'pop soul', 'urban contemporary']	73	0.422	0.264	8	-7.064	1	0.0322	0.922	0	0.132	0.331	119.93	269560	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	7795WJLVKJoAyVoOtCWqXN	I'm Not The Only One	86	In The Lonely Hour	2wY79sveU1sp5g7SokKOiI	Sam Smith	['pop', 'uk pop']	83	0.677	0.485	5	-5.795	1	0.0361	0.529	2.04e-05	0.0766	0.493	82.001	239317	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	4gbVRS8gloEluzf0GzDOFc	Maps	86	V	04gDigrS5kc9YWfZHwBETP	Maroon 5	['pop']	83	0.742	0.713	1	-5.522	0	0.0303	0.0205	0	0.059	0.879	120.032	189960	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	6YUTL4dYpB9xZO5qExPf05	Summer	85	Motion	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.596	0.856	4	-3.556	0	0.0346	0.0211	0.0178	0.141	0.743	127.949	222533	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	3cHyrEgdyYRjgJKSOiOtcS	Timber (feat. Ke$ha)	84	Global Warming: Meltdown (Deluxe Version)	0TnOYISbd1XYRBk9myaseg	Pitbull	['dance pop', 'miami hip hop', 'pop']	81	0.581	0.963	11	-4.087	1	0.0981	0.0295	0	0.139	0.788	129.992	204160	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	4nVBt6MZDDP6tRVdQTgxJg	Story of My Life	84	Midnight Memories (Deluxe)	4AK6F7OLvEQ5QYCBNiQWHq	One Direction	['boy band', 'pop', 'post-teen pop', 'talent show']	82	0.6	0.663	3	-5.802	1	0.0477	0.225	0	0.119	0.286	121.07	245493	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	6RtPijgfPKROxEzTHNRiDp	Rude	84	Don't Kill the Magic	0DxeaLnv6SyYk2DOqkLO8c	MAGIC!	['pop', 'reggae fusion']	65	0.773	0.758	1	-4.993	1	0.0381	0.0422	0	0.305	0.925	144.033	224840	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	62ke5zFUJN6RvtXZgVH0F8	Only Love Can Hurt Like This	83	A Perfect Contradiction (Outsiders' Expanded Edition)	4fwuXg6XQHfdlOdmw36OHa	Paloma Faith	['british soul', 'talent show']	65	0.566	0.885	8	-4.528	1	0.0818	0.0958	9.97e-05	0.334	0.304	90.99	232893	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	34gCuhDGsG4bRPIf9bb02f	Thinking out Loud	85	x (Deluxe Edition)	6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	['pop', 'singer-songwriter pop', 'uk pop']	87	0.781	0.445	2	-6.061	1	0.0295	0.474	0	0.184	0.591	78.998	281560	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	5Nm9ERjJZ5oyfXZTECKmRt	Stay With Me	85	In The Lonely Hour	2wY79sveU1sp5g7SokKOiI	Sam Smith	['pop', 'uk pop']	83	0.418	0.42	0	-6.444	1	0.0414	0.588	6.39e-05	0.11	0.184	84.094	172724	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	6FE2iI43OZnszFLuLtvvmg	Classic	83	MKTO	2l35CQqtYRh3d8ZIiBep4v	MKTO	['pop', 'post-teen pop']	64	0.72	0.791	1	-4.689	1	0.124	0.0384	0	0.157	0.756	102.071	175427	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	2iuZJX9X9P0GKaE93xcPjk	Sugar	83	V	04gDigrS5kc9YWfZHwBETP	Maroon 5	['pop']	83	0.748	0.788	1	-7.055	1	0.0334	0.0591	0	0.0863	0.884	120.076	235493	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	60nZcImufyMA1MKQY3dcCH	Happy - From "Despicable Me 2"	83	G I R L	2RdwBSPQiwcmiDo9kixcl8	Pharrell Williams	['dance pop', 'pop']	77	0.647	0.822	5	-4.662	0	0.183	0.219	0	0.0908	0.962	160.019	232720	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	2ixsaeFioXJmMgkkbd4uj1	Budapest	82	Wanted on Voyage (Expanded Edition)	2ysnwxxNtSgbb9t1m2Ur4j	George Ezra	['folk-pop', 'neo-singer-songwriter']	72	0.717	0.455	5	-8.303	1	0.0276	0.0846	0	0.11	0.389	127.812	200733	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	5Hroj5K7vLpIG4FNCRIjbP	Best Day Of My Life	82	Oh, What A Life	0MlOPi3zIDMVrfA9R04Fe3	American Authors	['modern rock', 'pop rock']	64	0.673	0.902	2	-2.392	1	0.0346	0.0591	0.000262	0.0558	0.538	100.012	194240	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	2Bs4jQEGMycglOfWPBqrVG	Steal My Girl	82	FOUR (Deluxe)	4AK6F7OLvEQ5QYCBNiQWHq	One Direction	['boy band', 'pop', 'post-teen pop', 'talent show']	82	0.536	0.768	10	-5.948	0	0.0347	0.00433	0	0.114	0.545	77.217	228133	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	0puf9yIluy9W0vpMEUoAnN	Bang Bang	81	Sweet Talker (Deluxe Version)	2gsggkzM5R49q6jpPvazou	Jessie J	['dance pop', 'pop']	69	0.706	0.786	0	-3.417	0	0.091	0.26	0	0.38	0.751	150.028	199387	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	7vS3Y0IKjde7Xg85LWIEdP	Problem	77	My Everything (Deluxe)	66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	['pop']	87	0.66	0.805	1	-5.352	0	0.153	0.0192	8.83e-06	0.159	0.625	103.008	193920	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	4N1MFKjziFHH4IS3RYYUrU	My Love	76	My Love	1dgdvbogmctybPrGEcnYf6	Route 94	['house', 'uk dance']	55	0.813	0.616	8	-7.571	1	0.0495	0.000132	0.705	0.0658	0.744	119.977	259934	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	5lF0pHbsJ0QqyIrLweHJPW	Burn	75	Halcyon Nights	0X2BH1fck6amBIoJhDVmmJ	Ellie Goulding	['indietronica', 'metropopolis', 'pop', 'uk pop']	78	0.555	0.772	1	-5.007	1	0.0523	0.315	0	0.105	0.346	86.921	231213	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	5jE48hhRu8E6zBDPRSkEq7	All About That Bass	75	Title (Deluxe)	6JL8zeS1NmiOftqZTRgdTz	Meghan Trainor	['hip pop', 'pop']	75	0.807	0.887	9	-3.726	1	0.0503	0.0573	2.87e-06	0.124	0.961	134.052	187920	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	5BrTUo0xP1wKXLJWUaGFtk	Loyal (feat. Lil Wayne & Tyga)	75	X (Expanded Edition)	7bXgB6jMjp9ATFy66eO08Z	Chris Brown	['pop rap', 'r&b', 'rap']	84	0.841	0.522	10	-5.963	0	0.049	0.0168	1.37e-06	0.188	0.616	99.059	264947	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	14OxJlLdcHNpgsm4DRwDOB	Habits (Stay High)	75	Queen Of The Clouds	4NHQUGzhtTLFvgF5SZesLK	Tove Lo	['metropopolis', 'pop', 'swedish electropop', 'swedish pop', 'swedish synthpop']	72	0.729	0.65	5	-3.539	1	0.0313	0.0702	6.69e-05	0.0829	0.347	110.02	209160	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	6Vc5wAMmXdKIAM7WUoEb7N	Say Something	75	Is There Anybody Out There?	5xKp3UyavIBUsGy3DQdXeF	A Great Big World	['neo mellow', 'piano rock', 'pop rock', 'viral pop']	59	0.407	0.147	2	-8.822	1	0.0355	0.857	2.89e-06	0.0913	0.0765	141.284	229400	3
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	0Dc7J9VPV4eOInoxUiZrsL	Don't Tell 'Em	75	Late Nights: The Album	3KV3p5EY4AvKxOlhGHORLg	Jeremih	['chicago rap', 'pop rap', 'r&b', 'southern hip hop', 'trap', 'urban contemporary']	71	0.856	0.527	2	-5.225	1	0.0997	0.392	0	0.11	0.386	98.052	266840	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	5KONnBIQ9LqCxyeSPin26k	Trumpets	64	Talk Dirty	07YZf4WDAMNwqr4jfgOZ8y	Jason Derulo	['dance pop', 'pop']	77	0.635	0.691	0	-4.862	1	0.258	0.555	0	0.097	0.638	82.142	217419	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	5BJSZocnCeSNeYMj3iVqM7	Love Runs Out	64	Native	5Pwc4xIPtQLFEnJriah9YJ	OneRepublic	['piano rock', 'pop']	81	0.719	0.935	7	-3.752	1	0.0589	0.167	0	0.0973	0.738	120.022	224227	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	7m3povhdMDLZwuEKak0l0n	Wasted	64	A Town Called Paradise (Deluxe)	2o5jDhtHVPhrJdv3cEQ99Z	TiÃ«sto	['big room', 'brostep', 'dutch edm', 'edm', 'house', 'pop dance', 'slap house', 'trance']	82	0.638	0.816	2	-5.503	1	0.0308	0.00149	0.00115	0.195	0.386	112.014	190014	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	39lS97papXAI72StGRtZBo	Wrapped Up (feat. Travie McCoy)	63	Never Been Better (Expanded Edition)	3whuHq0yGx60atvA2RCVRW	Olly Murs	['dance pop', 'pop', 'talent show']	63	0.787	0.837	1	-5.419	1	0.0556	0.0926	0	0.155	0.918	122.004	185629	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	2GQEM9JuHu30sGFvRYeCxz	Faded	62	THE NIGHTDAY	28j8lBWDdDSHSSt5oPlsX2	ZHU	['edm', 'electro house']	62	0.867	0.477	9	-7.183	0	0.049	0.00843	0.175	0.113	0.614	124.979	223480	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	69gQgkobVW8bWjoCjBYQUd	I Got U	62	EP1	61lyPtntblHJvA7FMMhi7E	Duke Dumont	['edm', 'house', 'pop dance', 'progressive house', 'uk dance']	63	0.636	0.761	9	-7.752	0	0.035	0.00377	0.00784	0.0851	0.463	120.837	285596	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	1fu5IQSRgPxJL2OTP7FVLW	I See Fire	62	The Hobbit: The Desolation of Smaug (Original Motion Picture Soundtrack)	6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	['pop', 'singer-songwriter pop', 'uk pop']	87	0.633	0.0519	10	-21.107	0	0.0365	0.562	0	0.097	0.204	76.034	300747	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	2dRvMEW4EwySxRUtEamSfG	The Heart Wants What It Wants	61	For You	0C8ZW7ezQVs4URX5aX7Kqx	Selena Gomez	['pop', 'post-teen pop']	83	0.616	0.789	7	-4.874	0	0.0377	0.053	0	0.142	0.621	83.066	227360	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	2stPxcgjdSImK7Gizl8ZUN	The Man	60	Lift Your Spirit	0id62QV2SZZfvBn9xpmuCl	Aloe Blacc	['pop soul', 'r&b']	63	0.308	0.769	11	-7.256	0	0.065	0.0331	0	0.214	0.488	81.853	254880	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	2sLwPnIP3CUVmIuHranJZU	Wiggle (feat. Snoop Dogg)	58	Talk Dirty	07YZf4WDAMNwqr4jfgOZ8y	Jason Derulo	['dance pop', 'pop']	77	0.697	0.621	9	-6.886	0	0.25	0.0802	0	0.162	0.721	81.946	193296	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	4z7gh3aIZV9arbL9jJSc5J	Ghost	58	Chapter One	7nDsS0l5ZAzMedVRKPP8F1	Ella Henderson	['dance pop', 'pop dance', 'talent show', 'uk pop']	72	0.68	0.84	9	-3.823	1	0.0414	0.0457	8.66e-06	0.143	0.468	104.975	213213	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	3nB82yGjtbQFSU0JLAwLRH	Not a Bad Thing	57	The 20/20 Experience - 2 of 2 (Deluxe)	31TPClRtHm23RisEBtV3X7	Justin Timberlake	['dance pop', 'pop']	78	0.308	0.563	0	-9.169	1	0.0719	0.527	4.58e-06	0.134	0.109	85.901	688453	4
https://open.spotify.com/playlist/37i9dQZF1DX0h0QnLkMBl4	2014	6p5abLu89ZSSpRQnbK9Wqs	Post to Be (feat. Chris Brown & Jhene Aiko)	56	Post to Be (feat. Chris Brown & Jhene Aiko)	0f5nVCcR06GX8Qikz0COtT	Omarion	['dance pop', 'hip pop', 'r&b', 'rap', 'southern hip hop', 'trap', 'urban contemporary']	59	0.733	0.676	10	-5.655	0	0.0432	0.0697	0	0.208	0.701	97.448	226581	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	32OlwWuMpZ6b0aN2RZOeMS	Uptown Funk (feat. Bruno Mars)	85	Uptown Special	3hv9jJF3adDNsBSIQDqcjp	Mark Ronson	['pop soul']	72	0.856	0.609	0	-7.223	1	0.0824	0.00801	8.15e-05	0.0344	0.928	114.988	269667	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	34gCuhDGsG4bRPIf9bb02f	Thinking out Loud	85	x (Deluxe Edition)	6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	['pop', 'singer-songwriter pop', 'uk pop']	87	0.781	0.445	2	-6.061	1	0.0295	0.474	0	0.184	0.591	78.998	281560	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	2JzZzZUQj3Qff7wapcbKjc	See You Again (feat. Charlie Puth)	85	See You Again (feat. Charlie Puth)	137W8MRPWKqSmrBGDBFSop	Wiz Khalifa	['hip hop', 'pittsburgh rap', 'pop rap', 'rap', 'southern hip hop', 'trap']	79	0.689	0.481	10	-7.503	1	0.0815	0.369	1.03e-06	0.0649	0.283	80.025	229526	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	4B0JvthVoAAuygILe3n4Bs	What Do You Mean?	80	Purpose (Deluxe)	1uNFoZAHBGtllmzznpCI3s	Justin Bieber	['canadian pop', 'pop']	87	0.845	0.567	5	-8.118	0	0.0956	0.59	0.00142	0.0811	0.793	125.02	205680	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	1Lim1Py7xBgbAkAys3AGAG	Lean On	77	Peace Is The Mission (Extended)	738wLrAtLtCtFOLvQBXOXp	Major Lazer	['dance pop', 'edm', 'electro house', 'moombahton', 'pop', 'pop dance']	73	0.723	0.809	7	-3.081	0	0.0625	0.00346	0.00123	0.565	0.274	98.007	176561	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	2PIvq1pGrUjY007X5y1UpM	Earned It (Fifty Shades Of Grey) - From The "Fifty Shades Of Grey" Soundtrack	77	Earned It (Fifty Shades Of Grey) [From The "Fifty Shades Of Grey" Soundtrack]	1Xyo4u8uXC1ZmMpatF05PJ	The Weeknd	['canadian contemporary r&b', 'canadian pop', 'pop']	94	0.659	0.381	2	-5.922	0	0.0304	0.385	0	0.0972	0.426	119.844	252227	3
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	3zHq9ouUJQFQRf3cm1rRLu	Love Me Like You Do - From "Fifty Shades Of Grey"	80	Delirium (Deluxe)	0X2BH1fck6amBIoJhDVmmJ	Ellie Goulding	['indietronica', 'metropopolis', 'pop', 'uk pop']	78	0.262	0.606	8	-6.646	1	0.0484	0.247	0	0.125	0.275	189.857	252534	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	0ct6r3EGTcMLPtrXHDvVjc	The Nights	88	The Days / Nights	1vCWHaC5f2uS3yhpwWbIA6	Avicii	['edm', 'pop', 'pop dance']	79	0.527	0.835	6	-5.298	1	0.0433	0.0166	0	0.249	0.654	125.983	176658	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	6K4t31amVTZDgR3sKmwUJJ	The Less I Know The Better	87	Currents	5INjqkS1o8h1imAzPqGZBb	Tame Impala	['australian psych', 'modern rock', 'neo-psychedelic', 'rock']	78	0.64	0.74	4	-4.083	1	0.0284	0.0115	0.00678	0.167	0.785	116.879	216320	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	5E30LdtzQTGqRvNd7l6kG5	Daddy Issues	86	Wiped Out!	77SW9BnxLY8rJ0RciFqkHh	The Neighbourhood	['modern alternative rock', 'modern rock', 'pop']	81	0.588	0.521	10	-9.461	1	0.0329	0.0678	0.149	0.123	0.337	85.012	260173	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	7aXuop4Qambx5Oi3ynsKQr	I Don't Mind (feat. Juicy J)	68	I Don't Mind (feat. Juicy J)	23zg3TcAtWQy7J6upgbUnj	USHER	['atl hip hop', 'contemporary r&b', 'dance pop', 'pop', 'r&b', 'rap', 'south carolina hip hop', 'urban contemporary']	77	0.87	0.464	4	-8.337	1	0.178	0.205	0	0.0902	0.457	112.974	251989	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	19cL3SOKpwnwoKkII7U3Wh	Geronimo	68	Bombs Away	6VxCmtR7S3yz4vnzsJqhSV	Sheppard	['australian indie', 'folk-pop']	60	0.705	0.78	7	-6.267	1	0.0805	0.456	0.00152	0.115	0.457	142.028	218228	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	5s7xgzXtmY4gMjeSlgisjy	Easy Love	68	Brighter Days	1IueXOQyABrMOprrzwQJWN	Sigala	['dance pop', 'edm', 'pop dance', 'uk dance', 'uk pop']	69	0.68	0.942	9	-4.208	1	0.0631	0.175	0.0013	0.117	0.647	123.976	229813	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	1JDIArrcepzWDTAWXdGYmP	I Want You To Know	68	True Colors	2qxJFvFYMEDqd7ui6kSAcq	Zedd	['complextro', 'edm', 'german techno', 'pop', 'pop dance']	73	0.58	0.846	9	-2.876	0	0.0573	0.00537	6.62e-06	0.145	0.366	129.998	240000	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	2S5LNtRVRPbXk01yRQ14sZ	I Don't Like It, I Love It (feat. Robin Thicke & Verdine White)	68	My House	0jnsk9HBra6NMjO2oANoPY	Flo Rida	['dance pop', 'miami hip hop', 'pop', 'pop rap']	76	0.854	0.766	9	-4.697	0	0.141	0.0242	0	0.0793	0.784	118.004	224258	4
https://open.spotify.com/playlist/37i9dQZF1DX9ukdrXQLJGZ	2015	1WoOzgvz6CgH4pX6a1RKGp	My Way (feat. Monty)	68	Fetty Wap (Deluxe)	6PXS4YHDkKvl1wkIl4V8DL	Fetty Wap	['new jersey rap', 'pop rap', 'rap', 'southern hip hop', 'trap']	68	0.748	0.741	6	-3.103	1	0.0531	0.00419	0	0.147	0.537	128.077	213053	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	7MXVkk9YMctZqd1Srtv4MB	Starboy	92	Starboy	1Xyo4u8uXC1ZmMpatF05PJ	The Weeknd	['canadian contemporary r&b', 'canadian pop', 'pop']	94	0.679	0.587	7	-7.015	1	0.276	0.141	6.35e-06	0.137	0.486	186.003	230453	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	1zi7xx7UVEFkmKfv06H8x0	One Dance	89	Views	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.792	0.625	1	-5.609	1	0.0536	0.00776	0.0018	0.329	0.37	103.967	173987	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	50kpGaPAhYJ3sGmk6vplg0	Love Yourself	86	Purpose (Deluxe)	1uNFoZAHBGtllmzznpCI3s	Justin Bieber	['canadian pop', 'pop']	87	0.609	0.378	4	-9.828	1	0.438	0.835	0	0.28	0.515	100.418	233720	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	7BKLCZ1jbUBVqRi2FVlTVw	Closer	86	Closer	69GGBxA162lTqCwzJG5jLp	The Chainsmokers	['electropop', 'pop']	78	0.748	0.524	8	-5.599	1	0.0338	0.414	0	0.111	0.661	95.01	244960	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	62PaSfnXSMyLshYJrlTuL3	Hello	75	25	4dpARuHxo51G3z768sgnrY	Adele	['british soul', 'pop', 'pop soul', 'uk pop']	83	0.578	0.43	5	-6.134	0	0.0305	0.33	0	0.0854	0.288	78.991	295502	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	3xKsf9qdS1CyvXSMEid6g8	Pink + White	90	Blonde	2h93pZq0e7k5yf4dywlkpM	Frank Ocean	['lgbtq+ hip hop', 'neo soul']	82	0.545	0.545	9	-7.362	1	0.107	0.667	5.48e-05	0.417	0.549	159.94	184516	3
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	3QGsuHI8jO1Rx4JWLUh9jd	Treat You Better	87	Illuminate	7n2wHs1TKAczGzO7Dd2rGr	Shawn Mendes	['canadian pop', 'pop', 'viral pop']	81	0.444	0.819	10	-4.078	0	0.341	0.106	0	0.107	0.747	82.695	187973	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	6b3b7lILUJqXcp6w9wNQSm	Cheap Thrills (feat. Sean Paul)	69	Cheap Thrills (feat. Sean Paul)	5WUlDfRSoLAfcVSX1WnrxN	Sia	['australian dance', 'australian pop', 'pop']	81	0.592	0.8	6	-4.931	0	0.215	0.0561	2.01e-06	0.0775	0.728	89.972	224813	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	0lYBSQXN6rCTvUZvg9S0lU	Let Me Love You	86	Encore	540vIaP2JwjQb9dm3aArA4	DJ Snake	['edm', 'electronic trap', 'pop', 'pop dance']	76	0.649	0.716	8	-5.371	1	0.0349	0.0863	2.63e-05	0.135	0.163	99.988	205947	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	72TFWvU3wUYdUuxejTTIzt	Work	79	ANTI (Deluxe)	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.725	0.534	11	-6.238	1	0.0946	0.0752	0	0.0919	0.558	91.974	219320	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	2Z8WuEywRWYTKe1NybPQEW	Ride	85	Blurryface	3YQKmKGau1PzlVlkL1iodx	Twenty One Pilots	['modern rock', 'pop', 'pov: indie', 'rock']	78	0.645	0.713	6	-5.355	1	0.0393	0.00835	0	0.113	0.566	74.989	214507	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	09CtPGIpYB4BrO8qb1RGsF	Sorry	83	Purpose (Deluxe)	1uNFoZAHBGtllmzznpCI3s	Justin Bieber	['canadian pop', 'pop']	87	0.654	0.76	0	-3.669	0	0.045	0.0797	0	0.299	0.41	99.945	200787	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	5kqIPrATaCc2LqxVWzQGbk	7 Years	85	Lukas Graham	25u4wHJWxCA9vO0CzxAbK7	Lukas Graham	['danish pop', 'scandipop']	69	0.765	0.473	10	-5.829	1	0.0514	0.287	0	0.391	0.34	119.992	237300	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	3RiPr603aXAoi4GHyXx0uy	Hymn for the Weekend	85	A Head Full of Dreams	4gzpq5DPGxSnKTe4SA8HAU	Coldplay	['permanent wave', 'pop']	86	0.491	0.693	0	-6.487	0	0.0377	0.211	6.92e-06	0.325	0.412	90.027	258267	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	0azC730Exh71aQlOt9Zj3y	This Is What You Came For	85	This Is What You Came For	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.631	0.927	9	-2.787	0	0.0332	0.199	0.119	0.148	0.465	123.962	222160	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	3pXF1nA74528Edde4of9CC	Don't	85	T R A P S O U L	2EMAnMvWE2eb56ToJVfCWs	Bryson Tiller	['kentucky hip hop', 'r&b', 'rap']	77	0.765	0.356	11	-5.556	0	0.195	0.223	0	0.0963	0.189	96.991	198293	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	76hfruVvmfQbw0eYn1nmeC	Cake By The Ocean	84	DNCE	6T5tfhQCknKG4UnH90qGnz	DNCE	['dance pop', 'pop']	67	0.774	0.753	4	-5.446	0	0.0517	0.152	0	0.0371	0.896	119.002	219147	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	4pAl7FkDMNBsjykPXo91B3	Needed Me	83	ANTI (Deluxe)	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.671	0.314	5	-8.091	0	0.244	0.11	0	0.0825	0.296	110.898	191600	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	1i1fxkWeaMmKEB4T7zqbzK	Don't Let Me Down	82	Don't Let Me Down	69GGBxA162lTqCwzJG5jLp	The Chainsmokers	['electropop', 'pop']	78	0.532	0.869	11	-5.094	1	0.172	0.157	0.00508	0.136	0.422	159.803	208373	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	6i0V12jOa3mr6uu4WYhUBr	Heathens	83	Heathens	3YQKmKGau1PzlVlkL1iodx	Twenty One Pilots	['modern rock', 'pop', 'pov: indie', 'rock']	78	0.732	0.396	4	-9.348	0	0.0286	0.0841	3.58e-05	0.105	0.548	90.024	195920	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	23L5CiUhw2jV1OIMwthR3S	In the Name of Love	82	In the Name of Love	60d24wfXkVzDSfLS6hyCjZ	Martin Garrix	['dutch edm', 'edm', 'pop', 'pop dance', 'progressive house']	74	0.501	0.519	4	-5.88	0	0.0409	0.109	0	0.454	0.168	133.99	195707	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	2BOqDYLOJBiMOXShCV1neZ	Dancing On My Own	82	Only Human (Deluxe)	6ydoSd3N2mwgwBHtF6K7eX	Calum Scott	['pop']	74	0.681	0.174	1	-8.745	1	0.0315	0.837	3.35e-05	0.0983	0.231	112.672	260285	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	698ItKASDavgwZ3WjaWjtz	Faded	82	Different World	7vk5e3vY1uw9plTHJAMwjN	Alan Walker	['electro house']	79	0.468	0.627	6	-5.085	1	0.0476	0.0281	7.97e-06	0.11	0.159	179.642	212107	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	0vbtURX4qv1l7besfwmnD8	I Took A Pill In Ibiza - Seeb Remix	81	At Night, Alone.	2KsP6tYLJlTBvSUxnwlVWa	Mike Posner	['dance pop', 'pop', 'pop dance', 'pop rap']	68	0.664	0.714	7	-6.645	0	0.111	0.0353	8.42e-06	0.0843	0.71	101.969	197933	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	0y60itmpH0aPKsFiGxmtnh	Wait a Minute!	81	ARDIPITHECUS	3rWZHrfrsPBxVy692yAIxF	WILLOW	['afrofuturism', 'pop', 'post-teen pop', 'pov: indie']	69	0.764	0.705	3	-5.279	0	0.0278	0.0371	1.94e-05	0.0943	0.672	101.003	196520	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	0VhgEqMTNZwYL1ARDLLNCX	Can I Be Him	81	Back from the Edge	4IWBUUAFIplrNtaOHcJPRM	James Arthur	['pop', 'talent show', 'uk pop']	80	0.696	0.543	11	-6.164	1	0.0489	0.308	0	0.0939	0.479	107.969	246880	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	1A8j067qyiNwQnZT0bzUpZ	This Girl (Kungs Vs. Cookin' On 3 Burners)	81	Layers	7keGfmQR4X5w0two1xKZ7d	Kungs	['edm', 'pop dance']	71	0.792	0.717	0	-4.759	0	0.0393	0.0927	3.59e-05	0.226	0.466	121.985	195547	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	3O8NlPh2LByMU9lSRSHedm	Controlla	75	Views	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.59	0.468	10	-11.083	0	0.185	0.0789	0	0.101	0.349	92.287	245227	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	0t7fVeEJxO2Xi4H2K5Svc9	Send My Love (To Your New Lover)	76	25	4dpARuHxo51G3z768sgnrY	Adele	['british soul', 'pop', 'pop soul', 'uk pop']	83	0.688	0.533	6	-8.363	0	0.0865	0.0355	3.48e-06	0.172	0.567	164.069	223079	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	7lGKEWMXVWWTt3X71Bv44I	Unsteady	75	VHS	3NPpFNZtSTHheNBaWC82rB	X Ambassadors	['modern alternative rock', 'modern rock', 'stomp pop']	69	0.389	0.665	0	-6.169	1	0.0644	0.178	0.000732	0.116	0.199	117.055	193547	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	2GyA33q5rti5IxkMQemRDH	I Know What You Did Last Summer	74	Handwritten	7n2wHs1TKAczGzO7Dd2rGr	Shawn Mendes	['canadian pop', 'pop', 'viral pop']	81	0.687	0.761	9	-4.582	0	0.0876	0.102	0	0.147	0.743	113.939	223853	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	0TXNKTzawI6VgLoA9UauRp	When You Love Someone	74	Chapters	0B3N0ZINFWvizfa8bKiz4v	James TW	['british singer-songwriter']	62	0.681	0.453	7	-6.09	1	0.0278	0.263	0	0.0543	0.348	125.772	216560	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	5n0CTysih20NYdT2S0Wpe8	Trouble	73	Tell Me I'm Pretty	26T3LtbuGT1Fu9m0eRq5X3	Cage The Elephant	['modern alternative rock', 'modern rock', 'pov: indie', 'punk blues', 'rock']	71	0.47	0.623	0	-5.655	1	0.0302	0.392	0.000439	0.0992	0.298	77.861	225973	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	7EVk9tRb6beJLTHrg6AkY9	Tuesday (feat. Danelle Sandoval)	73	Tuesday (feat. Danelle Sandoval)	4ON1ruy5ijE7ZPQthbrkgI	Burak Yeter	['electro house']	55	0.841	0.639	9	-6.052	0	0.0688	0.0156	0.0654	0.0545	0.675	99.002	241875	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	27GmP9AWRs744SzKcpJsTZ	Jumpman	73	What A Time To Be Alive	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.852	0.553	1	-7.286	1	0.187	0.0559	0	0.332	0.656	142.079	205879	4
https://open.spotify.com/playlist/37i9dQZF1DX8XZ6AUo9R4R	2016	5hc71nKsUgtwQ3z52KEKQk	Somebody Else	73	I like it when you sleep, for you are so beautiful yet so unaware of it	3mIj9lX2MWuHmhNCA7LSCW	The 1975	['modern alternative rock', 'modern rock', 'pop', 'pov: indie', 'rock']	75	0.61	0.788	0	-5.724	1	0.0585	0.195	0.0142	0.153	0.472	101.045	347520	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	7qiZfU4dY1lWllzX7mPBI3	Shape of You	89	Ã· (Deluxe)	6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	['pop', 'singer-songwriter pop', 'uk pop']	87	0.825	0.652	1	-3.183	0	0.0802	0.581	0	0.0931	0.931	95.977	233713	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	0pqnGHJpmpxLKifKRmU6WP	Believer	90	Evolve	53XhwfbYqKCa1cC15pYq2q	Imagine Dragons	['modern rock', 'pop', 'rock']	86	0.776	0.78	10	-4.374	0	0.128	0.0622	0	0.081	0.666	124.949	204347	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	6habFhsOp2NvshLv26DqMb	Despacito	82	VIDA	4V8Sr092TqfHkfAA5fXXqG	Luis Fonsi	['latin pop', 'puerto rican pop']	72	0.655	0.797	2	-4.787	1	0.153	0.198	0	0.067	0.839	177.928	229360	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	1PSBzsahR2AKwLJgx8ehBj	Bad Things (with Camila Cabello)	73	bloom	6TIYQ3jFPwQSRmorSezPxX	Machine Gun Kelly	['ohio hip hop', 'pop rap']	75	0.697	0.691	2	-4.757	1	0.146	0.214	0	0.185	0.305	137.853	239293	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	5knuzwU65gJK7IF5yJsuaW	Rockabye (feat. Sean Paul & Anne-Marie)	77	Rockabye (feat. Sean Paul & Anne-Marie)	6MDME20pz9RveH9rEXvrOM	Clean Bandit	['pop', 'uk dance', 'uk funky']	72	0.72	0.763	9	-4.068	0	0.0523	0.406	0	0.18	0.742	101.965	251088	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	1rfofaqEpACxVEHIZBJe6W	Havana (feat. Young Thug)	82	Camila	4nDoRrQiYLoBzwC5BhVJzF	Camila Cabello	['dance pop', 'pop']	78	0.765	0.523	2	-4.333	1	0.03	0.184	3.56e-05	0.132	0.394	104.988	217307	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	1zB4vmk8tFRmM9UULNzbLB	Thunder	88	Evolve	53XhwfbYqKCa1cC15pYq2q	Imagine Dragons	['modern rock', 'pop', 'rock']	86	0.605	0.822	0	-4.833	1	0.0438	0.00671	0.134	0.147	0.288	167.997	187147	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	1nueTG77MzNkJTKQ0ZdGzT	Don't Wanna Know (feat. Kendrick Lamar)	65	Red Pill Blues (Deluxe)	04gDigrS5kc9YWfZHwBETP	Maroon 5	['pop']	83	0.783	0.61	7	-6.124	1	0.0696	0.343	0	0.0983	0.418	100.047	214265	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	0KKkJNfGyhkQ5aFogxQAPU	That's What I Like	88	24K Magic	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.853	0.56	1	-4.961	1	0.0406	0.013	0	0.0944	0.86	134.066	206693	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	0tgVpDi06FyKpA1z0VMD4v	Perfect	90	Ã· (Deluxe)	6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	['pop', 'singer-songwriter pop', 'uk pop']	87	0.599	0.448	8	-6.312	1	0.0232	0.163	0	0.106	0.168	95.05	263400	3
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	7JJmb5XwzOO8jgpou264Ml	There's Nothing Holdin' Me Back	87	Illuminate (Deluxe)	7n2wHs1TKAczGzO7Dd2rGr	Shawn Mendes	['canadian pop', 'pop', 'viral pop']	81	0.866	0.813	11	-4.063	0	0.0554	0.38	0	0.0779	0.969	121.998	199440	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	5uCax9HTNlzGybIStD3vDh	Say You Won't Let Go	87	Back from the Edge	4IWBUUAFIplrNtaOHcJPRM	James Arthur	['pop', 'talent show', 'uk pop']	80	0.358	0.557	10	-7.398	1	0.059	0.695	0	0.0902	0.494	85.043	211467	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	5mCPDVBb16L4XQwDdbRUpz	Passionfruit	87	More Life	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.809	0.463	11	-11.377	1	0.0396	0.256	0.085	0.109	0.364	111.98	298941	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	6gBFPUFcJLzWGx4lenP6h2	goosebumps	87	Birds In The Trap Sing McKnight	0Y5tJX1MQlPlqiwlOH1tJY	Travis Scott	['hip hop', 'rap', 'slap house']	93	0.841	0.728	7	-3.37	1	0.0484	0.0847	0	0.149	0.43	130.049	243837	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	1mXVgsBdtIVeCLJnSnmtdV	Too Good At Goodbyes	86	The Thrill Of It All (Special Edition)	2wY79sveU1sp5g7SokKOiI	Sam Smith	['pop', 'uk pop']	83	0.681	0.372	5	-8.237	1	0.0432	0.64	0	0.169	0.476	91.873	201000	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	1P17dC1amhFzptugyAO7Il	Look What You Made Me Do	86	reputation	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.766	0.709	9	-6.471	0	0.123	0.204	1.41e-05	0.126	0.506	128.07	211853	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	7KXjTSCq5nL1LoYtL7XAwS	HUMBLE.	86	DAMN.	2YZyLoL8N0Wb9xBt1NhZWg	Kendrick Lamar	['conscious hip hop', 'hip hop', 'rap', 'west coast rap']	86	0.908	0.621	1	-6.638	0	0.102	0.000282	5.39e-05	0.0958	0.421	150.011	177000	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	3B54sVLJ402zGa6Xm4YGNe	Unforgettable	86	Jungle Rules	6vXTefBL93Dj5IqAWq6OTv	French Montana	['hip hop', 'pop rap', 'rap', 'southern hip hop', 'trap']	72	0.726	0.769	6	-5.043	1	0.123	0.0293	0.0101	0.104	0.733	97.985	233902	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	5oO3drDxtziYU2H1X23ZIp	Love On The Brain	86	ANTI (Deluxe)	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.509	0.637	4	-4.83	0	0.0471	0.0717	1.08e-05	0.0789	0.378	172.006	224000	3
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	0jdny0dhgjUwoIp5GkqEaA	Praying	71	Rainbow	6LqNN22kT3074XbTVUrhzX	Kesha	['dance pop', 'pop']	74	0.543	0.39	10	-7.202	1	0.0322	0.489	0	0.111	0.303	73.415	230267	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	0zbzrhfVS9S2TszW3wLQZ7	September Song	71	Raised Under Grey Skies (Deluxe)	4kYGAK2zu9EAomwj3hXkXy	JP Cooper	['uk pop']	64	0.614	0.615	0	-6.7	0	0.0444	0.054	0	0.0921	0.374	95.941	220291	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	0SGkqnVQo9KPytSri1H6cF	Bounce Back	71	I Decided.	0c173mlxpT3dSFRgMO8XPh	Big Sean	['detroit hip hop', 'hip hop', 'pop rap', 'r&b', 'rap', 'trap']	75	0.78	0.575	1	-5.628	0	0.139	0.106	0	0.129	0.273	81.502	222360	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	29JrmE89KgRyCxBIzq2Ocw	Strip That Down (feat. Quavo)	70	LP1	5pUo3fmmHT8bhCyHE52hA6	Liam Payne	['pop']	61	0.873	0.495	6	-5.446	1	0.0518	0.199	0	0.0805	0.546	106.033	202062	4
https://open.spotify.com/playlist/37i9dQZF1DWTE7dVUebpUW	2017	45XhKYRRkyeqoW3teSOkCM	Wild Thoughts (feat. Rihanna & Bryson Tiller)	70	Grateful	0QHgL1lAIqAw0HtD7YldmP	DJ Khaled	['hip hop', 'miami hip hop', 'pop rap', 'rap']	74	0.613	0.681	8	-3.089	1	0.0778	0.0287	0	0.126	0.619	97.621	204664	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	2qT1uLXPVPzGgFOx4jtEuo	no tears left to cry	79	Sweetener	66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	['pop']	87	0.699	0.713	9	-5.507	0	0.0594	0.04	3.11e-06	0.294	0.354	121.993	205920	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	0u2P5u6lvoDfwTYjAADbn4	lovely (with Khalid)	90	lovely (with Khalid)	6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	['art pop', 'electropop', 'pop']	88	0.351	0.296	4	-10.109	0	0.0333	0.934	0	0.095	0.12	115.284	200186	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	7ef4DlsgrMEH11cDZd32M6	One Kiss (with Dua Lipa)	87	One Kiss (with Dua Lipa)	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.791	0.862	9	-3.24	0	0.11	0.037	2.19e-05	0.0814	0.592	123.994	214847	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	6NFyWDv5CjfwuzoCkw47Xf	Delicate	87	reputation	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.75	0.404	9	-10.178	0	0.0682	0.216	0.000357	0.0911	0.0499	95.045	232253	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	5OCJzvD7sykQEKHH7qAC3C	God is a woman	79	Sweetener	66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	['pop']	87	0.602	0.658	1	-5.934	1	0.0558	0.0233	6e-05	0.237	0.268	145.031	197547	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	6DCZcSspjsKoFjzjrWoCdn	God's Plan	87	Scorpion	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.754	0.449	7	-9.211	1	0.109	0.0332	8.29e-05	0.552	0.357	77.169	198973	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	2xLMifQCjDGFmkHkpNLD9h	SICKO MODE	86	ASTROWORLD	0Y5tJX1MQlPlqiwlOH1tJY	Travis Scott	['hip hop', 'rap', 'slap house']	93	0.834	0.73	8	-3.714	1	0.222	0.00513	0	0.124	0.446	155.008	312820	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	0e7ipj03S05BNilyu5bRzt	rockstar (feat. 21 Savage)	86	beerbongs & bentleys	246dkjvS1zLTtiykXe5h60	Post Malone	['dfw rap', 'melodic rap', 'pop', 'rap']	89	0.585	0.52	5	-6.136	0	0.0712	0.124	7.01e-05	0.131	0.129	159.801	218147	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	6IPwKM3fUUzlElbvKw2sKl	we fell in love in october	86	we fell in love in october / October Passed Me By	3uwAm6vQy7kWPS2bciKWx9	girl in red	['bedroom pop', 'indie pop', 'norwegian indie', 'pop', 'pov: indie']	72	0.566	0.366	7	-12.808	1	0.028	0.113	0.181	0.155	0.237	129.96	184154	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	3GCdLUSnKSMJhs4Tj6CV3s	All The Stars (with SZA)	86	Black Panther The Album Music From And Inspired By	2YZyLoL8N0Wb9xBt1NhZWg	Kendrick Lamar	['conscious hip hop', 'hip hop', 'rap', 'west coast rap']	86	0.698	0.633	8	-4.946	1	0.0597	0.0605	0.000194	0.0926	0.552	96.924	232187	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	58kZ9spgxmlEznXGu6FPdQ	Sick Boy	69	Sick Boy	69GGBxA162lTqCwzJG5jLp	The Chainsmokers	['electropop', 'pop']	78	0.663	0.577	11	-7.518	0	0.0531	0.109	0	0.12	0.454	89.996	193200	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	4EAV2cKiqKP5UPZmY6dejk	Everyday	68	Bobby Tarantino II	4xRYI6VqpkE3UwrDrAZL8L	Logic	['conscious hip hop', 'hip hop', 'pop rap', 'rap']	73	0.667	0.741	1	-4.099	1	0.0378	0.0425	0	0.0761	0.422	149.908	204747	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	6V1bu6o1Yo5ZXnsCJU8Ovk	Girls Like You (feat. Cardi B) - Cardi B Version	67	Red Pill Blues (Deluxe)	04gDigrS5kc9YWfZHwBETP	Maroon 5	['pop']	83	0.851	0.541	0	-6.825	1	0.0505	0.568	0	0.13	0.448	124.959	235545	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	2xGjteMU3E1tkEPVFBO08U	This Is Me	67	This Is Me	7HV2RI2qNug4EcQqLbCAKS	Keala Settle	['broadway', 'hollywood', 'show tunes']	61	0.284	0.704	2	-7.276	1	0.186	0.00583	0.000115	0.0424	0.1	191.702	234707	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	5WvAo7DNuPRmk4APhdPzi8	No Brainer	66	No Brainer	0QHgL1lAIqAw0HtD7YldmP	DJ Khaled	['hip hop', 'miami hip hop', 'pop rap', 'rap']	74	0.552	0.76	0	-4.706	1	0.342	0.0733	0	0.0865	0.639	135.702	260000	5
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	1BuZAIO8WZpavWVbbq3Lci	Powerglide (feat. Juicy J) - From SR3MM	66	SR3MM	7iZtZyCzp3LItcw1wtPI3D	Rae Sremmurd	['melodic rap', 'mississippi hip hop', 'pop rap', 'rap', 'trap']	70	0.713	0.831	1	-4.75	0	0.15	0.0168	0	0.118	0.584	173.948	332301	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	0ZNrc4kNeQYD9koZ3KvCsy	BIG BANK (feat. 2 Chainz, Big Sean, Nicki Minaj)	66	STAY DANGEROUS	0A0FS04o6zMoto8OKPsDwY	YG	['cali rap', 'hip hop', 'pop rap', 'rap', 'southern hip hop', 'trap']	72	0.745	0.346	1	-7.709	1	0.331	0.00552	0	0.0881	0.112	203.911	237240	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	5gW5dSy3vXJxgzma4rQuzH	Make Me Feel	65	Dirty Computer	6ueGR6SWhUJfvEhqkvMsVs	Janelle MonÃ¡e	['afrofuturism', 'alternative r&b', 'atl hip hop', 'neo soul', 'r&b']	67	0.859	0.413	1	-7.399	1	0.182	0.132	0	0.334	0.697	115.035	194230	4
https://open.spotify.com/playlist/37i9dQZF1DXe2bobNYDtW8	2018	083Qf6hn6sFL6xiOHlZUyn	I'll Be There	65	I'll Be There	4ScCswdRlyA23odg9thgIO	Jess Glynne	['pop', 'uk pop']	70	0.623	0.851	7	-3.111	1	0.0409	0.0228	0	0.12	0.4	100.063	193924	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	2YpeDb67231RjR0MgVLzsG	Old Town Road - Remix	79	7 EP	7jVv8c5Fj3E9VhNjxT4snq	Lil Nas X	['lgbtq+ hip hop']	76	0.878	0.619	6	-5.56	1	0.102	0.0533	0	0.113	0.639	136.041	157067	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	2Fxmhks0bxGSBdJ92vM42m	bad guy	85	WHEN WE ALL FALL ASLEEP, WHERE DO WE GO?	6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	['art pop', 'electropop', 'pop']	88	0.701	0.425	7	-10.965	1	0.375	0.328	0.13	0.1	0.562	135.128	194088	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	6v3KW9xbzN5yKLt9YKDYA2	SeÃ±orita	82	Shawn Mendes (Deluxe)	7n2wHs1TKAczGzO7Dd2rGr	Shawn Mendes	['canadian pop', 'pop', 'viral pop']	81	0.759	0.548	9	-6.049	0	0.029	0.0392	0	0.0828	0.749	116.967	190800	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	1BxfuPKGuaTgP7aM0Bbdwr	Cruel Summer	100	Lover	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.552	0.702	9	-5.707	1	0.157	0.117	2.06e-05	0.105	0.564	169.994	178427	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	21jGcNKet2qwijlDFuPiPb	Circles	89	Hollywood's Bleeding	246dkjvS1zLTtiykXe5h60	Post Malone	['dfw rap', 'melodic rap', 'pop', 'rap']	89	0.695	0.762	0	-3.497	1	0.0395	0.192	0.00244	0.0863	0.553	120.042	215280	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	2qxmye6gAegTMjLKEBoR3d	Let Me Down Slowly	87	Narrated For You	5IH6FPUwQTxPSXurCrcIov	Alec Benjamin	['alt z', 'pop', 'pov: indie']	74	0.652	0.557	1	-5.714	0	0.0318	0.74	0	0.124	0.483	150.073	169354	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	5p7ujcrUXASCNwRaWNHR1C	Without Me	76	Without Me	26VFTg2z8YR0cCuwLzESi2	Halsey	['electropop', 'etherpop', 'indie poptimism', 'pop']	80	0.752	0.488	6	-7.05	1	0.0705	0.297	9.11e-06	0.0936	0.533	136.041	201661	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	0u2P5u6lvoDfwTYjAADbn4	lovely (with Khalid)	90	lovely (with Khalid)	6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	['art pop', 'electropop', 'pop']	88	0.351	0.296	4	-10.109	0	0.0333	0.934	0	0.095	0.12	115.284	200186	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	2xLMifQCjDGFmkHkpNLD9h	SICKO MODE	86	ASTROWORLD	0Y5tJX1MQlPlqiwlOH1tJY	Travis Scott	['hip hop', 'rap', 'slap house']	93	0.834	0.73	8	-3.714	1	0.222	0.00513	0	0.124	0.446	155.008	312820	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	2vXKRlJBXyOcvZYTdNeckS	Lost in the Fire (feat. The Weeknd)	85	Hyperion	3hteYQFiMFbJY7wS0xDymP	Gesaffelstein	['dark clubbing', 'electro trash']	71	0.658	0.671	2	-12.21	1	0.0363	0.0933	0.000927	0.115	0.166	100.966	202093	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	7qEHsqek33rTcFNT9PFqLf	Someone You Loved	90	Divinely Uninspired To A Hellish Extent	4GNC7GD6oZMSxPGyXy4MNB	Lewis Capaldi	['pop', 'uk pop']	79	0.501	0.405	1	-5.679	1	0.0319	0.751	0	0.105	0.446	109.891	182161	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	0Oqc0kKFsQ6MhFOLBNZIGX	Doin' Time	84	Norman Fucking Rockwell!	00FQb4jTyendYWaN8pK0wa	Lana Del Rey	['art pop', 'pop']	89	0.641	0.559	7	-11.132	0	0.0355	0.404	0.00402	0.0937	0.523	144.982	202193	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	2JvzF1RMd7lE3KmFlsyZD8	MIDDLE CHILD	84	MIDDLE CHILD	6l3HvQ5sa6mXTsMTB19rO5	J. Cole	['conscious hip hop', 'hip hop', 'north carolina hip hop', 'rap']	84	0.837	0.364	8	-11.713	1	0.276	0.149	0	0.271	0.463	123.984	213594	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	1dGr1c8CrMLDpV6mPbImSI	Lover	91	Lover	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.359	0.543	7	-7.582	1	0.0919	0.492	1.58e-05	0.118	0.453	68.534	221307	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	43zdsphuZLzwA9k4DJhU0I	when the party's over	85	WHEN WE ALL FALL ASLEEP, WHERE DO WE GO?	6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	['art pop', 'electropop', 'pop']	88	0.367	0.111	4	-14.084	1	0.0972	0.978	3.97e-05	0.0897	0.198	82.642	196077	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	7xQAfvXzm3AkraOtGPWIZg	Wow.	84	Hollywood's Bleeding	246dkjvS1zLTtiykXe5h60	Post Malone	['dfw rap', 'melodic rap', 'pop', 'rap']	89	0.829	0.539	11	-7.359	0	0.208	0.136	1.78e-06	0.103	0.388	99.96	149547	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	22vgEDb5hykfaTwLuskFGD	Sucker	83	Happiness Begins	7gOdHgIoIKoe4i9Tta6qdD	Jonas Brothers	['boy band', 'pop']	77	0.842	0.734	1	-5.065	0	0.0588	0.0427	0	0.106	0.952	137.958	181027	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	4l0Mvzj72xxOpRrp6h8nHi	Lose You To Love Me	83	Rare	0C8ZW7ezQVs4URX5aX7Kqx	Selena Gomez	['pop', 'post-teen pop']	83	0.488	0.343	4	-8.985	1	0.0436	0.556	0	0.21	0.0978	102.819	206459	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	3e9HZxeyfWwjeyPAMmWSSQ	thank u, next	82	thank u, next	66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	['pop']	87	0.717	0.653	1	-5.634	1	0.0658	0.229	0	0.101	0.412	106.966	207320	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	1rqqCSm0Qe4I9rUvWncaom	High Hopes	82	Pray for the Wicked	20JZFwl6HVl6yg8a4H3ZqK	Panic! At The Disco	['pop']	75	0.579	0.904	5	-2.729	1	0.0618	0.193	0	0.064	0.681	82.014	190947	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	6RRNNciQGZEXnqk8SQ9yv5	You Need To Calm Down	84	Lover	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.771	0.671	2	-5.617	1	0.0553	0.00929	0	0.0637	0.714	85.026	171360	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	7dt6x5M1jzdTEt8oCbisTK	Better Now	83	beerbongs & bentleys	246dkjvS1zLTtiykXe5h60	Post Malone	['dfw rap', 'melodic rap', 'pop', 'rap']	89	0.68	0.578	10	-5.804	1	0.04	0.331	0	0.135	0.341	145.038	231267	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	2t8yVaLvJ0RenpXUIAC52d	a lot	82	i am > i was	1URnnhqYAYcrqrcwql10ft	21 Savage	['atl hip hop', 'hip hop', 'rap', 'trap']	88	0.837	0.636	1	-7.643	1	0.086	0.0395	0.00125	0.342	0.274	145.972	288624	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	1lOe9qE0vR9zwWQAOk6CoO	Ransom	82	We Love You Tecca	4Ga1P7PMIsmqEZqhYZQgDo	Lil Tecca	['melodic rap', 'pluggnb', 'rap']	76	0.745	0.642	7	-6.257	0	0.287	0.0204	0	0.0658	0.226	179.974	131240	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	7DnAm9FOTWE3cUvso43HhI	Sweet but Psycho	82	Heaven & Hell	4npEfmQ6YuiwW1GpUmaq3F	Ava Max	['pop']	78	0.72	0.706	1	-4.719	1	0.0473	0.0684	0	0.166	0.62	133.002	187436	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	1wJRveJZLSb1rjhnUHQiv6	Swervin (feat. 6ix9ine)	75	Hoodie SZN	31W5EY0aAly4Qieq6OFu6I	A Boogie Wit da Hoodie	['melodic rap', 'rap', 'trap']	79	0.581	0.662	9	-5.239	1	0.303	0.0153	0	0.111	0.434	93.023	189487	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	7tFiyTwD0nx5a1eklYtX2J	Bohemian Rhapsody - Remastered 2011	75	A Night At The Opera (Deluxe Remastered Version)	1dfeR4HaWDbWqFHLkxsg1d	Queen	['classic rock', 'glam rock', 'rock']	82	0.392	0.402	0	-9.961	0	0.0536	0.288	0	0.243	0.228	143.883	354320	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	132ALUzVLmqYB4UsBj5qD6	Adan y Eva	74	Homerun	3vQ0GE3mI0dAaxIMYe5g7z	Paulo Londra	['argentine hip hop', 'trap argentino', 'trap latino', 'urbano latino']	74	0.767	0.709	1	-4.47	1	0.336	0.323	0	0.0745	0.72	171.993	256972	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	0DiDStADDVh3SvAsoJAFMk	Only Human	74	Happiness Begins	7gOdHgIoIKoe4i9Tta6qdD	Jonas Brothers	['boy band', 'pop']	77	0.795	0.496	0	-5.883	1	0.0722	0.108	0	0.0645	0.874	94.01	183000	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	5itOtNx0WxtJmi1TQ3RuRd	Giant (with Rag'n'Bone Man)	74	Giant (with Rag'n'Bone Man)	7CajNmpbOovFoOoasH2HaY	Calvin Harris	['dance pop', 'edm', 'electro house', 'house', 'pop', 'progressive house', 'uk dance']	84	0.807	0.887	1	-4.311	0	0.0361	0.016	0.000503	0.0811	0.606	122.015	229184	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	2Xnv3GntqbBH1juvUYSpHG	So Am I	73	Heaven & Hell	4npEfmQ6YuiwW1GpUmaq3F	Ava Max	['pop']	78	0.681	0.657	6	-4.671	1	0.0432	0.0748	0	0.353	0.628	130.089	183027	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	0pEkK8MqbmGSX7fT8WLMbR	Grace	73	Divinely Uninspired To A Hellish Extent	4GNC7GD6oZMSxPGyXy4MNB	Lewis Capaldi	['pop', 'uk pop']	79	0.722	0.565	4	-5.848	1	0.0335	0.435	0	0.165	0.488	104.483	185658	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	6TqXcAFInzjp0bODyvrWEq	Talk (feat. Disclosure)	73	Free Spirit	6LuN9FCkKOj5PcnpouEgny	Khalid	['pop', 'pop r&b']	82	0.9	0.4	0	-8.575	1	0.127	0.0516	0	0.0599	0.346	135.984	197573	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	1000nHvUdawXuUHgBod4Wv	Panini	72	Panini	7jVv8c5Fj3E9VhNjxT4snq	Lil Nas X	['lgbtq+ hip hop']	76	0.703	0.594	5	-6.146	0	0.0752	0.342	0	0.123	0.475	153.848	114893	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	5ls62WNKHUUrdF3r1cv83T	emotions	72	nothings ever good enough	6ASri4ePR7RlsvIQgWPJpS	iann dior	['melodic rap']	70	0.63	0.63	9	-6.211	1	0.0395	0.0131	0	0.142	0.163	80.512	131213	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	19kUPdKTp85q9RZNwaXM15	Good as You	67	Experiment Extended	3oSJ7TBVCWMDMiYjXNiCKE	Kane Brown	['black americana', 'contemporary country', 'country', 'country road']	72	0.626	0.516	8	-6.05	1	0.0388	0.4	0	0.142	0.769	153.653	192053	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	5N1o6d8zGcSZSeMFkOUQOk	Hot Girl Summer (feat. Nicki Minaj & Ty Dolla $ign)	67	Hot Girl Summer (feat. Nicki Minaj & Ty Dolla $ign)	181bsRPaVXVlUKXrxwZfHK	Megan Thee Stallion	['houston rap', 'pop', 'r&b', 'rap', 'trap queen']	75	0.872	0.814	0	-4.568	1	0.155	0.00485	1.96e-06	0.214	0.57	98.985	199427	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	3iH29NcCxYgI5shlkZrUoB	gone girl	67	Industry Plant	6ASri4ePR7RlsvIQgWPJpS	iann dior	['melodic rap']	70	0.677	0.714	11	-5.637	1	0.0287	0.162	0	0.0717	0.355	94.956	136568	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	6ImEBuxsbuTowuHmg3Z2FO	Mad Love	67	High Expectations	1MIVXf74SZHmTIp4V4paH4	Mabel	['pop', 'uk pop']	65	0.623	0.796	0	-2.981	0	0.199	0.659	0	0.115	0.607	197.524	169813	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	1AI7UPw3fgwAFkvAlZWhE0	Take Me Back to London (feat. Stormzy)	66	No.6 Collaborations Project	6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	['pop', 'singer-songwriter pop', 'uk pop']	87	0.885	0.762	8	-5.513	0	0.216	0.219	0	0.162	0.605	138.058	189733	4
https://open.spotify.com/playlist/37i9dQZF1DWVRSukIED0e9	2019	5GBuCHuPKx6UC7VsSPK0t3	Thotiana	66	Famous Cryp	3Fl1V19tmjt57oBdxXKAjJ	Blueface	['cali rap', 'rap']	65	0.906	0.382	10	-12.89	0	0.269	0.18	0	0.113	0.391	104.025	129264	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	0sf12qNH5qcw8qpgymFOqD	Blinding Lights	19	Blinding Lights	1Xyo4u8uXC1ZmMpatF05PJ	The Weeknd	['canadian contemporary r&b', 'canadian pop', 'pop']	94	0.513	0.796	1	-4.075	1	0.0629	0.00147	0.000209	0.0938	0.345	171.017	201573	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	4LEK9rD7TWIG4FCL1s27XC	cardigan	53	folklore	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.613	0.581	0	-8.588	0	0.0424	0.537	0.000345	0.25	0.551	130.033	239560	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	7igeByaBM0MgGsgXtNxDJ7	positions	0	positions	66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	['pop']	87	0.736	0.802	0	-4.759	1	0.0864	0.468	0	0.094	0.675	144.005	172325	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	6UelLqGlWMcVH1E5c4H7lY	Watermelon Sugar	90	Fine Line	6KImCVD70vtIoJWnq6nGn3	Harry Styles	['pop']	85	0.548	0.816	0	-4.209	1	0.0465	0.122	0	0.335	0.557	95.39	174000	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	22LAwLoDA5b4AaGSkg6bKW	Blueberry Faygo	76	Certified Hitmaker	5zctI4wO9XSKS8XwcnqEHk	Lil Mosey	['melodic rap', 'rap conscient']	67	0.774	0.554	0	-7.909	1	0.0383	0.207	0	0.132	0.349	99.034	162547	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	0nbXyq5TXYPCO7pr3N8S4I	The Box	83	Please Excuse Me for Being Antisocial	757aE44tKEUQEqRuT6GnEB	Roddy Ricch	['melodic rap', 'rap', 'trap']	76	0.896	0.586	10	-6.687	0	0.0559	0.104	0	0.79	0.642	116.971	196653	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	127QTOFJsJQp5LbJbu3A1y	Toosie Slide	74	Toosie Slide	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.834	0.454	1	-9.75	0	0.201	0.321	6.15e-06	0.114	0.837	81.618	247059	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	5RqR4ZCCKJDcBLIn4sih9l	Party Girl	73	Party Girl	1XLWox9w1Yvbodui0SRhUQ	StaySolidRocky	['melodic rap']	57	0.728	0.431	6	-9.966	0	0.0622	0.749	0	0.0996	0.629	130.022	147800	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	7eJMfftS33KTjuF7lTsMCx	death bed (coffee for your head)	83	death bed (coffee for your head)	6bmlMHgSheBauioMgKv2tn	Powfu	['sad lo-fi', 'sad rap']	67	0.726	0.431	8	-8.765	0	0.135	0.731	0	0.696	0.348	144.026	173333	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	4xqrdfXkTW4T0RauPLv3WA	Heather	87	Kid Krow	4Uc8Dsxct0oMqx0P6i60ea	Conan Gray	['bedroom pop', 'pop', 'pov: indie']	77	0.357	0.425	5	-7.301	1	0.0333	0.584	0	0.322	0.27	102.078	198040	3
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	3ZCTVFBt2Brf31RLEnCkWJ	everything i wanted	86	everything i wanted	6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	['art pop', 'electropop', 'pop']	88	0.704	0.225	6	-14.454	0	0.0994	0.902	0.657	0.106	0.243	120.006	245426	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	3Dv1eDb0MEgF93GpLXlucZ	Say So	80	Hot Pink	5cj0lLjcoR7YOSnhnX0Po5	Doja Cat	['dance pop', 'pop']	86	0.787	0.673	11	-4.583	0	0.159	0.264	3.35e-06	0.0904	0.779	110.962	237893	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	0v1x6rN6JHRapa03JElljE	Dynamite	0	Dynamite	3Nrfpe0tUJi4K4DXYWgMUX	BTS	['k-pop', 'k-pop boy group', 'pop']	87	0.746	0.765	6	-4.41	0	0.0993	0.0112	0	0.0936	0.737	114.044	199054	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	3tjFYV6RSFtuktYl3ZtYcq	Mood (feat. iann dior)	6	Mood (feat. iann dior)	6fWVd57NKTalqvmjRd2t8Z	24kGoldn	['cali rap', 'pop rap']	70	0.7	0.722	7	-3.558	0	0.0369	0.221	0	0.272	0.756	90.989	140526	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	0PvFJmanyNQMseIFrU708S	For The Night (feat. Lil Baby & DaBaby)	80	Shoot For The Stars Aim For The Moon	0eDvMgVFoNV3TpwtrVCoTj	Pop Smoke	['brooklyn drill', 'rap']	79	0.823	0.586	6	-6.606	0	0.2	0.114	0	0.193	0.347	125.971	190476	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	2Wo6QQD1KMDWeFkkjLqwx5	Roses - Imanbek Remix	59	Roses (Imanbek Remix)	0H39MdGGX6dbnnQPt6NQkZ	SAINt JHN	['melodic rap', 'slap house']	67	0.785	0.721	8	-5.457	1	0.0506	0.0149	0.00432	0.285	0.894	121.962	176219	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	1Cv1YLb4q0RzL6pybtaMLo	Sunday Best	77	Where the Light Is	4ETSs924pXMzjIeD6E9b4u	Surfaces	['bedroom soul']	65	0.878	0.525	5	-6.832	1	0.0578	0.183	0	0.0714	0.694	112.022	158571	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	3jjujdWJ72nww5eGnfs2E7	Adore You	86	Fine Line	6KImCVD70vtIoJWnq6nGn3	Harry Styles	['pop']	85	0.676	0.771	8	-3.675	1	0.0483	0.0237	7e-06	0.102	0.569	99.048	207133	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	2SAqBLGA283SUiwJ3xOUVI	Laugh Now Cry Later (feat. Lil Durk)	80	Laugh Now Cry Later (feat. Lil Durk)	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.761	0.518	0	-8.871	1	0.134	0.244	3.47e-05	0.107	0.522	133.976	261493	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	2Z8yfpFX0ZMavHkcIeHiO1	Monster (Shawn Mendes & Justin Bieber)	71	Monster	7n2wHs1TKAczGzO7Dd2rGr	Shawn Mendes	['canadian pop', 'pop', 'viral pop']	81	0.652	0.383	2	-7.076	0	0.0516	0.0676	0	0.0828	0.549	145.765	178994	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	1DWZUa5Mzf2BwzpHtgbHPY	Good News	74	Circles	4LLpKhyESsyAXpc4laK94U	Mac Miller	['hip hop', 'pittsburgh rap', 'pop rap', 'rap']	81	0.794	0.32	1	-12.92	0	0.173	0.853	0.134	0.112	0.241	174.088	342040	4
https://open.spotify.com/playlist/2fmTTbBkXi8pewbUvG3CeZ	2020	2ygvZOXrIeVL4xZmAWJT2C	my future	73	my future	6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	['art pop', 'electropop', 'pop']	88	0.444	0.309	8	-10.956	1	0.062	0.795	0.132	0.352	0.0875	104.745	208155	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	7lPN2DXiMsVn7XUKtOW1CS	drivers license	28	drivers license	1McMsnEElThX1knmY4oliG	Olivia Rodrigo	['pop']	85	0.585	0.436	10	-8.761	1	0.0601	0.721	1.31e-05	0.105	0.132	143.874	242014	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	67BtfxlNbhBmCDR2L2l8qd	MONTERO (Call Me By Your Name)	76	MONTERO (Call Me By Your Name)	7jVv8c5Fj3E9VhNjxT4snq	Lil Nas X	['lgbtq+ hip hop']	76	0.61	0.508	8	-6.682	0	0.152	0.297	0	0.384	0.758	178.818	137876	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	3Wrjm47oTz2sjIgck11l5e	Beggin'	85	Chosen	0lAWpj5szCSwM4rUMHYmrr	MÃ¥neskin	['indie rock italiano', 'italian pop', 'pop']	78	0.714	0.8	11	-4.808	0	0.0504	0.127	0	0.359	0.589	134.002	211560	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	37BZB0z9T8Xu7U3e65qxFy	Save Your Tears (with Ariana Grande) (Remix)	83	Save Your Tears (Remix)	1Xyo4u8uXC1ZmMpatF05PJ	The Weeknd	['canadian contemporary r&b', 'canadian pop', 'pop']	94	0.65	0.825	0	-4.645	1	0.0325	0.0215	2.44e-05	0.0936	0.593	118.091	191014	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	4iJyoBOLtHqaGxP12qzhQI	Peaches (feat. Daniel Caesar & Giveon)	84	Justice	1uNFoZAHBGtllmzznpCI3s	Justin Bieber	['canadian pop', 'pop']	87	0.677	0.696	0	-6.181	1	0.119	0.321	0	0.42	0.464	90.03	198082	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	7MAibcTli4IisCtbHKrGMh	Leave The Door Open	12	Leave The Door Open	0du5cEVh5yTK9QJze8zA0C	Bruno Mars	['dance pop', 'pop']	86	0.586	0.616	5	-7.964	1	0.0324	0.182	0	0.0927	0.719	148.088	242096	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	61KpQadow081I2AsbeLcsb	deja vu	17	deja vu	1McMsnEElThX1knmY4oliG	Olivia Rodrigo	['pop']	85	0.439	0.61	9	-7.236	1	0.116	0.593	1.07e-05	0.341	0.172	181.088	215508	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	3YJJjQPAbDT7mGpX3WtQ9A	Good Days	81	Good Days	7tYKF4w9nC0nq9CsPZTHyP	SZA	['pop', 'r&b', 'rap']	87	0.436	0.655	1	-8.37	0	0.0583	0.499	8.1e-06	0.688	0.412	121.002	279204	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	6PQ88X9TkUIAUIZJHW2upE	Bad Habits	18	Bad Habits	6eUKZXaKkcviH0Ku9w2n3V	Ed Sheeran	['pop', 'singer-songwriter pop', 'uk pop']	87	0.808	0.897	11	-3.712	0	0.0348	0.0469	3.14e-05	0.364	0.591	126.026	231041	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	5HCyWlXZPP0y6Gqq8TgA20	STAY (with Justin Bieber)	86	STAY (with Justin Bieber)	2tIP7SsRs7vjIcLrU85W8J	The Kid LAROI	['australian hip hop']	78	0.591	0.764	1	-5.484	1	0.0483	0.0383	0	0.103	0.478	169.928	141806	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	5Z9KJZvQzH6PFmb8SNkxuk	INDUSTRY BABY (feat. Jack Harlow)	79	MONTERO	7jVv8c5Fj3E9VhNjxT4snq	Lil Nas X	['lgbtq+ hip hop']	76	0.741	0.691	10	-7.395	0	0.0672	0.0221	0	0.0476	0.892	150.087	212353	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	748mdHapucXQri7IAO8yFK	Kiss Me More (feat. SZA)	79	Kiss Me More (feat. SZA)	5cj0lLjcoR7YOSnhnX0Po5	Doja Cat	['dance pop', 'pop']	86	0.762	0.701	8	-3.541	1	0.0286	0.235	0.000158	0.123	0.742	110.968	208867	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	6PERP62TejQjgHu81OHxgM	good 4 u	24	good 4 u	1McMsnEElThX1knmY4oliG	Olivia Rodrigo	['pop']	85	0.556	0.661	6	-5.052	0	0.204	0.3	0	0.101	0.668	168.56	178148	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	3FAJ6O0NOHQV8Mc5Ri6ENp	Heartbreak Anniversary	82	TAKE TIME	4fxd5Ee7UefO4CUXgwJ7IP	Giveon	['r&b']	75	0.449	0.465	0	-8.964	1	0.0791	0.524	1.02e-06	0.303	0.543	89.087	198371	3
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	0gplL1WMoJ6iYaPgMCL0gX	Easy On Me	84	Easy On Me	4dpARuHxo51G3z768sgnrY	Adele	['british soul', 'pop', 'pop soul', 'uk pop']	83	0.604	0.366	5	-7.519	1	0.0282	0.578	0	0.133	0.13	141.981	224695	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	5enxwA8aAbwZbf5qCHORXi	All Too Well (10 Minute Version) (Taylor's Version) (From The Vault)	87	Red (Taylor's Version)	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.631	0.518	0	-8.771	1	0.0303	0.274	0	0.088	0.205	93.023	613027	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	4RVwu0g32PAqgUiJoXsdF8	Happier Than Ever	88	Happier Than Ever	6qqNVTkY8uBg9cP3Jd7DAH	Billie Eilish	['art pop', 'electropop', 'pop']	88	0.332	0.225	0	-8.697	1	0.0348	0.767	0.00349	0.128	0.297	81.055	298899	3
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	40iJIUlhi6renaREYGeIDS	Fair Trade (with Travis Scott)	86	Certified Lover Boy	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.666	0.465	1	-8.545	1	0.26	0.0503	0	0.215	0.292	167.937	291175	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	6Uj1ctrBOjOas8xZXGqKk4	Woman	87	Planet Her	5cj0lLjcoR7YOSnhnX0Po5	Doja Cat	['dance pop', 'pop']	86	0.824	0.764	5	-4.175	0	0.0854	0.0888	0.00294	0.117	0.881	107.998	172627	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	3Ofmpyhv5UAQ70mENzB277	Astronaut In The Ocean	77	Astronaut In The Ocean	1uU7g3DNSbsu0QjSEqZtEd	Masked Wolf	['australian hip hop']	64	0.778	0.695	4	-6.865	0	0.0913	0.175	0	0.15	0.472	149.996	132780	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	7hU3IHwjX150XLoTVmjD0q	MONEY	81	LALISA	5L1lO4eRHmJ7a0Q6csE5cT	LISA	['k-pop']	77	0.831	0.554	1	-9.998	0	0.218	0.161	6.12e-05	0.152	0.396	140.026	168228	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	3VqeTFIvhxu3DIe4eZVzGq	Butter	9	Butter	3Nrfpe0tUJi4K4DXYWgMUX	BTS	['k-pop', 'k-pop boy group', 'pop']	87	0.759	0.459	8	-5.187	1	0.0948	0.00323	0	0.0906	0.695	109.997	164442	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	463CkQjx2Zk1yXoBuierM9	Levitating (feat. DaBaby)	75	Levitating (feat. DaBaby)	6M2wZ9GZgrQXHCFfjv46we	Dua Lipa	['dance pop', 'pop', 'uk pop']	86	0.702	0.825	6	-3.787	0	0.0601	0.00883	0	0.0674	0.915	102.977	203064	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	4fSIb4hdOQ151TILNsSEaF	Todo De Ti	79	Todo De Ti	1mcTU81TzQhprhouKaTkpq	Rauw Alejandro	['puerto rican pop', 'reggaeton', 'trap latino', 'urbano latino']	87	0.78	0.718	3	-3.605	0	0.0506	0.31	0.000163	0.0932	0.342	127.949	199604	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	6Im9k8u9iIzKMrmV7BWtlF	34+35	80	Positions	66CXWjxzNUsdJxJ2JdwvnR	Ariana Grande	['pop']	87	0.83	0.585	0	-6.476	1	0.094	0.237	0	0.248	0.485	109.978	173711	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	10hcDov7xmcRviA8jLwEaI	Need to Know	63	Need to Know	5cj0lLjcoR7YOSnhnX0Po5	Doja Cat	['dance pop', 'pop']	86	0.664	0.609	1	-6.509	1	0.0707	0.304	0	0.0926	0.194	130.041	210560	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	4pt5fDVTg5GhEvEtlz9dKk	I WANNA BE YOUR SLAVE	83	Teatro d'ira - Vol. I	0lAWpj5szCSwM4rUMHYmrr	MÃ¥neskin	['indie rock italiano', 'italian pop', 'pop']	78	0.75	0.608	1	-4.008	1	0.0387	0.00165	0	0.178	0.958	132.507	173347	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	0z8hI3OPS8ADPWtoCjjLl6	Summer of Love (Shawn Mendes & Tainy)	77	Summer Of Love	7n2wHs1TKAczGzO7Dd2rGr	Shawn Mendes	['canadian pop', 'pop', 'viral pop']	81	0.776	0.808	11	-4.501	1	0.117	0.0297	0.000127	0.103	0.494	123.988	184104	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	07MDkzWARZaLEdKxo6yArG	Meet Me At Our Spot	78	THE ANXIETY	64H8UqGLbJFHwKtGxiV8OP	THE ANXIETY	['modern alternative pop']	57	0.773	0.47	2	-7.93	1	0.0299	0.0153	0.000193	0.0851	0.399	94.995	162680	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	0eu4C55hL6x29mmeAjytzC	Life Goes On	77	Ugly is Beautiful: Shorter, Thicker & Uglier (Deluxe)	6TLwD7HPWuiOzvXEa3oCNe	Oliver Tree	['alternative hip hop']	72	0.7	0.49	0	-5.187	1	0.076	0.186	0	0.117	0.569	79.982	161803	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	3nY8AqaMNNHHLYV4380ol0	Dick (feat. Doja Cat)	71	Dick (feat. Doja Cat)	2WgfkM8S11vg4kxLgDY3F5	StarBoi3	['slowed and reverb', 'viral rap']	50	0.647	0.608	9	-6.831	1	0.42	0.13	0	0.0584	0.474	125.994	175238	4
https://open.spotify.com/playlist/5GhQiRkGuqzpWZSE7OU4Se	2021	0WSEq9Ko4kFPt8yo3ICd6T	Praise God	78	Donda	5K4W6rqBFWDnAN6FQUkS6x	Kanye West	['chicago rap', 'hip hop', 'rap']	89	0.798	0.545	1	-6.466	1	0.168	0.00904	9.48e-05	0.258	0.212	118.029	226653	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	4LRPiXqCikLlN15c3yImP7	As It Was	90	As It Was	6KImCVD70vtIoJWnq6nGn3	Harry Styles	['pop']	85	0.52	0.731	6	-5.338	0	0.0557	0.342	0.00101	0.311	0.662	173.93	167303	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	1IHWl5LamUGEuP4ozKQSXZ	TitÃ­ Me PreguntÃ³	88	Un Verano Sin Ti	4q3ewBCX7sLwd24euuV69X	Bad Bunny	['reggaeton', 'trap latino', 'urbano latino']	94	0.65	0.715	5	-5.198	0	0.253	0.0993	0.000291	0.126	0.187	106.672	243717	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	0V3wPSX9ygBnCm8psDIegu	Anti-Hero	93	Midnights	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.637	0.643	4	-6.571	1	0.0519	0.13	1.8e-06	0.142	0.533	97.008	200690	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	3nqQXoyQOWXiESFLlDF1hG	Unholy (feat. Kim Petras)	87	Unholy (feat. Kim Petras)	2wY79sveU1sp5g7SokKOiI	Sam Smith	['pop', 'uk pop']	83	0.714	0.472	2	-7.375	1	0.0864	0.013	4.51e-06	0.266	0.238	131.121	156943	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	29d0nY7TzCoi22XBqDQkiP	Running Up That Hill (A Deal With God) - 2018 Remaster	28	Hounds of Love (2018 Remaster)	1aSxMhuvixZ8h9dK9jIDwL	Kate Bush	['art pop', 'art rock', 'baroque pop', 'new wave pop', 'permanent wave', 'piano rock', 'singer-songwriter']	67	0.625	0.533	10	-11.903	0	0.0596	0.659	0.00266	0.0546	0.139	108.296	300840	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	6xGruZOHLs39ZbVccQTuPZ	Glimpse of Us	85	Glimpse of Us	3MZsBdqDrRTJihTHQrO6Dq	Joji	['viral pop']	79	0.44	0.317	8	-9.258	1	0.0531	0.891	4.78e-06	0.141	0.268	169.914	233456	3
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	1xzi1Jcr7mEi9K2RfzLOqS	CUFF IT	87	RENAISSANCE	6vWDO969PvNqNYHIOW5v0m	BeyoncÃ©	['pop', 'r&b']	85	0.78	0.689	7	-5.668	1	0.141	0.0368	9.69e-06	0.0698	0.642	115.042	225389	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	1rDQ4oMwGJI7B4tovsBOxc	First Class	24	First Class	2LIk90788K0zvyj2JJVwkJ	Jack Harlow	['deep underground hip hop', 'kentucky hip hop', 'pop rap', 'rap']	77	0.905	0.563	8	-6.135	1	0.102	0.0254	9.71e-06	0.113	0.324	106.998	173948	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	02MWAaffLxlfxAUY7c5dvx	Heat Waves	40	Dreamland (+ Bonus Levels)	4yvcSjfu4PC0CYQyLy4wSq	Glass Animals	['gauze pop', 'indietronica', 'modern rock', 'pov: indie', 'shiver pop']	74	0.761	0.525	11	-6.9	1	0.0944	0.44	6.7e-06	0.0921	0.531	80.87	238805	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	4k6Uh1HXdhtusDW5y8Gbvy	Bad Habit	84	Gemini Rights	57vWImR43h4CaDao012Ofp	Steve Lacy	['afrofuturism']	79	0.686	0.494	1	-7.093	1	0.0355	0.613	5.8e-05	0.402	0.7	168.946	232067	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	6I3mqTwhRpn34SLVafSH7G	Ghost	87	Justice	1uNFoZAHBGtllmzznpCI3s	Justin Bieber	['canadian pop', 'pop']	87	0.601	0.741	2	-5.569	1	0.0478	0.185	2.91e-05	0.415	0.441	153.96	153190	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	4fouWK6XVHhzl78KzQ1UjL	abcdefu	83	abcdefu	2VSHKHBTiXWplO8lxcnUC9	GAYLE	['modern alternative pop']	65	0.695	0.54	4	-5.692	1	0.0493	0.299	0	0.367	0.415	121.932	168602	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	1qEmFfgcLObUfQm0j1W2CK	Late Night Talking	87	Harry's House	6KImCVD70vtIoJWnq6nGn3	Harry Styles	['pop']	85	0.714	0.728	10	-4.595	1	0.0468	0.298	0	0.106	0.901	114.996	177955	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	5CZ40GBx1sQ9agT82CLQCT	traitor	88	SOUR	1McMsnEElThX1knmY4oliG	Olivia Rodrigo	['pop']	85	0.38	0.339	3	-7.885	1	0.0338	0.691	0	0.12	0.0849	100.607	229227	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	6Sq7ltF9Qa7SNFBsV5Cogx	Me Porto Bonito	90	Un Verano Sin Ti	4q3ewBCX7sLwd24euuV69X	Bad Bunny	['reggaeton', 'trap latino', 'urbano latino']	94	0.911	0.712	1	-5.105	0	0.0817	0.0901	2.68e-05	0.0933	0.425	92.005	178567	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	4C6Uex2ILwJi9sZXRdmqXp	Super Freaky Girl	78	Super Freaky Girl	0hCNtLu0JehylgoiP8L4Gh	Nicki Minaj	['hip pop', 'pop', 'queens hip hop', 'rap']	86	0.95	0.891	2	-2.653	1	0.241	0.0645	1.77e-05	0.309	0.912	133.01	170977	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	1PckUlxKqWQs3RlWXVBLw3	About Damn Time	80	About Damn Time	56oDRnqbIiwx4mymNEv7dS	Lizzo	['escape room', 'minnesota hip hop', 'pop', 'trap queen']	74	0.836	0.743	10	-6.305	0	0.0656	0.0995	0	0.335	0.722	108.966	191822	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	27NovPIUIRrOZoCHxABJwK	INDUSTRY BABY (feat. Jack Harlow)	82	INDUSTRY BABY (feat. Jack Harlow)	7jVv8c5Fj3E9VhNjxT4snq	Lil Nas X	['lgbtq+ hip hop']	76	0.736	0.704	3	-7.409	0	0.0615	0.0203	0	0.0501	0.894	149.995	212000	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	2tTmW7RDtMQtBk7m2rYeSw	Quevedo: Bzrp Music Sessions, Vol. 52	91	Quevedo: Bzrp Music Sessions, Vol. 52	716NhGYqD1jl2wI1Qkgq36	Bizarrap	['argentine hip hop', 'pop venezolano', 'trap argentino', 'trap latino', 'urbano latino']	83	0.621	0.782	2	-5.548	1	0.044	0.0125	0.033	0.23	0.55	128.033	198938	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	5ildQOEKmJuWGl2vRkFdYc	DESPECHÃ	82	DESPECHÃ	7ltDVBr6mKbRvohxheJ9h1	ROSALÃA	['pop', 'r&b en espanol']	81	0.919	0.623	7	-6.521	1	0.0992	0.184	1.63e-05	0.0609	0.775	130.037	157018	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	7rglLriMNBPAyuJOMGwi39	Cold Heart - PNAU Remix	72	The Lockdown Sessions	3PhoLpVuITZKcymswpck5b	Elton John	['glam rock', 'mellow gold', 'piano rock', 'rock']	81	0.795	0.8	1	-6.32	1	0.0309	0.0354	7.25e-05	0.0915	0.934	116.032	202735	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	5IgjP7X4th6nMNDh4akUHb	Under The Influence	89	Indigo (Extended)	7bXgB6jMjp9ATFy66eO08Z	Chris Brown	['pop rap', 'r&b', 'rap']	84	0.733	0.69	9	-5.529	0	0.0427	0.0635	1.18e-06	0.105	0.31	116.992	184613	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	59CfNbkERJ3NoTXDvoURjj	Boyfriend	82	Boyfriend	2W8yFh0Ga6Yf3jiayVxwkE	Dove Cameron	['pop']	69	0.345	0.612	7	-6.543	0	0.0608	0.232	0	0.194	0.232	179.773	153000	3
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	5jQI2r1RdgtuT8S3iG8zFC	Lavender Haze	86	Midnights	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.733	0.436	10	-10.489	1	0.08	0.258	0.000573	0.157	0.0976	96.985	202396	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	3IAfUEeaXRX9s9UdKOJrFI	Envolver	76	Envolver	7FNnA9vBm6EKceENgCGRMb	Anitta	['funk pop', 'funk rj', 'pagode baiano', 'pop', 'pop nacional']	76	0.812	0.736	4	-5.421	0	0.0833	0.152	0.00254	0.0914	0.396	91.993	193806	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	0skYUMpS0AcbpjcGsAbRGj	Pink Venom	73	Pink Venom	41MozSoPIsD1dJM0CLPjZF	BLACKPINK	['k-pop', 'k-pop girl group', 'pop']	83	0.798	0.697	0	-7.139	1	0.0891	0.0202	0	0.259	0.745	90.031	186964	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	0e8nrvls4Qqv5Rfa2UhqmO	THATS WHAT I WANT	84	MONTERO	7jVv8c5Fj3E9VhNjxT4snq	Lil Nas X	['lgbtq+ hip hop']	76	0.737	0.846	1	-4.51	0	0.22	0.00614	0	0.0486	0.546	87.981	143901	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	4h9wh7iOZ0GGn8QVp4RAOB	I Ain't Worried	92	I Ainâ€™t Worried (Music From The Motion Picture "Top Gun: Maverick")	5Pwc4xIPtQLFEnJriah9YJ	OneRepublic	['piano rock', 'pop']	81	0.704	0.797	0	-5.927	1	0.0475	0.0826	0.000745	0.0546	0.825	139.994	148486	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	0mBP9X2gPCuapvpZ7TGDk3	Left and Right (Feat. Jung Kook of BTS)	81	Left and Right (Feat. Jung Kook of BTS)	6VuMaDnrHyPL1p4EHjYLi7	Charlie Puth	['pop', 'viral pop']	80	0.881	0.592	2	-4.898	1	0.0324	0.619	1.32e-05	0.0901	0.719	101.058	154487	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	35ovElsgyAtQwYPYnZJECg	Lift Me Up - From Black Panther: Wakanda Forever - Music From and Inspired By	78	Lift Me Up (From Black Panther: Wakanda Forever - Music From and Inspired By)	5pKCCKE2ajJHZ9KAiaK11H	Rihanna	['barbadian pop', 'pop', 'urban contemporary']	87	0.247	0.299	9	-6.083	1	0.0315	0.899	0	0.131	0.172	177.115	196520	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	52xJxFP6TqMuO4Yt0eOkMz	We Don't Talk About Bruno	77	Encanto (Original Motion Picture Soundtrack)	29PgYEggDV3cDP9QYTogwv	Carolina GaitÃ¡n - La Gaita	['movie tunes']	56	0.577	0.45	0	-8.516	0	0.0834	0.357	0	0.111	0.83	205.863	216120	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	2KukL7UlQ8TdvpaA7bY3ZJ	BREAK MY SOUL	72	BREAK MY SOUL	6vWDO969PvNqNYHIOW5v0m	BeyoncÃ©	['pop', 'r&b']	85	0.687	0.887	1	-5.04	0	0.0826	0.0575	2.21e-06	0.27	0.853	114.941	278282	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	6Uj1ctrBOjOas8xZXGqKk4	Woman	87	Planet Her	5cj0lLjcoR7YOSnhnX0Po5	Doja Cat	['dance pop', 'pop']	86	0.824	0.764	5	-4.175	0	0.0854	0.0888	0.00294	0.117	0.881	107.998	172627	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	7dSZ6zGTQx66c2GF91xCrb	PROVENZA	81	PROVENZA	790FomKkXshlbRYZFtlgla	KAROL G	['reggaeton', 'reggaeton colombiano', 'trap latino', 'urbano latino']	90	0.87	0.516	1	-8.006	1	0.0541	0.656	0.00823	0.11	0.53	111.005	210200	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	2rurDawMfoKP4uHyb2kJBt	Te Felicito	83	Te Felicito	0EmeFodog0BfCgMzAIvKQp	Shakira	['colombian pop', 'dance pop', 'latin pop', 'pop']	85	0.695	0.636	5	-4.654	1	0.317	0.234	0	0.081	0.575	174.14	172235	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	6Xom58OOXk2SoU711L2IXO	Moscow Mule	86	Un Verano Sin Ti	4q3ewBCX7sLwd24euuV69X	Bad Bunny	['reggaeton', 'trap latino', 'urbano latino']	94	0.804	0.674	5	-5.453	0	0.0333	0.294	1.18e-06	0.115	0.292	99.968	245940	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	0ARKW62l9uWIDYMZTUmJHF	Shut Down	76	BORN PINK	41MozSoPIsD1dJM0CLPjZF	BLACKPINK	['k-pop', 'k-pop girl group', 'pop']	83	0.82	0.686	0	-5.102	1	0.038	0.00412	0	0.184	0.668	110.058	175889	3
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	1ri9ZUkBJVFUdgwzCnfcYs	MAMIII	78	MAMIII	4obzFoKoKRHIphyHzJ35G3	Becky G	['latin pop', 'latin viral pop', 'rap latina', 'reggaeton', 'trap latino', 'urbano latino']	77	0.843	0.7	4	-3.563	0	0.0803	0.0934	0	0.14	0.899	93.991	226088	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	7mFj0LlWtEJaEigguaWqYh	Sweetest Pie	74	Sweetest Pie	181bsRPaVXVlUKXrxwZfHK	Megan Thee Stallion	['houston rap', 'pop', 'r&b', 'rap', 'trap queen']	75	0.814	0.628	7	-7.178	1	0.221	0.167	0	0.101	0.677	123.977	201334	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	1oFAF1hdPOickyHgbuRjyX	Save Your Tears (Remix) (with Ariana Grande) - Bonus Track	82	After Hours (Deluxe)	1Xyo4u8uXC1ZmMpatF05PJ	The Weeknd	['canadian contemporary r&b', 'canadian pop', 'pop']	94	0.65	0.825	0	-4.645	1	0.0325	0.0215	2.44e-05	0.0936	0.593	118.091	191014	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	34ZAzO78a5DAVNrYIGWcPm	Shirt	73	Shirt	7tYKF4w9nC0nq9CsPZTHyP	SZA	['pop', 'r&b', 'rap']	87	0.824	0.453	3	-9.604	0	0.0968	0.146	0.0273	0.0896	0.552	119.959	181831	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	3F5CgOj3wFlRv51JsHbxhe	Jimmy Cooks (feat. 21 Savage)	89	Honestly, Nevermind	3TVXtAsR1Inumwj472S9r4	Drake	['canadian hip hop', 'canadian pop', 'hip hop', 'pop rap', 'rap']	94	0.529	0.673	0	-4.711	1	0.175	0.000307	2.41e-06	0.093	0.366	165.921	218365	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	3rWDp9tBPQR9z6U5YyRSK4	Midnight Rain	86	Midnights	06HL4z0CvFAxyc27GXpf02	Taylor Swift	['pop']	100	0.643	0.363	0	-11.738	1	0.0767	0.69	5.17e-05	0.115	0.23	139.865	174783	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	2g6tReTlM2Akp41g0HaeXN	Die Hard	79	Mr. Morale & The Big Steppers	2YZyLoL8N0Wb9xBt1NhZWg	Kendrick Lamar	['conscious hip hop', 'hip hop', 'rap', 'west coast rap']	86	0.775	0.736	1	-8.072	0	0.247	0.319	0.00116	0.127	0.362	100.988	239027	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	4pi1G1x8tl9VfdD9bL3maT	Big Energy	69	777	3MdXrJWsbVzdn6fe5JYkSQ	Latto	['trap queen']	85	0.937	0.793	11	-4.431	0	0.115	0.0453	0	0.341	0.794	106.022	172540	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	3LtpKP5abr2qqjunvjlX5i	Doja	86	Doja	5H4yInM5zmHqpKIoMNAx4r	Central Cee	['melodic drill']	82	0.911	0.573	6	-7.43	1	0.288	0.38	0	0.403	0.972	140.04	97393	4
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	3XOalgusokruzA5ZBA2Qcb	pushin P (feat. Young Thug)	77	DS4EVER	2hlmm7s2ICUX0LVIhVFlZQ	Gunna	['atl hip hop', 'melodic rap', 'rap', 'trap']	84	0.773	0.422	1	-4.572	0	0.187	0.00783	0.00693	0.129	0.488	77.502	136267	1
https://open.spotify.com/playlist/56r5qRUv3jSxADdmBkhcz7	2022	1r8ZCjfrQxoy2wVaBUbpwg	Thousand Miles	77	Thousand Miles	2tIP7SsRs7vjIcLrU85W8J	The Kid LAROI	['australian hip hop']	78	0.376	0.657	7	-4.658	1	0.0768	0.0858	0	0.0884	0.203	80.565	164782	4
\.


--
-- TOC entry 4883 (class 0 OID 75959)
-- Dependencies: 225
-- Data for Name: track_artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.track_artists (track_id, artist_id) FROM stdin;
7BqBn9nzAq8spo5e7cZ0dJ	0du5cEVh5yTK9QJze8zA0C
15JINEqzVMv3SvJTAXAKED	7dGJo4pcD2V6oG8kP0tJRR
4HlFJV71xXKIGcU3kRyttv	3FUY2gzHeIiaesXtOAdB7A
2GYHyAoLWpkxLVa4oYTVko	5j4HeCoUlzhfWtjAfM1acR
0HPD5WQqrq7wPWR7P7Dw1i	6LqNN22kT3074XbTVUrhzX
4dTaAiV9xFFCxnPur9c9yL	1Cs0zKBU1kc0i8ypK3B9ai
3ZdJffjzJWFimSQyxgGIxN	2gBjLmx6zQnFGQJCAQpRgw
3GBApU0NuzH4hKZq4NOSdA	536BYVgOnRky0xjsPT96zl
1bM50INir8voAkVoKuvEUI	23zg3TcAtWQy7J6upgbUnj
2M9ULmQwTaTGmAdXaXpfz5	7o9Nl7K1Al6NNAHX6jn6iG
5jzKL4BDMClWqRguW5qZvh	6jJ0s89eD6GaHleKKya26X
4TCL0qqKyqsMZml0G3M9IM	1HY2Jd0NmPuamShAr6KMms
5vlEg2fT4cFWAqU5QptIpQ	5tKXB9uuebKE34yowVaU3C
6lV2MSQmRIkycDScNtrBXO	5ndkK3dpZLKtBklKjxNQwT
4AYX69oFP3UOS1CFmV9UfO	2iojnBLj0qIMiKPvVhLnsH
1HHeOs6zRdF8Ck58easiAY	1HY2Jd0NmPuamShAr6KMms
5sra5UY6sD658OabHL3QtI	3DiDSECUqqY1AuBP8qtaIa
6BdgtqiV3oXNqBikezwdvC	3TVXtAsR1Inumwj472S9r4
7ElF5zxOwYP4qVSWVvse3W	6MF9fzBmfXghAz953czmBC
6wN4nT2qy3MQc098yL3Eu9	7bXgB6jMjp9ATFy66eO08Z
4YYHgF9dWyVSor0GtrBzdf	5pKCCKE2ajJHZ9KAiaK11H
61LtVmmkGr8P9I2tSPvdpf	1EeArivTpzLNCqubV95255
0WCiI0ddWiu5F2kSHgfw5S	6LqNN22kT3074XbTVUrhzX
2DHc2e5bBn4UzY0ENVFrUl	5Y5TRrQiqgUO4S36tzjIRZ
4BycRneKmOs6MhYG9THsuX	3TVXtAsR1Inumwj472S9r4
4u26EevCNXMhlvE1xFBJwX	75FnCoo4FBxH5K1Rrx0k5A
0oJMv049q8hEkes9w0L1J4	1yxSLGMDHlW21z4YXirZDS
7HacCTm33hZYYN8DXpCYuG	7qG3b048QCHVRO5Pv1T5lw
0JcKdUGNR7zI4jJDLyYXbi	0hYxQe3AK5jBPCr5MumLHD
030OCtLMrljNhp8OWHBWW3	23zg3TcAtWQy7J6upgbUnj
7hR5toSPEgwFZ78jfHdANM	0hEurMDQu99nJRq8pTxO14
2r6DdaSbkbwoPzuK6NjLPn	5YGY8feqx7naU7z4HrwZM6
45O0tUN9Bh6LH4eNxQ07AT	6S0dmVVn4udvppDhZIWxCr
37dYAkMa4lzRCH6kDbMT1L	4KkHjCe8ouh8C2P9LPoD4F
7AqISujIaWcY3h5zrOqt5v	5nLYd9ST4Cnwy6NHaCxbj8
1hBM2D1ULT3aeKuddSwPsK	0FWzNDaEu9jdgcYTbcOa4F
0dBW6ZsW8skfvoRfgeerBF	06HL4z0CvFAxyc27GXpf02
07WEDHF2YwVgYuBugi2ECO	6Vh6UDWfu9PUSXSzAaB3CW
4gs07VlJST4bdxGbBsXVue	0hEurMDQu99nJRq8pTxO14
3uIGef7OSXkFdqxjFWn2o6	6r20qOqY7qDWI0PPTxVMlC
2fQ6sBFWaLv2Gxos4igHLy	2iojnBLj0qIMiKPvVhLnsH
1WtTLtofvcjQM3sXSMkDdX	3ipn9JLAPI5GUEo4y4jcoi
2rDwdvBma1O1eLzo29p2cr	6prmLEyn4LfHlD9NnXWlf7
5BoIP8Eha5hwmRVURkC2Us	07YZf4WDAMNwqr4jfgOZ8y
17tDv8WA8IhqE8qzuQn707	0FWzNDaEu9jdgcYTbcOa4F
6KBYk8OFtod7brGuZ3Y67q	04gDigrS5kc9YWfZHwBETP
41KPpw0EZCytxNkmEMJVgr	1h6Cn3P4NGzXbaXidqURXs
1yK9LISg5uBOOW5bT2Wm0i	3DiDSECUqqY1AuBP8qtaIa
3VA8T3rNy5V24AXxNK5u9E	2Sqr0DXoaYABbjBo9HaMkM
09ZcYBGFX16X8GMDrvqQwt	3AQRLZ9PuTAozP28Skbq8V
7g13jf3zqlP5S68Voo5v9m	6UE7nl9mha6s8z0wFQFIZ2
6GgPsuz0HEO0nrO2T0QhDv	6f4XkbvYlXMH0QgVRzW0sM
0zREtnLmVnt8KUJZZbSdla	7pGyQZx9thVa8GxMBeXscB
2tNE4DP5nL85XUJv1glO0a	2wpJOPmf1TIOzrB9mzHifd
5ZFVacinyPxz19eK2vTodL	1h6Cn3P4NGzXbaXidqURXs
5e0dZqrrTaoj6AIL7VjnBM	0Tob4H0FLtEONHU1MjpUEp
0XvjOhwCnXXFOSlBbV9jPN	0q8J3Yj810t5cpAYEJ7gxt
31zeLcKH2x3UCMHT75Gk5C	3AuMNF8rQAKOzjYppFNAoB
6FSxwdN08PvzimGApFjRnY	3906URNmNa1VCXEeiJ3DSH
1c8gk2PeTE04A1pIDH9YMk	4dpARuHxo51G3z768sgnrY
7LcfRTgAVTs5pQGEQgUEzN	04gDigrS5kc9YWfZHwBETP
0IkKz2J93C94Ei4BvDop7P	3sgFRtyBnxXD5ESfmbK4dl
4r6eNCsrZnQWJzzvFh4nlg	6jJ0s89eD6GaHleKKya26X
2tJulUYLDKOg9XrtVkMgcJ	0du5cEVh5yTK9QJze8zA0C
0JXXNGljqupsJaZsgSbMZV	360IAlyVv4PCEVjgyMZrxK
1eyzqe2QqGZUmfcPZtrIyt	63MQldklfxkjYDoUE4Tppz
5Qy6a5KzM4XlRxsNcGYhgH	55Aa2cqylxrFIXC767Z865
4RL77hMWUq35NYnPLXBpih	2WX2uTcsvV5OnS0inACecP
3hsmbFKT5Cujb5GQjqEU39	7bXgB6jMjp9ATFy66eO08Z
3LUWWox8YYykohBbHUrrxd	6LqNN22kT3074XbTVUrhzX
2U8g9wVcUu9wsg6i7sFSv8	4gzpq5DPGxSnKTe4SA8HAU
2i0AUcEnsDm3dsqLrFWUCq	6jTnHxhb6cDCaCu4rdvsQ0
4NTWZqvfQTlOMitlVn6tew	01QTIT5P1pFP3QnnFSdsJf
0aBKFfdyOD1Ttvgv0cfjjJ	23zg3TcAtWQy7J6upgbUnj
608a1wIsSd5KzMEqm1O7w3	0QHgL1lAIqAw0HtD7YldmP
70ATm56tH7OrQ1zurYssz0	6DPYiyq5kWVQS4RGwxzPC7
16Of7eeW44kt0a1M0nitHM	2aYJ5LAta2ScCdfLhKgZOY
4fINc8dnfcz7AdhFYVA4i7	07YZf4WDAMNwqr4jfgOZ8y
6r2BECwMgEoRb5yLfp0Hca	1HY2Jd0NmPuamShAr6KMms
3pYDZTJM2tVBUhIRifWVzI	6LqNN22kT3074XbTVUrhzX
2OXidlnDThZR3zf36k6DVL	32WkQRZEVKSzVAAYqukAEA
2TUzU4IkfH8kcvY2MUlsd2	3LpLGlgRS1IKPPwElnpW35
1r3myKmjWoOqRip99CmSj1	07YZf4WDAMNwqr4jfgOZ8y
1PAYgOjp1c9rrZ2kVQg2vN	6Vh6UDWfu9PUSXSzAaB3CW
53DB6LJV9B8sz0p1s6tlGS	137W8MRPWKqSmrBGDBFSop
36cmM3MBMWWCFIiQ90U4J8	7CajNmpbOovFoOoasH2HaY
04OxTCLGgDKfO0MMA2lcxv	3jNkaOXasoc7RsxdchvEVq
5E6CDAxnBqc9V9Y6t5wTUE	0BmLNz4nSLfoWYW1cYsElL
1f8UCzB3RqIgNkW7QIiIeP	3whuHq0yGx60atvA2RCVRW
3SxiAdI8dP9AaaEz1Z24mn	2feDdbD5araYcm6JhFHHw7
0IF7bHzCXCZoKNog5vBC4g	0qk8MxMzgnfFECvDO3cc0X
1Fxp4LBWsNC58NwnGAXJld	2ajhZ7EA6Dec0kaWiKCApF
35KiiILklye1JRRctaLUb4	4LEiUm1SRbFMgfqnQTwUbQ
3FrX3mx8qq7SZX2NYbzDoj	1Cs0zKBU1kc0i8ypK3B9ai
6y468DyY1V67RBNCwzrMrC	0aeLcja6hKzb7Uz2ou7ulP
7mdNKXxia7AeSuJqjjA2rb	7bXgB6jMjp9ATFy66eO08Z
3TGRqZ0a2l1LRblBkJoaDx	6sFIWsNpZYqfjUpaCgueju
7a86XRg84qjasly9f6bPSD	5nCi3BB41mBaMH9gfr6Su0
1z9kQ14XBSN0r2v6fx4IdG	5pKCCKE2ajJHZ9KAiaK11H
4cluDES4hQEUhmXj6TXkSo	4AK6F7OLvEQ5QYCBNiQWHq
2V65y3PX4DkRhy1djlxd9p	1h6Cn3P4NGzXbaXidqURXs
1gihuPhrLraKYrJMAEONyc	7CajNmpbOovFoOoasH2HaY
6VObnIkLVruX4UVyxWhlqm	4dpARuHxo51G3z768sgnrY
5UqCQaDshqbIk3pkhy4Pjg	1vCWHaC5f2uS3yhpwWbIA6
2iUmqdfGZcHIhS3b9E9EWq	0RpddSzUHfncUWNJXKOsjy
0U10zFw4GlBacOy9VDGfGL	5pKCCKE2ajJHZ9KAiaK11H
0KAiuUOrLTIkzkpfpn9jb9	3FUY2gzHeIiaesXtOAdB7A
1NpW5kyvO4XrNJ3rnfcNy3	0jnsk9HBra6NMjO2oANoPY
1auxYwYrFRqZP7t3s7w4um	3nFkdlSjzX9mRTtwJOzDYB
4wCmqSrbyCgxEXROQE6vtV	2AsusXITU8P25dlRNhcAbG
4Kz4RdRCceaA9VgTqBhBfa	3TVXtAsR1Inumwj472S9r4
1oHNvJVbFkexQc0BpQp7Y4	0hCNtLu0JehylgoiP8L4Gh
7oVEtyuv9NBmnytsCIsY5I	6XyY86QOPPrYVGvF9ch6wz
6s8nHXTJVqFjXE4yVZPDHR	3whuHq0yGx60atvA2RCVRW
1nZzRJbFvCEct3uzu04ZoL	6jJ0s89eD6GaHleKKya26X
03UrZgTINDqvnUMbbIMhql	2dd5mrQZvg6SmahdgVKDzh
0TAmnCzOtqRfvA38DDLTjj	4AK6F7OLvEQ5QYCBNiQWHq
56sxN1yKg1dgOZXBcAHkJG	6p5JxpTc7USNnBnLzctyd4
4sOX1nhpKwFWPvoMMExi3q	6CwfuxIqcltXDGjfZsMd9A
3n69hLUdIsSa1WlRmjMZlW	3XHO7cRUPCLOr6jwp8vsx5
3tyPOhuVnt5zd5kGfxbCyL	5pKCCKE2ajJHZ9KAiaK11H
6Vh03bkEfXqekWp7Y1UBRb	4AK6F7OLvEQ5QYCBNiQWHq
4qikXelSRKvoCqFcHLB2H2	5K4W6rqBFWDnAN6FQUkS6x
3oL3XRtkP1WVbMxf7dtTdu	6jJ0s89eD6GaHleKKya26X
53QF56cjZA9RTuuMZDrSA6	4phGZZrJZRo4ElhRtViYdl
4P0osvTXoSYZZC2n8IFH3c	04gDigrS5kc9YWfZHwBETP
1DunhgeZSEgWiIYbHqXl0c	6nS5roXSAGhTGr34W6n7Et
1EAgPzRbK9YmdOESSMUm6P	6p5JxpTc7USNnBnLzctyd4
6HZ9VeI5IRFCNQLXhpF4bq	1VBflYyxBhnDc9uVib98rw
3sP3c86WFjOzHHnbhhZcLA	6S2OmqARrzebs0tKUEyXyp
6VRhkROS2SZHGlp0pxndbJ	5he5w2lnU9x7JFhnwcekXX
0lHAMNU8RGiIObScrsRgmP	1Cs0zKBU1kc0i8ypK3B9ai
4HXOBjwv2RnLpGG4xWOO6N	4gzpq5DPGxSnKTe4SA8HAU
2sEk5R8ErGIFxbZ7rX6S2S	6CwfuxIqcltXDGjfZsMd9A
6KuHjfXHkfnIjdmcIvt9r0	53XhwfbYqKCa1cC15pYq2q
6t6oULCRS6hnI7rm0h5gwl	5nCi3BB41mBaMH9gfr6Su0
5g7rJvWYVrloJZwKiShqlS	4dwdTW1Lfiq0cM8nBAqIIz
5ujh1I7NZH5agbwf7Hp8Hc	2YZyLoL8N0Wb9xBt1NhZWg
0RUGuh2uSNFJpGMSsD1F5C	0du5cEVh5yTK9QJze8zA0C
3WD91HQDBIavSapet3ZpjG	00FQb4jTyendYWaN8pK0wa
25cUhiAod71TIQSNicOaW3	360IAlyVv4PCEVjgyMZrxK
5NlFXQ0si6U87gXs6hq81B	2HcwFjNelS49kFbfvMxQYw
2EcsgXlxz99UMDSPg5T8RF	2feDdbD5araYcm6JhFHHw7
4kte3OcW800TPvOVgrLLj8	21E3waRsmPlU7jZsS13rcj
68rcszAg5pbVaXVvR7LFNh	7t51dSX8ZkKC7VoKRd0lME
5JLv62qFIS1DR3zGEcApRt	6jJ0s89eD6GaHleKKya26X
4b4c0oH7PtrPsI86drzgFs	2NhdGz9EDv2FeUw6udu2g1
439TlnnznSiBbQbgXiBqAd	2YZyLoL8N0Wb9xBt1NhZWg
0MOiv7WTXCqvm89lVCf9C8	5fahUm8t5c0GIdeTq0ZaG8
0c4IEciLCDdXEhhKxj4ThA	12Chz98pHFMPJEknJQMWvI
5wEreUfwxZxWnEol61ulIi	00FQb4jTyendYWaN8pK0wa
2NniAhAtkRACaMeYt48xlD	3FUY2gzHeIiaesXtOAdB7A
6j7hih15xG2cdYwIJnQXsq	5DYAABs8rkY9VhwtENoQCz
06h3McKzmxS8Bx58USHiMq	1vCWHaC5f2uS3yhpwWbIA6
0obBFrPYkSoBJbvHfUIhkv	3sgFRtyBnxXD5ESfmbK4dl
0ZyfiFudK9Si2n2G9RkiWj	00FQb4jTyendYWaN8pK0wa
78JKJfKsqgeBDBF58gv1SF	5IcR3N7QB1j6KBL8eImZ8m
7B1Dl3tXqySkB8OPEwVvSu	7CajNmpbOovFoOoasH2HaY
28GUjBGqZVcAV4PHSYzkj2	5ndkK3dpZLKtBklKjxNQwT
5kcE7pp02ezLZaUbbMv3Iq	0hCNtLu0JehylgoiP8L4Gh
1RMRkCn07y2xtBip9DzwmC	7bXgB6jMjp9ATFy66eO08Z
3zsRP8rH1kaIAo9fmiP4El	3iOvXCl6edW5Um0fXEBRXy
0vFMQi8ZnOM2y8cuReZTZ2	4xFUf1FHVy696Q1JQZMTRj
2L7rZWg9RLxIwnysmxm4xk	1uNFoZAHBGtllmzznpCI3s
3e0yTP5trHBBVvV32jwXqF	6DIS6PRrLS3wbnZsf7vYic
4rHZZAmHpZrA3iH5zx8frV	31TPClRtHm23RisEBtV3X7
5PUvinSo4MNqW7vmomGRS7	0ZrpamOxcZybMHGg1AYtHP
2dLLR6qlu5UJ5gk0dKz0h3	163tK9Wjr9P9DmM0AVK7lm
2QjOHCTQ1Jl3zawyYOpxh6	77SW9BnxLY8rJ0RciFqkHh
3JvKfv6T31zO0ini8iNItO	2txHhyCwHjUEpJjWrEyqyX
0nrRP2bk19rLc0orkWPQk2	1vCWHaC5f2uS3yhpwWbIA6
5FVd6KXrgO9B3JPmC8OPst	7Ln80lUS6He07XvHI8qqHH
6Z8R6UsFuGXGtiIxiD8ISb	4gwpcMTbLWtBUlOijbVpuu
4G8gkOterJn0Ywt6uhqbhp	53XhwfbYqKCa1cC15pYq2q
0nJW01T7XtvILxQgC5J7Wh	0du5cEVh5yTK9QJze8zA0C
2XHzzp1j4IfTNp1FTn7YFg	55Aa2cqylxrFIXC767Z865
1mKXFLRA179hdOWQBwUk9e	1KCSPY1glIKqW2TotWuXOR
1yjY7rpaAQvKwpdUliHx0d	74XFHRwlV6OrjEM0A2NCMF
3bidbhpOYeV4knp8AIu8Xn	5BcAKTbp20cv7tC5VqPFoC
2Foc5Q5nqNiosCNqttzHof	4tZwfgrHOc3mvqYlEYSvVi
086myS9r57YsLbJpU0TgK9	7Ln80lUS6He07XvHI8qqHH
190jyVPHYjAqEaOGmMzdyk	1uNFoZAHBGtllmzznpCI3s
2vwlzO0Qp8kfEtzTsCXfyE	5YGY8feqx7naU7z4HrwZM6
55h7vJchibLdUkxdlX3fK7	0du5cEVh5yTK9QJze8zA0C
0NlGoUyOJSuSHmngoibVAs	4BxCuXFJrSWGi1KHcVqaU4
2ihCaVdNZmnHZWt0fvAM7B	4dwdTW1Lfiq0cM8nBAqIIz
6CjtS2JZH9RkDz5UVInsa9	5BcAKTbp20cv7tC5VqPFoC
5cc9Zbfp9u10sfJeKZ3h16	73sIBHcqh3Z3NyqHKZ7FOL
5CMjjywI0eZMixPeqNd75R	4tZwfgrHOc3mvqYlEYSvVi
5DI9jxTHrEiFAhStG7VA8E	3TVXtAsR1Inumwj472S9r4
0qwcGscxUHGZTgq0zcaqk1	0p4nmQO2msCgU4IF37Wi3j
0S4RKPbRDA72tvKwVdXQqe	66CXWjxzNUsdJxJ2JdwvnR
0mvkwaZMP2gAy2ApQLtZRv	1GxkXlMwML1oSg5eLPiAz3
1KtD0xaLAikgIt5tPbteZQ	7CajNmpbOovFoOoasH2HaY
5jyUBKpmaH670zrXrE0wmO	6hyMWrxGBsOx6sWcVj1DqP
6KkyuDhrEhR5nJVKtv9mCf	4BxCuXFJrSWGi1KHcVqaU4
3Tu7uWBecS6GsLsL8UONKn	0TnOYISbd1XYRBk9myaseg
01TuObJVd7owWchVRuQbQw	085pc2PYOi8bGKj0PNjekA
5VSCgNlSmTV2Yq5lB40Eaw	34v5MVKeQnIo0CWYMbbrPf
2QD4C6RRHgRNRAyrfnoeAo	1Cs0zKBU1kc0i8ypK3B9ai
1oHxIPqJyvAYHy0PVrDU98	7CajNmpbOovFoOoasH2HaY
1zVhMuH7agsRe6XkljIY4U	7H55rcKCfwqkyDFH9wpKM6
5zdkUzguZYAfBH9fnWn3Zl	61lyPtntblHJvA7FMMhi7E
5FljCWR0cys07PQ9277GTz	07YZf4WDAMNwqr4jfgOZ8y
5BhsEd82G0Mnim0IUH6xkT	3b8QkneNDz4JHKKKlLgYZg
0s0JMUkb2WCxIJsRB3G7Hd	3whuHq0yGx60atvA2RCVRW
52gvlDnre9craz9dKGObp8	1bT7m67vi78r2oqvxrP3X5
5vL0yvddknhGj7IrBc6UTj	6jJ0s89eD6GaHleKKya26X
2FV7Exjr70J652JcGucCtE	3CjlHNtplJyTf9npxaPl5w
5O2P9iiztwhomNh8xkR9lJ	4AK6F7OLvEQ5QYCBNiQWHq
2tpWsVSb9UEmDRxAl1zhX1	5Pwc4xIPtQLFEnJriah9YJ
0FDzzruyVECATHXKHFs9eJ	4gzpq5DPGxSnKTe4SA8HAU
1HNkqx9Ahdgi1Ixy2xkKkL	6eUKZXaKkcviH0Ku9w2n3V
3U4isOIWM3VvDubwSI3y7a	5y2Xq6xcjJb2jVM54GHK3t
7795WJLVKJoAyVoOtCWqXN	2wY79sveU1sp5g7SokKOiI
4gbVRS8gloEluzf0GzDOFc	04gDigrS5kc9YWfZHwBETP
6YUTL4dYpB9xZO5qExPf05	7CajNmpbOovFoOoasH2HaY
3cHyrEgdyYRjgJKSOiOtcS	0TnOYISbd1XYRBk9myaseg
4nVBt6MZDDP6tRVdQTgxJg	4AK6F7OLvEQ5QYCBNiQWHq
6RtPijgfPKROxEzTHNRiDp	0DxeaLnv6SyYk2DOqkLO8c
62ke5zFUJN6RvtXZgVH0F8	4fwuXg6XQHfdlOdmw36OHa
5Nm9ERjJZ5oyfXZTECKmRt	2wY79sveU1sp5g7SokKOiI
6FE2iI43OZnszFLuLtvvmg	2l35CQqtYRh3d8ZIiBep4v
2iuZJX9X9P0GKaE93xcPjk	04gDigrS5kc9YWfZHwBETP
60nZcImufyMA1MKQY3dcCH	2RdwBSPQiwcmiDo9kixcl8
2ixsaeFioXJmMgkkbd4uj1	2ysnwxxNtSgbb9t1m2Ur4j
5Hroj5K7vLpIG4FNCRIjbP	0MlOPi3zIDMVrfA9R04Fe3
2Bs4jQEGMycglOfWPBqrVG	4AK6F7OLvEQ5QYCBNiQWHq
0puf9yIluy9W0vpMEUoAnN	2gsggkzM5R49q6jpPvazou
7vS3Y0IKjde7Xg85LWIEdP	66CXWjxzNUsdJxJ2JdwvnR
4N1MFKjziFHH4IS3RYYUrU	1dgdvbogmctybPrGEcnYf6
5lF0pHbsJ0QqyIrLweHJPW	0X2BH1fck6amBIoJhDVmmJ
5jE48hhRu8E6zBDPRSkEq7	6JL8zeS1NmiOftqZTRgdTz
5BrTUo0xP1wKXLJWUaGFtk	7bXgB6jMjp9ATFy66eO08Z
14OxJlLdcHNpgsm4DRwDOB	4NHQUGzhtTLFvgF5SZesLK
6Vc5wAMmXdKIAM7WUoEb7N	5xKp3UyavIBUsGy3DQdXeF
0Dc7J9VPV4eOInoxUiZrsL	3KV3p5EY4AvKxOlhGHORLg
5KONnBIQ9LqCxyeSPin26k	07YZf4WDAMNwqr4jfgOZ8y
5BJSZocnCeSNeYMj3iVqM7	5Pwc4xIPtQLFEnJriah9YJ
7m3povhdMDLZwuEKak0l0n	2o5jDhtHVPhrJdv3cEQ99Z
39lS97papXAI72StGRtZBo	3whuHq0yGx60atvA2RCVRW
2GQEM9JuHu30sGFvRYeCxz	28j8lBWDdDSHSSt5oPlsX2
69gQgkobVW8bWjoCjBYQUd	61lyPtntblHJvA7FMMhi7E
1fu5IQSRgPxJL2OTP7FVLW	6eUKZXaKkcviH0Ku9w2n3V
2dRvMEW4EwySxRUtEamSfG	0C8ZW7ezQVs4URX5aX7Kqx
2stPxcgjdSImK7Gizl8ZUN	0id62QV2SZZfvBn9xpmuCl
2sLwPnIP3CUVmIuHranJZU	07YZf4WDAMNwqr4jfgOZ8y
4z7gh3aIZV9arbL9jJSc5J	7nDsS0l5ZAzMedVRKPP8F1
3nB82yGjtbQFSU0JLAwLRH	31TPClRtHm23RisEBtV3X7
6p5abLu89ZSSpRQnbK9Wqs	0f5nVCcR06GX8Qikz0COtT
32OlwWuMpZ6b0aN2RZOeMS	3hv9jJF3adDNsBSIQDqcjp
2JzZzZUQj3Qff7wapcbKjc	137W8MRPWKqSmrBGDBFSop
4B0JvthVoAAuygILe3n4Bs	1uNFoZAHBGtllmzznpCI3s
1Lim1Py7xBgbAkAys3AGAG	738wLrAtLtCtFOLvQBXOXp
2PIvq1pGrUjY007X5y1UpM	1Xyo4u8uXC1ZmMpatF05PJ
3zHq9ouUJQFQRf3cm1rRLu	0X2BH1fck6amBIoJhDVmmJ
0ct6r3EGTcMLPtrXHDvVjc	1vCWHaC5f2uS3yhpwWbIA6
6K4t31amVTZDgR3sKmwUJJ	5INjqkS1o8h1imAzPqGZBb
5E30LdtzQTGqRvNd7l6kG5	77SW9BnxLY8rJ0RciFqkHh
7aXuop4Qambx5Oi3ynsKQr	23zg3TcAtWQy7J6upgbUnj
19cL3SOKpwnwoKkII7U3Wh	6VxCmtR7S3yz4vnzsJqhSV
5s7xgzXtmY4gMjeSlgisjy	1IueXOQyABrMOprrzwQJWN
1JDIArrcepzWDTAWXdGYmP	2qxJFvFYMEDqd7ui6kSAcq
2S5LNtRVRPbXk01yRQ14sZ	0jnsk9HBra6NMjO2oANoPY
1WoOzgvz6CgH4pX6a1RKGp	6PXS4YHDkKvl1wkIl4V8DL
7MXVkk9YMctZqd1Srtv4MB	1Xyo4u8uXC1ZmMpatF05PJ
1zi7xx7UVEFkmKfv06H8x0	3TVXtAsR1Inumwj472S9r4
50kpGaPAhYJ3sGmk6vplg0	1uNFoZAHBGtllmzznpCI3s
7BKLCZ1jbUBVqRi2FVlTVw	69GGBxA162lTqCwzJG5jLp
62PaSfnXSMyLshYJrlTuL3	4dpARuHxo51G3z768sgnrY
3xKsf9qdS1CyvXSMEid6g8	2h93pZq0e7k5yf4dywlkpM
3QGsuHI8jO1Rx4JWLUh9jd	7n2wHs1TKAczGzO7Dd2rGr
6b3b7lILUJqXcp6w9wNQSm	5WUlDfRSoLAfcVSX1WnrxN
0lYBSQXN6rCTvUZvg9S0lU	540vIaP2JwjQb9dm3aArA4
72TFWvU3wUYdUuxejTTIzt	5pKCCKE2ajJHZ9KAiaK11H
2Z8WuEywRWYTKe1NybPQEW	3YQKmKGau1PzlVlkL1iodx
09CtPGIpYB4BrO8qb1RGsF	1uNFoZAHBGtllmzznpCI3s
5kqIPrATaCc2LqxVWzQGbk	25u4wHJWxCA9vO0CzxAbK7
3RiPr603aXAoi4GHyXx0uy	4gzpq5DPGxSnKTe4SA8HAU
0azC730Exh71aQlOt9Zj3y	7CajNmpbOovFoOoasH2HaY
3pXF1nA74528Edde4of9CC	2EMAnMvWE2eb56ToJVfCWs
76hfruVvmfQbw0eYn1nmeC	6T5tfhQCknKG4UnH90qGnz
4pAl7FkDMNBsjykPXo91B3	5pKCCKE2ajJHZ9KAiaK11H
1i1fxkWeaMmKEB4T7zqbzK	69GGBxA162lTqCwzJG5jLp
6i0V12jOa3mr6uu4WYhUBr	3YQKmKGau1PzlVlkL1iodx
23L5CiUhw2jV1OIMwthR3S	60d24wfXkVzDSfLS6hyCjZ
2BOqDYLOJBiMOXShCV1neZ	6ydoSd3N2mwgwBHtF6K7eX
698ItKASDavgwZ3WjaWjtz	7vk5e3vY1uw9plTHJAMwjN
0vbtURX4qv1l7besfwmnD8	2KsP6tYLJlTBvSUxnwlVWa
0y60itmpH0aPKsFiGxmtnh	3rWZHrfrsPBxVy692yAIxF
0VhgEqMTNZwYL1ARDLLNCX	4IWBUUAFIplrNtaOHcJPRM
1A8j067qyiNwQnZT0bzUpZ	7keGfmQR4X5w0two1xKZ7d
3O8NlPh2LByMU9lSRSHedm	3TVXtAsR1Inumwj472S9r4
0t7fVeEJxO2Xi4H2K5Svc9	4dpARuHxo51G3z768sgnrY
7lGKEWMXVWWTt3X71Bv44I	3NPpFNZtSTHheNBaWC82rB
2GyA33q5rti5IxkMQemRDH	7n2wHs1TKAczGzO7Dd2rGr
0TXNKTzawI6VgLoA9UauRp	0B3N0ZINFWvizfa8bKiz4v
5n0CTysih20NYdT2S0Wpe8	26T3LtbuGT1Fu9m0eRq5X3
7EVk9tRb6beJLTHrg6AkY9	4ON1ruy5ijE7ZPQthbrkgI
27GmP9AWRs744SzKcpJsTZ	3TVXtAsR1Inumwj472S9r4
5hc71nKsUgtwQ3z52KEKQk	3mIj9lX2MWuHmhNCA7LSCW
7qiZfU4dY1lWllzX7mPBI3	6eUKZXaKkcviH0Ku9w2n3V
0pqnGHJpmpxLKifKRmU6WP	53XhwfbYqKCa1cC15pYq2q
6habFhsOp2NvshLv26DqMb	4V8Sr092TqfHkfAA5fXXqG
1PSBzsahR2AKwLJgx8ehBj	6TIYQ3jFPwQSRmorSezPxX
5knuzwU65gJK7IF5yJsuaW	6MDME20pz9RveH9rEXvrOM
1rfofaqEpACxVEHIZBJe6W	4nDoRrQiYLoBzwC5BhVJzF
1zB4vmk8tFRmM9UULNzbLB	53XhwfbYqKCa1cC15pYq2q
1nueTG77MzNkJTKQ0ZdGzT	04gDigrS5kc9YWfZHwBETP
0KKkJNfGyhkQ5aFogxQAPU	0du5cEVh5yTK9QJze8zA0C
0tgVpDi06FyKpA1z0VMD4v	6eUKZXaKkcviH0Ku9w2n3V
7JJmb5XwzOO8jgpou264Ml	7n2wHs1TKAczGzO7Dd2rGr
5uCax9HTNlzGybIStD3vDh	4IWBUUAFIplrNtaOHcJPRM
5mCPDVBb16L4XQwDdbRUpz	3TVXtAsR1Inumwj472S9r4
6gBFPUFcJLzWGx4lenP6h2	0Y5tJX1MQlPlqiwlOH1tJY
1mXVgsBdtIVeCLJnSnmtdV	2wY79sveU1sp5g7SokKOiI
1P17dC1amhFzptugyAO7Il	06HL4z0CvFAxyc27GXpf02
7KXjTSCq5nL1LoYtL7XAwS	2YZyLoL8N0Wb9xBt1NhZWg
3B54sVLJ402zGa6Xm4YGNe	6vXTefBL93Dj5IqAWq6OTv
5oO3drDxtziYU2H1X23ZIp	5pKCCKE2ajJHZ9KAiaK11H
0jdny0dhgjUwoIp5GkqEaA	6LqNN22kT3074XbTVUrhzX
0zbzrhfVS9S2TszW3wLQZ7	4kYGAK2zu9EAomwj3hXkXy
0SGkqnVQo9KPytSri1H6cF	0c173mlxpT3dSFRgMO8XPh
29JrmE89KgRyCxBIzq2Ocw	5pUo3fmmHT8bhCyHE52hA6
45XhKYRRkyeqoW3teSOkCM	0QHgL1lAIqAw0HtD7YldmP
2qT1uLXPVPzGgFOx4jtEuo	66CXWjxzNUsdJxJ2JdwvnR
7ef4DlsgrMEH11cDZd32M6	7CajNmpbOovFoOoasH2HaY
6NFyWDv5CjfwuzoCkw47Xf	06HL4z0CvFAxyc27GXpf02
5OCJzvD7sykQEKHH7qAC3C	66CXWjxzNUsdJxJ2JdwvnR
6DCZcSspjsKoFjzjrWoCdn	3TVXtAsR1Inumwj472S9r4
0e7ipj03S05BNilyu5bRzt	246dkjvS1zLTtiykXe5h60
6IPwKM3fUUzlElbvKw2sKl	3uwAm6vQy7kWPS2bciKWx9
3GCdLUSnKSMJhs4Tj6CV3s	2YZyLoL8N0Wb9xBt1NhZWg
58kZ9spgxmlEznXGu6FPdQ	69GGBxA162lTqCwzJG5jLp
4EAV2cKiqKP5UPZmY6dejk	4xRYI6VqpkE3UwrDrAZL8L
6V1bu6o1Yo5ZXnsCJU8Ovk	04gDigrS5kc9YWfZHwBETP
2xGjteMU3E1tkEPVFBO08U	7HV2RI2qNug4EcQqLbCAKS
5WvAo7DNuPRmk4APhdPzi8	0QHgL1lAIqAw0HtD7YldmP
1BuZAIO8WZpavWVbbq3Lci	7iZtZyCzp3LItcw1wtPI3D
0ZNrc4kNeQYD9koZ3KvCsy	0A0FS04o6zMoto8OKPsDwY
5gW5dSy3vXJxgzma4rQuzH	6ueGR6SWhUJfvEhqkvMsVs
083Qf6hn6sFL6xiOHlZUyn	4ScCswdRlyA23odg9thgIO
2YpeDb67231RjR0MgVLzsG	7jVv8c5Fj3E9VhNjxT4snq
2Fxmhks0bxGSBdJ92vM42m	6qqNVTkY8uBg9cP3Jd7DAH
6v3KW9xbzN5yKLt9YKDYA2	7n2wHs1TKAczGzO7Dd2rGr
1BxfuPKGuaTgP7aM0Bbdwr	06HL4z0CvFAxyc27GXpf02
21jGcNKet2qwijlDFuPiPb	246dkjvS1zLTtiykXe5h60
2qxmye6gAegTMjLKEBoR3d	5IH6FPUwQTxPSXurCrcIov
5p7ujcrUXASCNwRaWNHR1C	26VFTg2z8YR0cCuwLzESi2
2vXKRlJBXyOcvZYTdNeckS	3hteYQFiMFbJY7wS0xDymP
7qEHsqek33rTcFNT9PFqLf	4GNC7GD6oZMSxPGyXy4MNB
0Oqc0kKFsQ6MhFOLBNZIGX	00FQb4jTyendYWaN8pK0wa
2JvzF1RMd7lE3KmFlsyZD8	6l3HvQ5sa6mXTsMTB19rO5
1dGr1c8CrMLDpV6mPbImSI	06HL4z0CvFAxyc27GXpf02
43zdsphuZLzwA9k4DJhU0I	6qqNVTkY8uBg9cP3Jd7DAH
7xQAfvXzm3AkraOtGPWIZg	246dkjvS1zLTtiykXe5h60
22vgEDb5hykfaTwLuskFGD	7gOdHgIoIKoe4i9Tta6qdD
4l0Mvzj72xxOpRrp6h8nHi	0C8ZW7ezQVs4URX5aX7Kqx
3e9HZxeyfWwjeyPAMmWSSQ	66CXWjxzNUsdJxJ2JdwvnR
1rqqCSm0Qe4I9rUvWncaom	20JZFwl6HVl6yg8a4H3ZqK
6RRNNciQGZEXnqk8SQ9yv5	06HL4z0CvFAxyc27GXpf02
7dt6x5M1jzdTEt8oCbisTK	246dkjvS1zLTtiykXe5h60
2t8yVaLvJ0RenpXUIAC52d	1URnnhqYAYcrqrcwql10ft
1lOe9qE0vR9zwWQAOk6CoO	4Ga1P7PMIsmqEZqhYZQgDo
7DnAm9FOTWE3cUvso43HhI	4npEfmQ6YuiwW1GpUmaq3F
1wJRveJZLSb1rjhnUHQiv6	31W5EY0aAly4Qieq6OFu6I
7tFiyTwD0nx5a1eklYtX2J	1dfeR4HaWDbWqFHLkxsg1d
132ALUzVLmqYB4UsBj5qD6	3vQ0GE3mI0dAaxIMYe5g7z
0DiDStADDVh3SvAsoJAFMk	7gOdHgIoIKoe4i9Tta6qdD
5itOtNx0WxtJmi1TQ3RuRd	7CajNmpbOovFoOoasH2HaY
2Xnv3GntqbBH1juvUYSpHG	4npEfmQ6YuiwW1GpUmaq3F
0pEkK8MqbmGSX7fT8WLMbR	4GNC7GD6oZMSxPGyXy4MNB
6TqXcAFInzjp0bODyvrWEq	6LuN9FCkKOj5PcnpouEgny
1000nHvUdawXuUHgBod4Wv	7jVv8c5Fj3E9VhNjxT4snq
5ls62WNKHUUrdF3r1cv83T	6ASri4ePR7RlsvIQgWPJpS
19kUPdKTp85q9RZNwaXM15	3oSJ7TBVCWMDMiYjXNiCKE
5N1o6d8zGcSZSeMFkOUQOk	181bsRPaVXVlUKXrxwZfHK
3iH29NcCxYgI5shlkZrUoB	6ASri4ePR7RlsvIQgWPJpS
6ImEBuxsbuTowuHmg3Z2FO	1MIVXf74SZHmTIp4V4paH4
1AI7UPw3fgwAFkvAlZWhE0	6eUKZXaKkcviH0Ku9w2n3V
5GBuCHuPKx6UC7VsSPK0t3	3Fl1V19tmjt57oBdxXKAjJ
0sf12qNH5qcw8qpgymFOqD	1Xyo4u8uXC1ZmMpatF05PJ
4LEK9rD7TWIG4FCL1s27XC	06HL4z0CvFAxyc27GXpf02
7igeByaBM0MgGsgXtNxDJ7	66CXWjxzNUsdJxJ2JdwvnR
6UelLqGlWMcVH1E5c4H7lY	6KImCVD70vtIoJWnq6nGn3
22LAwLoDA5b4AaGSkg6bKW	5zctI4wO9XSKS8XwcnqEHk
0nbXyq5TXYPCO7pr3N8S4I	757aE44tKEUQEqRuT6GnEB
127QTOFJsJQp5LbJbu3A1y	3TVXtAsR1Inumwj472S9r4
5RqR4ZCCKJDcBLIn4sih9l	1XLWox9w1Yvbodui0SRhUQ
7eJMfftS33KTjuF7lTsMCx	6bmlMHgSheBauioMgKv2tn
4xqrdfXkTW4T0RauPLv3WA	4Uc8Dsxct0oMqx0P6i60ea
3ZCTVFBt2Brf31RLEnCkWJ	6qqNVTkY8uBg9cP3Jd7DAH
3Dv1eDb0MEgF93GpLXlucZ	5cj0lLjcoR7YOSnhnX0Po5
0v1x6rN6JHRapa03JElljE	3Nrfpe0tUJi4K4DXYWgMUX
3tjFYV6RSFtuktYl3ZtYcq	6fWVd57NKTalqvmjRd2t8Z
0PvFJmanyNQMseIFrU708S	0eDvMgVFoNV3TpwtrVCoTj
2Wo6QQD1KMDWeFkkjLqwx5	0H39MdGGX6dbnnQPt6NQkZ
1Cv1YLb4q0RzL6pybtaMLo	4ETSs924pXMzjIeD6E9b4u
3jjujdWJ72nww5eGnfs2E7	6KImCVD70vtIoJWnq6nGn3
2SAqBLGA283SUiwJ3xOUVI	3TVXtAsR1Inumwj472S9r4
2Z8yfpFX0ZMavHkcIeHiO1	7n2wHs1TKAczGzO7Dd2rGr
1DWZUa5Mzf2BwzpHtgbHPY	4LLpKhyESsyAXpc4laK94U
2ygvZOXrIeVL4xZmAWJT2C	6qqNVTkY8uBg9cP3Jd7DAH
7lPN2DXiMsVn7XUKtOW1CS	1McMsnEElThX1knmY4oliG
67BtfxlNbhBmCDR2L2l8qd	7jVv8c5Fj3E9VhNjxT4snq
3Wrjm47oTz2sjIgck11l5e	0lAWpj5szCSwM4rUMHYmrr
37BZB0z9T8Xu7U3e65qxFy	1Xyo4u8uXC1ZmMpatF05PJ
4iJyoBOLtHqaGxP12qzhQI	1uNFoZAHBGtllmzznpCI3s
7MAibcTli4IisCtbHKrGMh	0du5cEVh5yTK9QJze8zA0C
61KpQadow081I2AsbeLcsb	1McMsnEElThX1knmY4oliG
3YJJjQPAbDT7mGpX3WtQ9A	7tYKF4w9nC0nq9CsPZTHyP
6PQ88X9TkUIAUIZJHW2upE	6eUKZXaKkcviH0Ku9w2n3V
5HCyWlXZPP0y6Gqq8TgA20	2tIP7SsRs7vjIcLrU85W8J
5Z9KJZvQzH6PFmb8SNkxuk	7jVv8c5Fj3E9VhNjxT4snq
748mdHapucXQri7IAO8yFK	5cj0lLjcoR7YOSnhnX0Po5
6PERP62TejQjgHu81OHxgM	1McMsnEElThX1knmY4oliG
3FAJ6O0NOHQV8Mc5Ri6ENp	4fxd5Ee7UefO4CUXgwJ7IP
0gplL1WMoJ6iYaPgMCL0gX	4dpARuHxo51G3z768sgnrY
5enxwA8aAbwZbf5qCHORXi	06HL4z0CvFAxyc27GXpf02
4RVwu0g32PAqgUiJoXsdF8	6qqNVTkY8uBg9cP3Jd7DAH
40iJIUlhi6renaREYGeIDS	3TVXtAsR1Inumwj472S9r4
3Ofmpyhv5UAQ70mENzB277	1uU7g3DNSbsu0QjSEqZtEd
7hU3IHwjX150XLoTVmjD0q	5L1lO4eRHmJ7a0Q6csE5cT
3VqeTFIvhxu3DIe4eZVzGq	3Nrfpe0tUJi4K4DXYWgMUX
463CkQjx2Zk1yXoBuierM9	6M2wZ9GZgrQXHCFfjv46we
4fSIb4hdOQ151TILNsSEaF	1mcTU81TzQhprhouKaTkpq
6Im9k8u9iIzKMrmV7BWtlF	66CXWjxzNUsdJxJ2JdwvnR
10hcDov7xmcRviA8jLwEaI	5cj0lLjcoR7YOSnhnX0Po5
4pt5fDVTg5GhEvEtlz9dKk	0lAWpj5szCSwM4rUMHYmrr
0z8hI3OPS8ADPWtoCjjLl6	7n2wHs1TKAczGzO7Dd2rGr
07MDkzWARZaLEdKxo6yArG	64H8UqGLbJFHwKtGxiV8OP
0eu4C55hL6x29mmeAjytzC	6TLwD7HPWuiOzvXEa3oCNe
3nY8AqaMNNHHLYV4380ol0	2WgfkM8S11vg4kxLgDY3F5
0WSEq9Ko4kFPt8yo3ICd6T	5K4W6rqBFWDnAN6FQUkS6x
4LRPiXqCikLlN15c3yImP7	6KImCVD70vtIoJWnq6nGn3
1IHWl5LamUGEuP4ozKQSXZ	4q3ewBCX7sLwd24euuV69X
0V3wPSX9ygBnCm8psDIegu	06HL4z0CvFAxyc27GXpf02
3nqQXoyQOWXiESFLlDF1hG	2wY79sveU1sp5g7SokKOiI
29d0nY7TzCoi22XBqDQkiP	1aSxMhuvixZ8h9dK9jIDwL
6xGruZOHLs39ZbVccQTuPZ	3MZsBdqDrRTJihTHQrO6Dq
1xzi1Jcr7mEi9K2RfzLOqS	6vWDO969PvNqNYHIOW5v0m
1rDQ4oMwGJI7B4tovsBOxc	2LIk90788K0zvyj2JJVwkJ
02MWAaffLxlfxAUY7c5dvx	4yvcSjfu4PC0CYQyLy4wSq
4k6Uh1HXdhtusDW5y8Gbvy	57vWImR43h4CaDao012Ofp
6I3mqTwhRpn34SLVafSH7G	1uNFoZAHBGtllmzznpCI3s
4fouWK6XVHhzl78KzQ1UjL	2VSHKHBTiXWplO8lxcnUC9
1qEmFfgcLObUfQm0j1W2CK	6KImCVD70vtIoJWnq6nGn3
5CZ40GBx1sQ9agT82CLQCT	1McMsnEElThX1knmY4oliG
6Sq7ltF9Qa7SNFBsV5Cogx	4q3ewBCX7sLwd24euuV69X
4C6Uex2ILwJi9sZXRdmqXp	0hCNtLu0JehylgoiP8L4Gh
1PckUlxKqWQs3RlWXVBLw3	56oDRnqbIiwx4mymNEv7dS
27NovPIUIRrOZoCHxABJwK	7jVv8c5Fj3E9VhNjxT4snq
2tTmW7RDtMQtBk7m2rYeSw	716NhGYqD1jl2wI1Qkgq36
5ildQOEKmJuWGl2vRkFdYc	7ltDVBr6mKbRvohxheJ9h1
7rglLriMNBPAyuJOMGwi39	3PhoLpVuITZKcymswpck5b
5IgjP7X4th6nMNDh4akUHb	7bXgB6jMjp9ATFy66eO08Z
59CfNbkERJ3NoTXDvoURjj	2W8yFh0Ga6Yf3jiayVxwkE
5jQI2r1RdgtuT8S3iG8zFC	06HL4z0CvFAxyc27GXpf02
3IAfUEeaXRX9s9UdKOJrFI	7FNnA9vBm6EKceENgCGRMb
0skYUMpS0AcbpjcGsAbRGj	41MozSoPIsD1dJM0CLPjZF
0e8nrvls4Qqv5Rfa2UhqmO	7jVv8c5Fj3E9VhNjxT4snq
4h9wh7iOZ0GGn8QVp4RAOB	5Pwc4xIPtQLFEnJriah9YJ
0mBP9X2gPCuapvpZ7TGDk3	6VuMaDnrHyPL1p4EHjYLi7
35ovElsgyAtQwYPYnZJECg	5pKCCKE2ajJHZ9KAiaK11H
52xJxFP6TqMuO4Yt0eOkMz	29PgYEggDV3cDP9QYTogwv
2KukL7UlQ8TdvpaA7bY3ZJ	6vWDO969PvNqNYHIOW5v0m
7dSZ6zGTQx66c2GF91xCrb	790FomKkXshlbRYZFtlgla
2rurDawMfoKP4uHyb2kJBt	0EmeFodog0BfCgMzAIvKQp
6Xom58OOXk2SoU711L2IXO	4q3ewBCX7sLwd24euuV69X
0ARKW62l9uWIDYMZTUmJHF	41MozSoPIsD1dJM0CLPjZF
1ri9ZUkBJVFUdgwzCnfcYs	4obzFoKoKRHIphyHzJ35G3
7mFj0LlWtEJaEigguaWqYh	181bsRPaVXVlUKXrxwZfHK
1oFAF1hdPOickyHgbuRjyX	1Xyo4u8uXC1ZmMpatF05PJ
34ZAzO78a5DAVNrYIGWcPm	7tYKF4w9nC0nq9CsPZTHyP
3F5CgOj3wFlRv51JsHbxhe	3TVXtAsR1Inumwj472S9r4
3rWDp9tBPQR9z6U5YyRSK4	06HL4z0CvFAxyc27GXpf02
2g6tReTlM2Akp41g0HaeXN	2YZyLoL8N0Wb9xBt1NhZWg
4pi1G1x8tl9VfdD9bL3maT	3MdXrJWsbVzdn6fe5JYkSQ
3LtpKP5abr2qqjunvjlX5i	5H4yInM5zmHqpKIoMNAx4r
3XOalgusokruzA5ZBA2Qcb	2hlmm7s2ICUX0LVIhVFlZQ
1r8ZCjfrQxoy2wVaBUbpwg	2tIP7SsRs7vjIcLrU85W8J
\.


--
-- TOC entry 4876 (class 0 OID 75880)
-- Dependencies: 218
-- Data for Name: tracks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracks (track_id, track_name, track_popularity, key_, duration_ms, time_signature, danceability, energy, loudness, mode_, speechiness, liveness, valence, tempo, instrumentalness, acousticness) FROM stdin;
7ef4DlsgrMEH11cDZd32M6	One Kiss (with Dua Lipa)	87	9	214847	4	0.791	0.862	-3.24	0	0.11	0.0814	0.592	123.994	2.19e-05	0.037
5E30LdtzQTGqRvNd7l6kG5	Daddy Issues	86	10	260173	4	0.588	0.521	-9.461	1	0.0329	0.123	0.337	85.012	0.149	0.0678
2OXidlnDThZR3zf36k6DVL	Just A Kiss	65	1	218840	4	0.593	0.639	-5.826	1	0.0307	0.0998	0.332	142.881	0	0.446
1zi7xx7UVEFkmKfv06H8x0	One Dance	89	1	173987	4	0.792	0.625	-5.609	1	0.0536	0.329	0.37	103.967	0.0018	0.00776
3n69hLUdIsSa1WlRmjMZlW	Breezeblocks	74	5	227080	4	0.615	0.658	-7.299	1	0.0343	0.205	0.293	150.093	0.000911	0.096
0mBP9X2gPCuapvpZ7TGDk3	Left and Right (Feat. Jung Kook of BTS)	81	2	154487	4	0.881	0.592	-4.898	1	0.0324	0.0901	0.719	101.058	1.32e-05	0.619
5lF0pHbsJ0QqyIrLweHJPW	Burn	75	1	231213	4	0.555	0.772	-5.007	1	0.0523	0.105	0.346	86.921	0	0.315
0nbXyq5TXYPCO7pr3N8S4I	The Box	83	10	196653	4	0.896	0.586	-6.687	0	0.0559	0.79	0.642	116.971	0	0.104
2SAqBLGA283SUiwJ3xOUVI	Laugh Now Cry Later (feat. Lil Durk)	80	0	261493	4	0.761	0.518	-8.871	1	0.134	0.107	0.522	133.976	3.47e-05	0.244
1r8ZCjfrQxoy2wVaBUbpwg	Thousand Miles	77	7	164782	4	0.376	0.657	-4.658	1	0.0768	0.0884	0.203	80.565	0	0.0858
6Vh03bkEfXqekWp7Y1UBRb	Live While We're Young	76	2	200213	4	0.663	0.857	-2.16	1	0.0544	0.144	0.931	126.039	0	0.0542
2Foc5Q5nqNiosCNqttzHof	Get Lucky (Radio Edit) [feat. Pharrell Williams and Nile Rodgers]	83	6	248413	4	0.794	0.811	-8.966	0	0.038	0.101	0.862	116.047	1.07e-06	0.0426
4wCmqSrbyCgxEXROQE6vtV	Somebody That I Used To Know	77	0	244973	4	0.864	0.495	-7.036	1	0.037	0.0992	0.72	129.062	0.000133	0.591
608a1wIsSd5KzMEqm1O7w3	I'm On One	72	11	296147	4	0.413	0.807	-3.499	0	0.318	0.631	0.438	149.33	0	0.0536
7oVEtyuv9NBmnytsCIsY5I	BURN IT DOWN	77	9	230253	4	0.585	0.972	-4.45	0	0.0534	0.0707	0.585	110.006	0	0.0143
5OCJzvD7sykQEKHH7qAC3C	God is a woman	79	1	197547	4	0.602	0.658	-5.934	1	0.0558	0.237	0.268	145.031	6e-05	0.0233
15JINEqzVMv3SvJTAXAKED	Love The Way You Lie	85	10	263373	4	0.749	0.925	-5.034	1	0.227	0.52	0.641	86.989	0	0.241
78JKJfKsqgeBDBF58gv1SF	Hands on the Wheel (feat. Asap Rocky)	66	1	197132	4	0.646	0.784	-7.471	0	0.108	0.0721	0.179	127.839	0	0.0166
14OxJlLdcHNpgsm4DRwDOB	Habits (Stay High)	75	5	209160	4	0.729	0.65	-3.539	1	0.0313	0.0829	0.347	110.02	6.69e-05	0.0702
2V65y3PX4DkRhy1djlxd9p	Don't You Worry Child - Radio Edit	84	11	212862	4	0.612	0.84	-3.145	0	0.0509	0.116	0.438	129.042	0	0.112
0pqnGHJpmpxLKifKRmU6WP	Believer	90	10	204347	4	0.776	0.78	-4.374	0	0.128	0.081	0.666	124.949	0	0.0622
07WEDHF2YwVgYuBugi2ECO	Kickstarts	65	5	181827	4	0.61	0.836	-4.455	1	0.0573	0.358	0.657	126.056	0	0.00374
1ri9ZUkBJVFUdgwzCnfcYs	MAMIII	78	4	226088	4	0.843	0.7	-3.563	0	0.0803	0.14	0.899	93.991	0	0.0934
7ElF5zxOwYP4qVSWVvse3W	Break Your Heart	73	3	201547	4	0.607	0.934	-4.217	1	0.0314	0.0909	0.568	122.01	0	0.0327
0HPD5WQqrq7wPWR7P7Dw1i	TiK ToK	84	2	199693	4	0.755	0.837	-2.718	0	0.142	0.289	0.714	120.028	0	0.0991
3VA8T3rNy5V24AXxNK5u9E	King of Anything	63	1	207493	4	0.676	0.762	-4.172	1	0.0351	0.0574	0.81	119.003	0	0.461
2tTmW7RDtMQtBk7m2rYeSw	Quevedo: Bzrp Music Sessions, Vol. 52	91	2	198938	4	0.621	0.782	-5.548	1	0.044	0.23	0.55	128.033	0.033	0.0125
1nZzRJbFvCEct3uzu04ZoL	Part Of Me	76	5	216160	4	0.678	0.918	-4.63	1	0.0355	0.0744	0.769	130.028	0	0.000417
2S5LNtRVRPbXk01yRQ14sZ	I Don't Like It, I Love It (feat. Robin Thicke & Verdine White)	68	9	224258	4	0.854	0.766	-4.697	0	0.141	0.0793	0.784	118.004	0	0.0242
5jE48hhRu8E6zBDPRSkEq7	All About That Bass	75	9	187920	4	0.807	0.887	-3.726	1	0.0503	0.124	0.961	134.052	2.87e-06	0.0573
3w3y8KPTfNeOKPiqUTakBh	Locked out of Heaven	90	5	233478	4	0.726	0.698	-4.165	1	0.0431	0.309	0.867	143.994	0	0.049
7qEHsqek33rTcFNT9PFqLf	Someone You Loved	90	1	182161	4	0.501	0.405	-5.679	1	0.0319	0.105	0.446	109.891	0	0.751
3FrX3mx8qq7SZX2NYbzDoj	Who's That Chick? (feat. Rihanna)	59	11	201040	4	0.675	0.601	-4.733	0	0.116	0.0458	0.931	127.938	0	0.00372
6VObnIkLVruX4UVyxWhlqm	Skyfall	83	0	286480	4	0.346	0.552	-6.864	0	0.0282	0.114	0.0789	75.881	0	0.417
3pXF1nA74528Edde4of9CC	Don't	85	11	198293	4	0.765	0.356	-5.556	0	0.195	0.0963	0.189	96.991	0	0.223
45O0tUN9Bh6LH4eNxQ07AT	Eenie Meenie	67	1	201653	4	0.734	0.639	-3.241	1	0.0316	0.102	0.836	121.212	0	0.0348
5itOtNx0WxtJmi1TQ3RuRd	Giant (with Rag'n'Bone Man)	74	1	229184	4	0.807	0.887	-4.311	0	0.0361	0.0811	0.606	122.015	0.000503	0.016
3oL3XRtkP1WVbMxf7dtTdu	The One That Got Away	73	1	227333	4	0.687	0.792	-4.023	0	0.0353	0.2	0.864	133.962	0	0.000802
1AI7UPw3fgwAFkvAlZWhE0	Take Me Back to London (feat. Stormzy)	66	8	189733	4	0.885	0.762	-5.513	0	0.216	0.162	0.605	138.058	0	0.219
1dGr1c8CrMLDpV6mPbImSI	Lover	91	7	221307	4	0.359	0.543	-7.582	1	0.0919	0.118	0.453	68.534	1.58e-05	0.492
0sf12qNH5qcw8qpgymFOqD	Blinding Lights	19	1	201573	4	0.513	0.796	-4.075	1	0.0629	0.0938	0.345	171.017	0.000209	0.00147
1WoOzgvz6CgH4pX6a1RKGp	My Way (feat. Monty)	68	6	213053	4	0.748	0.741	-3.103	1	0.0531	0.147	0.537	128.077	0	0.00419
7m3povhdMDLZwuEKak0l0n	Wasted	64	2	190014	4	0.638	0.816	-5.503	1	0.0308	0.195	0.386	112.014	0.00115	0.00149
6j7hih15xG2cdYwIJnQXsq	Not Over You	67	10	218520	4	0.63	0.894	-4.592	1	0.0544	0.181	0.364	142.051	0	0.255
17tDv8WA8IhqE8qzuQn707	My First Kiss (feat. Ke$ha)	64	0	192440	4	0.682	0.889	-4.166	1	0.0804	0.36	0.827	138.021	0	0.00564
2PIvq1pGrUjY007X5y1UpM	Earned It (Fifty Shades Of Grey) - From The "Fifty Shades Of Grey" Soundtrack	77	2	252227	3	0.659	0.381	-5.922	0	0.0304	0.0972	0.426	119.844	0	0.385
1IHWl5LamUGEuP4ozKQSXZ	TitÃ­ Me PreguntÃ³	88	5	243717	4	0.65	0.715	-5.198	0	0.253	0.126	0.187	106.672	0.000291	0.0993
2JzZzZUQj3Qff7wapcbKjc	See You Again (feat. Charlie Puth)	85	10	229526	4	0.689	0.481	-7.503	1	0.0815	0.0649	0.283	80.025	1.03e-06	0.369
6TqXcAFInzjp0bODyvrWEq	Talk (feat. Disclosure)	73	0	197573	4	0.9	0.4	-8.575	1	0.127	0.0599	0.346	135.984	0	0.0516
6KkyuDhrEhR5nJVKtv9mCf	High Hopes	68	4	230267	4	0.488	0.487	-6.371	1	0.0305	0.193	0.219	77.278	0	0.577
6GgPsuz0HEO0nrO2T0QhDv	No Hands (feat. Roscoe Dash & Wale)	61	1	263773	4	0.76	0.595	-6.366	1	0.0391	0.241	0.361	131.497	0	0.00544
1KtD0xaLAikgIt5tPbteZQ	Thinking About You (feat. Ayah Marar)	69	0	247933	4	0.725	0.874	-3.715	0	0.0396	0.0958	0.748	127.985	0.000412	0.00262
5BJSZocnCeSNeYMj3iVqM7	Love Runs Out	64	7	224227	4	0.719	0.935	-3.752	1	0.0589	0.0973	0.738	120.022	0	0.167
06h3McKzmxS8Bx58USHiMq	Silhouettes - Original Radio Edit	67	5	211880	4	0.605	0.8	-6.235	0	0.0545	0.121	0.836	128.074	0.0562	0.155
1yjY7rpaAQvKwpdUliHx0d	Still into You	83	5	216013	4	0.602	0.923	-3.763	1	0.044	0.0561	0.765	136.01	0	0.0098
0t7fVeEJxO2Xi4H2K5Svc9	Send My Love (To Your New Lover)	76	6	223079	4	0.688	0.533	-8.363	0	0.0865	0.172	0.567	164.069	3.48e-06	0.0355
5zdkUzguZYAfBH9fnWn3Zl	Need U (100%) (feat. A*M*E) - Radio Edit	61	0	174122	4	0.67	0.848	-5.103	0	0.0538	0.385	0.457	124.031	0.00168	0.00172
09CtPGIpYB4BrO8qb1RGsF	Sorry	83	0	200787	4	0.654	0.76	-3.669	0	0.045	0.299	0.41	99.945	0	0.0797
6b3b7lILUJqXcp6w9wNQSm	Cheap Thrills (feat. Sean Paul)	69	6	224813	4	0.592	0.8	-4.931	0	0.215	0.0775	0.728	89.972	2.01e-06	0.0561
0aBKFfdyOD1Ttvgv0cfjjJ	More - RedOne Jimmy Joker Remix	72	7	219987	4	0.551	0.893	-2.628	1	0.0543	0.348	0.794	125.083	0	0.00166
39lS97papXAI72StGRtZBo	Wrapped Up (feat. Travie McCoy)	63	1	185629	4	0.787	0.837	-5.419	1	0.0556	0.155	0.918	122.004	0	0.0926
5vlEg2fT4cFWAqU5QptIpQ	Replay	74	9	182307	4	0.706	0.751	-6.323	1	0.0708	0.168	0.195	91.031	0	0.173
6VRhkROS2SZHGlp0pxndbJ	Bangarang (feat. Sirah)	72	7	215253	4	0.716	0.972	-2.302	1	0.196	0.317	0.576	110.026	3.22e-05	0.0145
2dRvMEW4EwySxRUtEamSfG	The Heart Wants What It Wants	61	7	227360	4	0.616	0.789	-4.874	0	0.0377	0.142	0.621	83.066	0	0.053
5HCyWlXZPP0y6Gqq8TgA20	STAY (with Justin Bieber)	86	1	141806	4	0.591	0.764	-5.484	1	0.0483	0.103	0.478	169.928	0	0.0383
2U8g9wVcUu9wsg6i7sFSv8	Every Teardrop Is a Waterfall	73	9	240796	4	0.425	0.732	-6.883	1	0.0396	0.171	0.333	117.98	0.0103	0.00194
0puf9yIluy9W0vpMEUoAnN	Bang Bang	81	0	199387	4	0.706	0.786	-3.417	0	0.091	0.38	0.751	150.028	0	0.26
1DunhgeZSEgWiIYbHqXl0c	Latch	73	1	255867	4	0.729	0.735	-5.455	1	0.0919	0.089	0.544	121.986	0.000193	0.0178
3Dv1eDb0MEgF93GpLXlucZ	Say So	80	11	237893	4	0.787	0.673	-4.583	0	0.159	0.0904	0.779	110.962	3.35e-06	0.264
5ls62WNKHUUrdF3r1cv83T	emotions	72	9	131213	4	0.63	0.63	-6.211	1	0.0395	0.142	0.163	80.512	0	0.0131
0KKkJNfGyhkQ5aFogxQAPU	That's What I Like	88	1	206693	4	0.853	0.56	-4.961	1	0.0406	0.0944	0.86	134.066	0	0.013
02MWAaffLxlfxAUY7c5dvx	Heat Waves	40	11	238805	4	0.761	0.525	-6.9	1	0.0944	0.0921	0.531	80.87	6.7e-06	0.44
0JXXNGljqupsJaZsgSbMZV	Sure Thing	89	11	195373	4	0.684	0.607	-8.127	0	0.1	0.191	0.498	81.001	0.000307	0.0267
0dBW6ZsW8skfvoRfgeerBF	Mine	66	7	230707	4	0.624	0.757	-2.94	1	0.0296	0.189	0.658	121.07	1.87e-06	0.00265
0S4RKPbRDA72tvKwVdXQqe	The Way	70	5	227027	4	0.645	0.878	-3.208	0	0.113	0.076	0.862	82.324	0	0.294
4AYX69oFP3UOS1CFmV9UfO	Bottoms Up (feat. Nicki Minaj)	74	1	242013	4	0.844	0.601	-5.283	1	0.157	0.385	0.331	73.989	0	0.0205
0KAiuUOrLTIkzkpfpn9jb9	Drive By	80	1	195973	4	0.765	0.837	-3.113	0	0.032	0.0801	0.721	122.028	1.06e-05	0.00107
7MAibcTli4IisCtbHKrGMh	Leave The Door Open	12	5	242096	4	0.586	0.616	-7.964	1	0.0324	0.0927	0.719	148.088	0	0.182
3Wrjm47oTz2sjIgck11l5e	Beggin'	85	11	211560	4	0.714	0.8	-4.808	0	0.0504	0.359	0.589	134.002	0	0.127
0vbtURX4qv1l7besfwmnD8	I Took A Pill In Ibiza - Seeb Remix	81	7	197933	4	0.664	0.714	-6.645	0	0.111	0.0843	0.71	101.969	8.42e-06	0.0353
2i0AUcEnsDm3dsqLrFWUCq	Tonight Tonight	73	4	200467	4	0.686	0.783	-4.977	1	0.119	0.163	0.814	99.978	0	0.0764
5Z9KJZvQzH6PFmb8SNkxuk	INDUSTRY BABY (feat. Jack Harlow)	79	10	212353	4	0.741	0.691	-7.395	0	0.0672	0.0476	0.892	150.087	0	0.0221
7lGKEWMXVWWTt3X71Bv44I	Unsteady	75	0	193547	4	0.389	0.665	-6.169	1	0.0644	0.116	0.199	117.055	0.000732	0.178
3IAfUEeaXRX9s9UdKOJrFI	Envolver	76	4	193806	4	0.812	0.736	-5.421	0	0.0833	0.0914	0.396	91.993	0.00254	0.152
3sP3c86WFjOzHHnbhhZcLA	Give Your Heart a Break	72	6	205347	4	0.651	0.695	-3.218	1	0.0487	0.144	0.569	123.008	0	0.23
0lYBSQXN6rCTvUZvg9S0lU	Let Me Love You	86	8	205947	4	0.649	0.716	-5.371	1	0.0349	0.135	0.163	99.988	2.63e-05	0.0863
3Ofmpyhv5UAQ70mENzB277	Astronaut In The Ocean	77	4	132780	4	0.778	0.695	-6.865	0	0.0913	0.15	0.472	149.996	0	0.175
1zVhMuH7agsRe6XkljIY4U	human	62	8	250707	4	0.439	0.489	-6.286	1	0.0368	0.114	0.253	143.808	0.000643	0.132
1Lim1Py7xBgbAkAys3AGAG	Lean On	77	7	176561	4	0.723	0.809	-3.081	0	0.0625	0.565	0.274	98.007	0.00123	0.00346
2EcsgXlxz99UMDSPg5T8RF	Beneath Your Beautiful (feat. Emeli SandÃ©)	70	2	271813	4	0.561	0.522	-5.857	1	0.0318	0.104	0.238	83.962	0	0.227
27GmP9AWRs744SzKcpJsTZ	Jumpman	73	1	205879	4	0.852	0.553	-7.286	1	0.187	0.332	0.656	142.079	0	0.0559
7rglLriMNBPAyuJOMGwi39	Cold Heart - PNAU Remix	72	1	202735	4	0.795	0.8	-6.32	1	0.0309	0.0915	0.934	116.032	7.25e-05	0.0354
7AqISujIaWcY3h5zrOqt5v	Forget You	66	0	222733	4	0.696	0.875	-3.682	1	0.0649	0.159	0.772	127.39	0	0.134
6CjtS2JZH9RkDz5UVInsa9	Thrift Shop (feat. Wanz)	81	6	235613	4	0.781	0.526	-6.986	0	0.293	0.0457	0.665	94.993	0	0.0633
190jyVPHYjAqEaOGmMzdyk	Beauty And A Beat	83	0	227987	4	0.602	0.843	-4.831	1	0.0593	0.0682	0.526	128.003	5.27e-05	0.000688
2NniAhAtkRACaMeYt48xlD	50 Ways to Say Goodbye	69	6	247947	4	0.591	0.935	-2.664	1	0.0478	0.142	0.736	140.043	0.000278	0.000284
6FSxwdN08PvzimGApFjRnY	When We Collide	44	2	226000	4	0.443	0.683	-5.521	1	0.0343	0.313	0.447	81.986	5.26e-06	0.0198
7BqBn9nzAq8spo5e7cZ0dJ	Just the Way You Are	86	5	220734	4	0.635	0.841	-5.379	1	0.0422	0.0622	0.424	109.021	0	0.0134
4pt5fDVTg5GhEvEtlz9dKk	I WANNA BE YOUR SLAVE	83	1	173347	4	0.75	0.608	-4.008	1	0.0387	0.178	0.958	132.507	0	0.00165
5gW5dSy3vXJxgzma4rQuzH	Make Me Feel	65	1	194230	4	0.859	0.413	-7.399	1	0.182	0.334	0.697	115.035	0	0.132
1HHeOs6zRdF8Ck58easiAY	Alejandro	74	11	274213	4	0.623	0.793	-6.63	0	0.0462	0.375	0.36	98.998	0.0015	0.000397
0lHAMNU8RGiIObScrsRgmP	Titanium (feat. Sia)	72	0	245040	4	0.604	0.788	-3.673	0	0.103	0.127	0.301	126.06	0.153	0.0678
16Of7eeW44kt0a1M0nitHM	You Make Me Feel... (feat. Sabi)	72	7	215693	4	0.668	0.857	-2.944	0	0.0535	0.0385	0.748	131.959	6.71e-06	0.0191
3nqQXoyQOWXiESFLlDF1hG	Unholy (feat. Kim Petras)	87	2	156943	4	0.714	0.472	-7.375	1	0.0864	0.266	0.238	131.121	4.51e-06	0.013
5FljCWR0cys07PQ9277GTz	The Other Side	61	9	226987	4	0.561	0.836	-3.939	1	0.1	0.136	0.517	127.923	0	0.0525
0NlGoUyOJSuSHmngoibVAs	All I Want	82	0	305747	3	0.188	0.411	-9.733	1	0.0484	0.0843	0.159	187.376	0.153	0.174
4fSIb4hdOQ151TILNsSEaF	Todo De Ti	79	3	199604	4	0.78	0.718	-3.605	0	0.0506	0.0932	0.342	127.949	0.000163	0.31
0XvjOhwCnXXFOSlBbV9jPN	Barbra Streisand - Radio Edit	46	1	196533	4	0.769	0.922	-1.966	1	0.108	0.233	0.506	127.965	0.197	0.000939
2GyA33q5rti5IxkMQemRDH	I Know What You Did Last Summer	74	9	223853	4	0.687	0.761	-4.582	0	0.0876	0.147	0.743	113.939	0	0.102
52gvlDnre9craz9dKGObp8	La La La	60	6	220779	4	0.754	0.677	-4.399	0	0.0316	0.111	0.254	124.988	0	0.112
1mKXFLRA179hdOWQBwUk9e	Just Give Me a Reason (feat. Nate Ruess)	84	2	242733	4	0.778	0.547	-7.273	1	0.0489	0.132	0.441	95.002	0.000302	0.346
3ZdJffjzJWFimSQyxgGIxN	Just A Dream	77	1	237800	4	0.531	0.752	-6.161	1	0.0305	0.12	0.103	89.917	0	0.0421
0U10zFw4GlBacOy9VDGfGL	We Found Love	82	1	215227	4	0.735	0.766	-4.485	1	0.0383	0.108	0.6	127.985	0.00138	0.025
6BdgtqiV3oXNqBikezwdvC	Over	73	7	233560	5	0.35	0.845	-5.614	1	0.2	0.123	0.45	99.643	0	0.0107
10hcDov7xmcRviA8jLwEaI	Need to Know	63	1	210560	4	0.664	0.609	-6.509	1	0.0707	0.0926	0.194	130.041	0	0.304
1oHNvJVbFkexQc0BpQp7Y4	Starships	77	11	210627	4	0.747	0.716	-2.457	0	0.075	0.251	0.751	125.008	0	0.135
2DHc2e5bBn4UzY0ENVFrUl	Carry Out (Featuring Justin Timberlake)	70	10	232467	5	0.531	0.574	-6.693	0	0.113	0.256	0.272	115.68	0.0308	0.114
132ALUzVLmqYB4UsBj5qD6	Adan y Eva	74	1	256972	4	0.767	0.709	-4.47	1	0.336	0.0745	0.72	171.993	0	0.323
2g6tReTlM2Akp41g0HaeXN	Die Hard	79	1	239027	4	0.775	0.736	-8.072	0	0.247	0.127	0.362	100.988	0.00116	0.319
6NFyWDv5CjfwuzoCkw47Xf	Delicate	87	9	232253	4	0.75	0.404	-10.178	0	0.0682	0.0911	0.0499	95.045	0.000357	0.216
0s0JMUkb2WCxIJsRB3G7Hd	Dear Darlin'	61	11	206373	4	0.512	0.828	-4.672	0	0.0454	0.119	0.34	124.021	8.73e-06	0.00627
76hfruVvmfQbw0eYn1nmeC	Cake By The Ocean	84	4	219147	4	0.774	0.753	-5.446	0	0.0517	0.0371	0.896	119.002	0	0.152
5ildQOEKmJuWGl2vRkFdYc	DESPECHÃ	82	7	157018	4	0.919	0.623	-6.521	1	0.0992	0.0609	0.775	130.037	1.63e-05	0.184
3pYDZTJM2tVBUhIRifWVzI	Blow	71	11	219973	4	0.753	0.729	-3.862	0	0.0392	0.073	0.812	120.013	5.66e-05	0.00334
5KONnBIQ9LqCxyeSPin26k	Trumpets	64	0	217419	4	0.635	0.691	-4.862	1	0.258	0.097	0.638	82.142	0	0.555
4fouWK6XVHhzl78KzQ1UjL	abcdefu	83	4	168602	4	0.695	0.54	-5.692	1	0.0493	0.367	0.415	121.932	0	0.299
0mvkwaZMP2gAy2ApQLtZRv	It's a Beautiful Day	69	1	199267	4	0.532	0.795	-3.979	1	0.0358	0.295	0.78	143.837	0	0.0559
4pAl7FkDMNBsjykPXo91B3	Needed Me	83	5	191600	4	0.671	0.314	-8.091	0	0.244	0.0825	0.296	110.898	0	0.11
1rqqCSm0Qe4I9rUvWncaom	High Hopes	82	5	190947	4	0.579	0.904	-2.729	1	0.0618	0.064	0.681	82.014	0	0.193
4b4c0oH7PtrPsI86drzgFs	Chasing The Sun	70	7	198800	4	0.637	0.732	-6.209	0	0.0965	0.498	0.68	128.108	0	0.244
4sOX1nhpKwFWPvoMMExi3q	Primadonna	74	4	221075	4	0.66	0.689	-2.671	0	0.0337	0.0922	0.427	127.98	0	0.0884
1oFAF1hdPOickyHgbuRjyX	Save Your Tears (Remix) (with Ariana Grande) - Bonus Track	82	0	191014	4	0.65	0.825	-4.645	1	0.0325	0.0936	0.593	118.091	2.44e-05	0.0215
7lPN2DXiMsVn7XUKtOW1CS	drivers license	28	10	242014	4	0.585	0.436	-8.761	1	0.0601	0.105	0.132	143.874	1.31e-05	0.721
3U4isOIWM3VvDubwSI3y7a	All of Me	87	8	269560	4	0.422	0.264	-7.064	1	0.0322	0.132	0.331	119.93	0	0.922
53QF56cjZA9RTuuMZDrSA6	I Won't Give Up	73	4	240166	3	0.483	0.303	-10.058	1	0.0429	0.115	0.139	133.406	0	0.694
56sxN1yKg1dgOZXBcAHkJG	Gone, Gone, Gone	75	6	209693	4	0.664	0.642	-5.961	1	0.038	0.114	0.501	118.002	0	0.129
09ZcYBGFX16X8GMDrvqQwt	For the First Time	62	9	252853	4	0.396	0.629	-4.78	1	0.0287	0.183	0.358	173.794	0	0.0328
4BycRneKmOs6MhYG9THsuX	Find Your Love	70	6	208947	4	0.627	0.614	-6.006	0	0.17	0.0286	0.758	96.038	0	0.0211
4G8gkOterJn0Ywt6uhqbhp	Radioactive	75	9	186813	4	0.448	0.784	-3.686	1	0.0627	0.668	0.236	136.245	0.000108	0.106
0qwcGscxUHGZTgq0zcaqk1	Here's to Never Growing Up	70	0	214320	4	0.482	0.873	-3.145	1	0.0853	0.409	0.737	165.084	0	0.0111
03UrZgTINDqvnUMbbIMhql	Gangnam Style	76	11	219493	4	0.727	0.937	-2.871	0	0.286	0.091	0.749	132.067	0	0.00417
3hsmbFKT5Cujb5GQjqEU39	Look At Me Now (feat. Lil' Wayne & Busta Rhymes)	74	11	222587	4	0.767	0.677	-6.128	0	0.184	0.144	0.538	146.155	5.51e-06	0.0339
2qxmye6gAegTMjLKEBoR3d	Let Me Down Slowly	87	1	169354	4	0.652	0.557	-5.714	0	0.0318	0.124	0.483	150.073	0	0.74
3GBApU0NuzH4hKZq4NOSdA	What You Know	76	6	191707	4	0.563	0.739	-4.239	0	0.0416	0.0822	0.775	139	1.45e-05	0.00073
5mCPDVBb16L4XQwDdbRUpz	Passionfruit	87	11	298941	4	0.809	0.463	-11.377	1	0.0396	0.109	0.364	111.98	0.085	0.256
3VqeTFIvhxu3DIe4eZVzGq	Butter	9	8	164442	4	0.759	0.459	-5.187	1	0.0948	0.0906	0.695	109.997	0	0.00323
6KuHjfXHkfnIjdmcIvt9r0	On Top Of The World	71	0	189840	4	0.635	0.926	-5.589	1	0.151	0.0928	0.761	100.048	4.53e-06	0.0893
6KBYk8OFtod7brGuZ3Y67q	Misery	64	4	216200	4	0.704	0.81	-4.874	0	0.0425	0.216	0.726	102.98	0	0.000315
2QD4C6RRHgRNRAyrfnoeAo	Play Hard (feat. Ne-Yo & Akon)	63	8	201000	4	0.691	0.921	-1.702	0	0.0535	0.331	0.802	130.072	0	0.174
4kte3OcW800TPvOVgrLLj8	Let Me Love You (Until You Learn To Love Yourself)	70	5	251627	4	0.658	0.677	-6.628	1	0.0393	0.368	0.248	124.91	0	0.248
1NpW5kyvO4XrNJ3rnfcNy3	Wild Ones (feat. Sia)	80	5	232947	4	0.608	0.86	-5.324	0	0.0554	0.262	0.437	127.075	0	0.0991
22vgEDb5hykfaTwLuskFGD	Sucker	83	1	181027	4	0.842	0.734	-5.065	0	0.0588	0.106	0.952	137.958	0	0.0427
1WtTLtofvcjQM3sXSMkDdX	How Low	65	1	201587	4	0.785	0.498	-6.977	1	0.0533	0.224	0.418	143.96	1.23e-06	0.00248
0azC730Exh71aQlOt9Zj3y	This Is What You Came For	85	9	222160	4	0.631	0.927	-2.787	0	0.0332	0.148	0.465	123.962	0.119	0.199
6V1bu6o1Yo5ZXnsCJU8Ovk	Girls Like You (feat. Cardi B) - Cardi B Version	67	0	235545	4	0.851	0.541	-6.825	1	0.0505	0.13	0.448	124.959	0	0.568
2L7rZWg9RLxIwnysmxm4xk	Boyfriend	65	10	171333	4	0.717	0.55	-6.019	0	0.0519	0.126	0.331	96.979	0.00198	0.0358
463CkQjx2Zk1yXoBuierM9	Levitating (feat. DaBaby)	75	6	203064	4	0.702	0.825	-3.787	0	0.0601	0.0674	0.915	102.977	0	0.00883
0skYUMpS0AcbpjcGsAbRGj	Pink Venom	73	0	186964	4	0.798	0.697	-7.139	1	0.0891	0.259	0.745	90.031	0	0.0202
23L5CiUhw2jV1OIMwthR3S	In the Name of Love	82	4	195707	4	0.501	0.519	-5.88	0	0.0409	0.454	0.168	133.99	0	0.109
3jjujdWJ72nww5eGnfs2E7	Adore You	86	8	207133	4	0.676	0.771	-3.675	1	0.0483	0.102	0.569	99.048	7e-06	0.0237
5DI9jxTHrEiFAhStG7VA8E	Started From the Bottom	70	8	174133	4	0.793	0.524	-7.827	1	0.156	0.156	0.579	86.325	0	0.0319
2rurDawMfoKP4uHyb2kJBt	Te Felicito	83	5	172235	4	0.695	0.636	-4.654	1	0.317	0.081	0.575	174.14	0	0.234
3GCdLUSnKSMJhs4Tj6CV3s	All The Stars (with SZA)	86	8	232187	4	0.698	0.633	-4.946	1	0.0597	0.0926	0.552	96.924	0.000194	0.0605
2Bs4jQEGMycglOfWPBqrVG	Steal My Girl	82	10	228133	4	0.536	0.768	-5.948	0	0.0347	0.114	0.545	77.217	0	0.00433
40iJIUlhi6renaREYGeIDS	Fair Trade (with Travis Scott)	86	1	291175	4	0.666	0.465	-8.545	1	0.26	0.215	0.292	167.937	0	0.0503
5RqR4ZCCKJDcBLIn4sih9l	Party Girl	73	6	147800	4	0.728	0.431	-9.966	0	0.0622	0.0996	0.629	130.022	0	0.749
6K4t31amVTZDgR3sKmwUJJ	The Less I Know The Better	87	4	216320	4	0.64	0.74	-4.083	1	0.0284	0.167	0.785	116.879	0.00678	0.0115
4gs07VlJST4bdxGbBsXVue	Heartbreak Warfare	66	2	269720	4	0.624	0.554	-8.113	1	0.0225	0.299	0.311	97.031	0.00131	0.191
439TlnnznSiBbQbgXiBqAd	m.A.A.d city	70	2	350120	4	0.487	0.729	-6.815	1	0.271	0.44	0.217	91.048	4.07e-06	0.0538
70ATm56tH7OrQ1zurYssz0	I Need A Doctor	72	3	283733	4	0.594	0.946	-4.521	1	0.452	0.306	0.397	155.826	0	0.0869
5jQI2r1RdgtuT8S3iG8zFC	Lavender Haze	86	10	202396	4	0.733	0.436	-10.489	1	0.08	0.157	0.0976	96.985	0.000573	0.258
2Z8yfpFX0ZMavHkcIeHiO1	Monster (Shawn Mendes & Justin Bieber)	71	2	178994	4	0.652	0.383	-7.076	0	0.0516	0.0828	0.549	145.765	0	0.0676
083Qf6hn6sFL6xiOHlZUyn	I'll Be There	65	7	193924	4	0.623	0.851	-3.111	1	0.0409	0.12	0.4	100.063	0	0.0228
2sLwPnIP3CUVmIuHranJZU	Wiggle (feat. Snoop Dogg)	58	9	193296	4	0.697	0.621	-6.886	0	0.25	0.162	0.721	81.946	0	0.0802
4k6Uh1HXdhtusDW5y8Gbvy	Bad Habit	84	1	232067	4	0.686	0.494	-7.093	1	0.0355	0.402	0.7	168.946	5.8e-05	0.613
7vS3Y0IKjde7Xg85LWIEdP	Problem	77	1	193920	4	0.66	0.805	-5.352	0	0.153	0.159	0.625	103.008	8.83e-06	0.0192
2xGjteMU3E1tkEPVFBO08U	This Is Me	67	2	234707	4	0.284	0.704	-7.276	1	0.186	0.0424	0.1	191.702	0.000115	0.00583
2Xnv3GntqbBH1juvUYSpHG	So Am I	73	6	183027	4	0.681	0.657	-4.671	1	0.0432	0.353	0.628	130.089	0	0.0748
3XOalgusokruzA5ZBA2Qcb	pushin P (feat. Young Thug)	77	1	136267	1	0.773	0.422	-4.572	0	0.187	0.129	0.488	77.502	0.00693	0.00783
4N1MFKjziFHH4IS3RYYUrU	My Love	76	8	259934	4	0.813	0.616	-7.571	1	0.0495	0.0658	0.744	119.977	0.705	0.000132
6DCZcSspjsKoFjzjrWoCdn	God's Plan	87	7	198973	4	0.754	0.449	-9.211	1	0.109	0.552	0.357	77.169	8.29e-05	0.0332
6YUTL4dYpB9xZO5qExPf05	Summer	85	4	222533	4	0.596	0.856	-3.556	0	0.0346	0.141	0.743	127.949	0.0178	0.0211
1eyzqe2QqGZUmfcPZtrIyt	Midnight City	74	11	241440	4	0.526	0.712	-6.525	0	0.0356	0.179	0.32	105.009	0	0.0161
7EVk9tRb6beJLTHrg6AkY9	Tuesday (feat. Danelle Sandoval)	73	9	241875	4	0.841	0.639	-6.052	0	0.0688	0.0545	0.675	99.002	0.0654	0.0156
5uCax9HTNlzGybIStD3vDh	Say You Won't Let Go	87	10	211467	4	0.358	0.557	-7.398	1	0.059	0.0902	0.494	85.043	0	0.695
4nVBt6MZDDP6tRVdQTgxJg	Story of My Life	84	3	245493	4	0.6	0.663	-5.802	1	0.0477	0.119	0.286	121.07	0	0.225
6lV2MSQmRIkycDScNtrBXO	Airplanes (feat. Hayley Williams of Paramore)	78	6	180480	4	0.66	0.867	-4.285	0	0.116	0.0368	0.377	93.033	0	0.11
7qiZfU4dY1lWllzX7mPBI3	Shape of You	89	1	233713	4	0.825	0.652	-3.183	0	0.0802	0.0931	0.931	95.977	0	0.581
0RUGuh2uSNFJpGMSsD1F5C	It Will Rain	71	2	257720	4	0.576	0.835	-6.826	1	0.0486	0.082	0.476	150.017	0	0.337
0VhgEqMTNZwYL1ARDLLNCX	Can I Be Him	81	11	246880	4	0.696	0.543	-6.164	1	0.0489	0.0939	0.479	107.969	0	0.308
5Nm9ERjJZ5oyfXZTECKmRt	Stay With Me	85	0	172724	4	0.418	0.42	-6.444	1	0.0414	0.11	0.184	84.094	6.39e-05	0.588
1PckUlxKqWQs3RlWXVBLw3	About Damn Time	80	10	191822	4	0.836	0.743	-6.305	0	0.0656	0.335	0.722	108.966	0	0.0995
22LAwLoDA5b4AaGSkg6bKW	Blueberry Faygo	76	0	162547	4	0.774	0.554	-7.909	1	0.0383	0.132	0.349	99.034	0	0.207
62PaSfnXSMyLshYJrlTuL3	Hello	75	5	295502	4	0.578	0.43	-6.134	0	0.0305	0.0854	0.288	78.991	0	0.33
1oHxIPqJyvAYHy0PVrDU98	Drinking from the Bottle (feat. Tinie Tempah)	62	9	240347	4	0.665	0.886	-4.175	0	0.0514	0.0525	0.53	128.062	6.24e-05	0.0469
1RMRkCn07y2xtBip9DzwmC	Turn Up the Music	65	1	227973	4	0.594	0.841	-5.792	1	0.102	0.156	0.643	129.925	2.22e-06	0.000238
6I3mqTwhRpn34SLVafSH7G	Ghost	87	2	153190	4	0.601	0.741	-5.569	1	0.0478	0.415	0.441	153.96	2.91e-05	0.185
5WvAo7DNuPRmk4APhdPzi8	No Brainer	66	0	260000	5	0.552	0.76	-4.706	1	0.342	0.0865	0.639	135.702	0	0.0733
1P17dC1amhFzptugyAO7Il	Look What You Made Me Do	86	9	211853	4	0.766	0.709	-6.471	0	0.123	0.126	0.506	128.07	1.41e-05	0.204
3nB82yGjtbQFSU0JLAwLRH	Not a Bad Thing	57	0	688453	4	0.308	0.563	-9.169	1	0.0719	0.134	0.109	85.901	4.58e-06	0.527
1i1fxkWeaMmKEB4T7zqbzK	Don't Let Me Down	82	11	208373	4	0.532	0.869	-5.094	1	0.172	0.136	0.422	159.803	0.00508	0.157
6p5abLu89ZSSpRQnbK9Wqs	Post to Be (feat. Chris Brown & Jhene Aiko)	56	10	226581	4	0.733	0.676	-5.655	0	0.0432	0.208	0.701	97.448	0	0.0697
698ItKASDavgwZ3WjaWjtz	Faded	82	6	212107	4	0.468	0.627	-5.085	1	0.0476	0.11	0.159	179.642	7.97e-06	0.0281
7aXuop4Qambx5Oi3ynsKQr	I Don't Mind (feat. Juicy J)	68	4	251989	4	0.87	0.464	-8.337	1	0.178	0.0902	0.457	112.974	0	0.205
6RtPijgfPKROxEzTHNRiDp	Rude	84	1	224840	4	0.773	0.758	-4.993	1	0.0381	0.305	0.925	144.033	0	0.0422
4C6Uex2ILwJi9sZXRdmqXp	Super Freaky Girl	78	2	170977	4	0.95	0.891	-2.653	1	0.241	0.309	0.912	133.01	1.77e-05	0.0645
6Xom58OOXk2SoU711L2IXO	Moscow Mule	86	5	245940	4	0.804	0.674	-5.453	0	0.0333	0.115	0.292	99.968	1.18e-06	0.294
1Fxp4LBWsNC58NwnGAXJld	Down With The Trumpets	60	4	186851	4	0.753	0.88	-4.689	0	0.0806	0.24	0.794	115.057	0	0.087
1PAYgOjp1c9rrZ2kVQg2vN	Changed the Way You Kiss Me - Radio Edit	64	4	195467	4	0.578	0.857	-3.78	0	0.041	0.0948	0.188	126.979	0.00162	0.00548
4l0Mvzj72xxOpRrp6h8nHi	Lose You To Love Me	83	4	206459	4	0.488	0.343	-8.985	1	0.0436	0.21	0.0978	102.819	0	0.556
7MXVkk9YMctZqd1Srtv4MB	Starboy	92	7	230453	4	0.679	0.587	-7.015	1	0.276	0.137	0.486	186.003	6.35e-06	0.141
3zsRP8rH1kaIAo9fmiP4El	Angels	65	9	171653	4	0.424	0.157	-18.141	1	0.0428	0.101	0.342	91.537	0.0593	0.95
2sEk5R8ErGIFxbZ7rX6S2S	How to Be a Heartbreaker	71	11	221493	4	0.69	0.897	-4.696	0	0.0506	0.108	0.849	140.05	0	0.0142
0oJMv049q8hEkes9w0L1J4	Imma Be	68	0	257560	4	0.597	0.517	-6.963	1	0.366	0.307	0.413	92.035	0	0.179
3rWDp9tBPQR9z6U5YyRSK4	Midnight Rain	86	0	174783	4	0.643	0.363	-11.738	1	0.0767	0.115	0.23	139.865	5.17e-05	0.69
36cmM3MBMWWCFIiQ90U4J8	Bounce (feat. Kelis) - Radio Edit	64	2	222187	4	0.779	0.963	-2.125	0	0.0399	0.664	0.759	127.941	0.493	0.0334
0IF7bHzCXCZoKNog5vBC4g	Wherever You Will Go	60	9	197577	4	0.597	0.115	-9.217	1	0.0334	0.111	0.128	111.202	0.000215	0.82
1wJRveJZLSb1rjhnUHQiv6	Swervin (feat. 6ix9ine)	75	9	189487	4	0.581	0.662	-5.239	1	0.303	0.111	0.434	93.023	0	0.0153
0ct6r3EGTcMLPtrXHDvVjc	The Nights	88	6	176658	4	0.527	0.835	-5.298	1	0.0433	0.249	0.654	125.983	0	0.0166
4TCL0qqKyqsMZml0G3M9IM	Telephone	75	3	220640	4	0.824	0.836	-5.903	1	0.0404	0.112	0.716	122.014	0.000817	0.00521
6ImEBuxsbuTowuHmg3Z2FO	Mad Love	67	0	169813	4	0.623	0.796	-2.981	0	0.199	0.115	0.607	197.524	0	0.659
6gBFPUFcJLzWGx4lenP6h2	goosebumps	87	7	243837	4	0.841	0.728	-3.37	1	0.0484	0.149	0.43	130.049	0	0.0847
0nrRP2bk19rLc0orkWPQk2	Wake Me Up	88	2	247427	4	0.532	0.783	-5.697	1	0.0523	0.161	0.643	124.08	0.0012	0.0038
1hBM2D1ULT3aeKuddSwPsK	STARSTRUKK (feat. Katy Perry)	66	11	202667	4	0.607	0.805	-5.579	0	0.0608	0.231	0.232	139.894	0	0.00175
2rDwdvBma1O1eLzo29p2cr	Whataya Want from Me	64	11	227320	4	0.44	0.683	-4.732	0	0.0489	0.0593	0.445	185.948	0	0.00706
0eu4C55hL6x29mmeAjytzC	Life Goes On	77	0	161803	4	0.7	0.49	-5.187	1	0.076	0.117	0.569	79.982	0	0.186
0z8hI3OPS8ADPWtoCjjLl6	Summer of Love (Shawn Mendes & Tainy)	77	11	184104	4	0.776	0.808	-4.501	1	0.117	0.103	0.494	123.988	0.000127	0.0297
4HlFJV71xXKIGcU3kRyttv	Hey, Soul Sister	85	1	216773	4	0.673	0.886	-4.44	0	0.0431	0.0826	0.795	97.012	0	0.185
6IPwKM3fUUzlElbvKw2sKl	we fell in love in october	86	7	184154	4	0.566	0.366	-12.808	1	0.028	0.155	0.237	129.96	0.181	0.113
31zeLcKH2x3UCMHT75Gk5C	Commander	46	11	218107	4	0.395	0.876	-3.859	0	0.138	0.362	0.567	124.638	8.46e-06	0.0173
1xzi1Jcr7mEi9K2RfzLOqS	CUFF IT	87	7	225389	4	0.78	0.689	-5.668	1	0.141	0.0698	0.642	115.042	9.69e-06	0.0368
5s7xgzXtmY4gMjeSlgisjy	Easy Love	68	9	229813	4	0.68	0.942	-4.208	1	0.0631	0.117	0.647	123.976	0.0013	0.175
41KPpw0EZCytxNkmEMJVgr	One - Radio Edit	63	0	169920	4	0.802	0.781	-6.564	1	0.0368	0.147	0.622	125.026	0.825	0.0075
4z7gh3aIZV9arbL9jJSc5J	Ghost	58	9	213213	4	0.68	0.84	-3.823	1	0.0414	0.143	0.468	104.975	8.66e-06	0.0457
2tpWsVSb9UEmDRxAl1zhX1	Counting Stars	88	1	257267	4	0.664	0.705	-4.972	0	0.0382	0.118	0.477	122.016	0	0.0654
7g13jf3zqlP5S68Voo5v9m	Dancing On My Own - Radio Edit	62	6	278080	4	0.573	0.926	-6.045	1	0.0342	0.127	0.219	117.047	0.0117	0.00202
0DiDStADDVh3SvAsoJAFMk	Only Human	74	0	183000	4	0.795	0.496	-5.883	1	0.0722	0.0645	0.874	94.01	0	0.108
7KXjTSCq5nL1LoYtL7XAwS	HUMBLE.	86	1	177000	4	0.908	0.621	-6.638	0	0.102	0.0958	0.421	150.011	5.39e-05	0.000282
3JvKfv6T31zO0ini8iNItO	Another Love	91	4	244360	4	0.445	0.537	-8.532	0	0.04	0.0944	0.131	122.769	1.65e-05	0.695
2XHzzp1j4IfTNp1FTn7YFg	Love Me	84	11	255053	4	0.669	0.634	-6.476	1	0.0327	0.0946	0.496	124.906	0	0.0125
5ujh1I7NZH5agbwf7Hp8Hc	Swimming Pools (Drank) - Extended Version	71	1	313787	4	0.716	0.485	-7.745	1	0.404	0.604	0.26	74.132	2.69e-05	0.123
5JLv62qFIS1DR3zGEcApRt	Wide Awake	70	5	220947	4	0.514	0.683	-5.099	1	0.0367	0.392	0.575	159.814	2.64e-06	0.0749
0ZNrc4kNeQYD9koZ3KvCsy	BIG BANK (feat. 2 Chainz, Big Sean, Nicki Minaj)	66	1	237240	4	0.745	0.346	-7.709	1	0.331	0.0881	0.112	203.911	0	0.00552
6PERP62TejQjgHu81OHxgM	good 4 u	24	6	178148	4	0.556	0.661	-5.052	0	0.204	0.101	0.668	168.56	0	0.3
5CMjjywI0eZMixPeqNd75R	Lose Yourself to Dance (feat. Pharrell Williams)	70	10	353893	4	0.832	0.659	-7.828	0	0.057	0.0753	0.674	100.163	0.00114	0.0839
3Tu7uWBecS6GsLsL8UONKn	Don't Stop the Party (feat. TJR)	68	4	206120	4	0.722	0.958	-3.617	1	0.0912	0.375	0.952	127.008	0	0.00726
6t6oULCRS6hnI7rm0h5gwl	Some Nights	71	0	277040	4	0.672	0.738	-7.045	1	0.0506	0.0927	0.392	107.938	6.75e-05	0.0178
37BZB0z9T8Xu7U3e65qxFy	Save Your Tears (with Ariana Grande) (Remix)	83	0	191014	4	0.65	0.825	-4.645	1	0.0325	0.0936	0.593	118.091	2.44e-05	0.0215
29d0nY7TzCoi22XBqDQkiP	Running Up That Hill (A Deal With God) - 2018 Remaster	28	10	300840	4	0.625	0.533	-11.903	0	0.0596	0.0546	0.139	108.296	0.00266	0.659
61KpQadow081I2AsbeLcsb	deja vu	17	9	215508	4	0.439	0.61	-7.236	1	0.116	0.341	0.172	181.088	1.07e-05	0.593
2vwlzO0Qp8kfEtzTsCXfyE	Wrecking Ball	82	5	221360	4	0.53	0.422	-6.262	1	0.0342	0.107	0.349	119.964	0	0.407
0Dc7J9VPV4eOInoxUiZrsL	Don't Tell 'Em	75	2	266840	4	0.856	0.527	-5.225	1	0.0997	0.11	0.386	98.052	0	0.392
35KiiILklye1JRRctaLUb4	Holocene	59	1	336613	4	0.374	0.304	-14.52	1	0.0302	0.126	0.147	147.969	0.298	0.943
5enxwA8aAbwZbf5qCHORXi	All Too Well (10 Minute Version) (Taylor's Version) (From The Vault)	87	0	613027	4	0.631	0.518	-8.771	1	0.0303	0.088	0.205	93.023	0	0.274
19cL3SOKpwnwoKkII7U3Wh	Geronimo	68	7	218228	4	0.705	0.78	-6.267	1	0.0805	0.115	0.457	142.028	0.00152	0.456
5N1o6d8zGcSZSeMFkOUQOk	Hot Girl Summer (feat. Nicki Minaj & Ty Dolla $ign)	67	0	199427	4	0.872	0.814	-4.568	1	0.155	0.214	0.57	98.985	1.96e-06	0.00485
0e7ipj03S05BNilyu5bRzt	rockstar (feat. 21 Savage)	86	5	218147	4	0.585	0.52	-6.136	0	0.0712	0.131	0.129	159.801	7.01e-05	0.124
3cHyrEgdyYRjgJKSOiOtcS	Timber (feat. Ke$ha)	84	11	204160	4	0.581	0.963	-4.087	1	0.0981	0.139	0.788	129.992	0	0.0295
0zbzrhfVS9S2TszW3wLQZ7	September Song	71	0	220291	4	0.614	0.615	-6.7	0	0.0444	0.0921	0.374	95.941	0	0.054
2iuZJX9X9P0GKaE93xcPjk	Sugar	83	1	235493	4	0.748	0.788	-7.055	1	0.0334	0.0863	0.884	120.076	0	0.0591
748mdHapucXQri7IAO8yFK	Kiss Me More (feat. SZA)	79	8	208867	4	0.762	0.701	-3.541	1	0.0286	0.123	0.742	110.968	0.000158	0.235
0MOiv7WTXCqvm89lVCf9C8	Million Voices - Radio Edit	70	8	192867	4	0.582	0.894	-6.298	1	0.041	0.0664	0.0694	125.946	0.0223	0.0022
5Qy6a5KzM4XlRxsNcGYhgH	6 Foot 7 Foot	74	2	248587	4	0.364	0.752	-5.429	1	0.304	0.318	0.606	79.119	0	0.0007
6v3KW9xbzN5yKLt9YKDYA2	SeÃ±orita	82	9	190800	4	0.759	0.548	-6.049	0	0.029	0.0828	0.749	116.967	0	0.0392
6DkXLzBQT7cwXmTyzAB1DJ	What's My Name?	74	2	263173	4	0.689	0.784	-2.972	1	0.074	0.0843	0.561	99.954	0	0.182
1DWZUa5Mzf2BwzpHtgbHPY	Good News	74	1	342040	4	0.794	0.32	-12.92	0	0.173	0.112	0.241	174.088	0.134	0.853
3uIGef7OSXkFdqxjFWn2o6	Gold Dust - Radio Edit	65	0	192447	4	0.451	0.948	-0.74	1	0.147	0.392	0.295	176.985	0	0.255
1JDIArrcepzWDTAWXdGYmP	I Want You To Know	68	9	240000	4	0.58	0.846	-2.876	0	0.0573	0.145	0.366	129.998	6.62e-06	0.00537
7mdNKXxia7AeSuJqjjA2rb	Beautiful People	55	5	225881	4	0.415	0.775	-6.366	0	0.161	0.0843	0.536	127.898	0.00431	0.0658
7hU3IHwjX150XLoTVmjD0q	MONEY	81	1	168228	4	0.831	0.554	-9.998	0	0.218	0.152	0.396	140.026	6.12e-05	0.161
3FAJ6O0NOHQV8Mc5Ri6ENp	Heartbreak Anniversary	82	0	198371	3	0.449	0.465	-8.964	1	0.0791	0.303	0.543	89.087	1.02e-06	0.524
58kZ9spgxmlEznXGu6FPdQ	Sick Boy	69	11	193200	4	0.663	0.577	-7.518	0	0.0531	0.12	0.454	89.996	0	0.109
0WCiI0ddWiu5F2kSHgfw5S	Take It Off	70	5	215200	4	0.729	0.675	-5.292	0	0.0286	0.0867	0.74	125.036	0.00126	4.14e-05
3ZCTVFBt2Brf31RLEnCkWJ	everything i wanted	86	6	245426	4	0.704	0.225	-14.454	0	0.0994	0.106	0.243	120.006	0.657	0.902
32OlwWuMpZ6b0aN2RZOeMS	Uptown Funk (feat. Bruno Mars)	85	0	269667	4	0.856	0.609	-7.223	1	0.0824	0.0344	0.928	114.988	8.15e-05	0.00801
4B0JvthVoAAuygILe3n4Bs	What Do You Mean?	80	5	205680	4	0.845	0.567	-8.118	0	0.0956	0.0811	0.793	125.02	0.00142	0.59
3tyPOhuVnt5zd5kGfxbCyL	Where Have You Been	74	0	242680	4	0.719	0.847	-6.34	0	0.0916	0.223	0.444	127.963	0.0204	0.00201
2dLLR6qlu5UJ5gk0dKz0h3	Royals	82	7	190185	4	0.674	0.428	-9.504	1	0.122	0.132	0.337	84.878	0	0.121
1zB4vmk8tFRmM9UULNzbLB	Thunder	88	0	187147	4	0.605	0.822	-4.833	1	0.0438	0.147	0.288	167.997	0.134	0.00671
2qT1uLXPVPzGgFOx4jtEuo	no tears left to cry	79	9	205920	4	0.699	0.713	-5.507	0	0.0594	0.294	0.354	121.993	3.11e-06	0.04
2t8yVaLvJ0RenpXUIAC52d	a lot	82	1	288624	4	0.837	0.636	-7.643	1	0.086	0.342	0.274	145.972	0.00125	0.0395
5jyUBKpmaH670zrXrE0wmO	Reload - Radio Edit	69	9	221273	4	0.485	0.724	-4.633	0	0.0521	0.0631	0.433	128.045	0	0.0736
1fu5IQSRgPxJL2OTP7FVLW	I See Fire	62	10	300747	4	0.633	0.0519	-21.107	0	0.0365	0.097	0.204	76.034	0	0.562
1A8j067qyiNwQnZT0bzUpZ	This Girl (Kungs Vs. Cookin' On 3 Burners)	81	0	195547	4	0.792	0.717	-4.759	0	0.0393	0.226	0.466	121.985	3.59e-05	0.0927
3e0yTP5trHBBVvV32jwXqF	Anna Sun	65	10	321280	4	0.472	0.844	-6.578	1	0.054	0.24	0.34	140.034	0	0.00173
5kqIPrATaCc2LqxVWzQGbk	7 Years	85	10	237300	4	0.765	0.473	-5.829	1	0.0514	0.391	0.34	119.992	0	0.287
4P0osvTXoSYZZC2n8IFH3c	Payphone	73	4	231387	4	0.739	0.756	-4.828	1	0.0394	0.37	0.523	110.028	0	0.0136
37dYAkMa4lzRCH6kDbMT1L	We No Speak Americano (Edit)	66	6	157438	4	0.902	0.805	-5.003	1	0.0468	0.0914	0.745	124.985	0.0823	0.0748
43zdsphuZLzwA9k4DJhU0I	when the party's over	85	4	196077	4	0.367	0.111	-14.084	1	0.0972	0.0897	0.198	82.642	3.97e-05	0.978
62ke5zFUJN6RvtXZgVH0F8	Only Love Can Hurt Like This	83	8	232893	4	0.566	0.885	-4.528	1	0.0818	0.334	0.304	90.99	9.97e-05	0.0958
4RL77hMWUq35NYnPLXBpih	Skinny Love	74	4	201080	4	0.379	0.29	-8.485	1	0.051	0.118	0.169	166.467	0.00106	0.952
5O2P9iiztwhomNh8xkR9lJ	Night Changes	89	8	226600	4	0.672	0.52	-7.747	1	0.0353	0.115	0.37	120.001	0	0.859
0tgVpDi06FyKpA1z0VMD4v	Perfect	90	8	263400	3	0.599	0.448	-6.312	1	0.0232	0.106	0.168	95.05	0	0.163
7dSZ6zGTQx66c2GF91xCrb	PROVENZA	81	1	210200	4	0.87	0.516	-8.006	1	0.0541	0.11	0.53	111.005	0.00823	0.656
72TFWvU3wUYdUuxejTTIzt	Work	79	11	219320	4	0.725	0.534	-6.238	1	0.0946	0.0919	0.558	91.974	0	0.0752
2r6DdaSbkbwoPzuK6NjLPn	Can't Be Tamed	67	11	168213	4	0.63	0.91	-2.919	0	0.144	0.196	0.743	116.98	0	0.0287
0PvFJmanyNQMseIFrU708S	For The Night (feat. Lil Baby & DaBaby)	80	6	190476	4	0.823	0.586	-6.606	0	0.2	0.193	0.347	125.971	0	0.114
6i0V12jOa3mr6uu4WYhUBr	Heathens	83	4	195920	4	0.732	0.396	-9.348	0	0.0286	0.105	0.548	90.024	3.58e-05	0.0841
4HXOBjwv2RnLpGG4xWOO6N	Princess of China	72	9	239216	4	0.42	0.69	-6.221	0	0.0347	0.287	0.237	85.014	0.015	0.00385
01TuObJVd7owWchVRuQbQw	#thatPOWER	68	6	279507	4	0.797	0.608	-6.096	0	0.0584	0.0748	0.402	127.999	7.66e-05	0.00112
0pEkK8MqbmGSX7fT8WLMbR	Grace	73	4	185658	4	0.722	0.565	-5.848	1	0.0335	0.165	0.488	104.483	0	0.435
04OxTCLGgDKfO0MMA2lcxv	Blind Faith	63	9	233667	4	0.45	0.846	-4.712	0	0.0472	0.228	0.402	140.042	0	0.00523
4xqrdfXkTW4T0RauPLv3WA	Heather	87	5	198040	3	0.357	0.425	-7.301	1	0.0333	0.322	0.27	102.078	0	0.584
55h7vJchibLdUkxdlX3fK7	Treasure	83	5	178560	4	0.874	0.692	-5.28	0	0.0431	0.324	0.937	116.017	7.24e-05	0.0412
7B1Dl3tXqySkB8OPEwVvSu	We'll Be Coming Back (feat. Example)	66	7	234360	4	0.596	0.952	-4.364	1	0.0873	0.598	0.571	127.945	0	0.00131
2QjOHCTQ1Jl3zawyYOpxh6	Sweater Weather	91	10	240400	4	0.612	0.807	-2.81	1	0.0336	0.101	0.398	124.053	0.0177	0.0495
0obBFrPYkSoBJbvHfUIhkv	Sexy And I Know It	66	7	199480	4	0.707	0.861	-4.225	1	0.316	0.191	0.795	130.021	0	0.1
1nueTG77MzNkJTKQ0ZdGzT	Don't Wanna Know (feat. Kendrick Lamar)	65	7	214265	4	0.783	0.61	-6.124	1	0.0696	0.0983	0.418	100.047	0	0.343
3WD91HQDBIavSapet3ZpjG	Video Games	71	6	281947	4	0.39	0.252	-9.666	0	0.0298	0.0887	0.181	122.053	0	0.808
34gCuhDGsG4bRPIf9bb02f	Thinking out Loud	85	2	281560	4	0.781	0.445	-6.061	1	0.0295	0.184	0.591	78.998	0	0.474
1z9kQ14XBSN0r2v6fx4IdG	Diamonds	77	11	225147	4	0.564	0.71	-4.92	0	0.0461	0.109	0.393	91.972	0	0.00125
2Wo6QQD1KMDWeFkkjLqwx5	Roses - Imanbek Remix	59	8	176219	4	0.785	0.721	-5.457	1	0.0506	0.285	0.894	121.962	0.00432	0.0149
4YYHgF9dWyVSor0GtrBzdf	Te Amo	71	8	208427	4	0.567	0.707	-5.455	0	0.0818	0.1	0.751	171.917	0.000176	0.541
4fINc8dnfcz7AdhFYVA4i7	It Girl	71	1	192200	4	0.668	0.718	-4.736	0	0.0605	0.104	0.345	91.993	0	0.0165
7mFj0LlWtEJaEigguaWqYh	Sweetest Pie	74	7	201334	4	0.814	0.628	-7.178	1	0.221	0.101	0.677	123.977	0	0.167
6nek1Nin9q48AVZcWs9e9D	Paradise	86	5	278719	4	0.449	0.585	-6.761	1	0.0268	0.0833	0.212	139.631	8.75e-05	0.0509
2stPxcgjdSImK7Gizl8ZUN	The Man	60	11	254880	4	0.308	0.769	-7.256	0	0.065	0.214	0.488	81.853	0	0.0331
3zHq9ouUJQFQRf3cm1rRLu	Love Me Like You Do - From "Fifty Shades Of Grey"	80	8	252534	4	0.262	0.606	-6.646	1	0.0484	0.125	0.275	189.857	0	0.247
3tjFYV6RSFtuktYl3ZtYcq	Mood (feat. iann dior)	6	7	140526	4	0.7	0.722	-3.558	0	0.0369	0.272	0.756	90.989	0	0.221
5Hroj5K7vLpIG4FNCRIjbP	Best Day Of My Life	82	2	194240	4	0.673	0.902	-2.392	1	0.0346	0.0558	0.538	100.012	0.000262	0.0591
6FB3v4YcR57y4tXFcdxI1E	I Knew You Were Trouble.	81	3	219720	4	0.622	0.469	-6.798	0	0.0363	0.0335	0.679	77.019	2.25e-06	0.00454
0JcKdUGNR7zI4jJDLyYXbi	Stuck Like Glue	67	1	247587	4	0.702	0.795	-4.764	1	0.0568	0.0505	0.836	83.961	0	0.329
19kUPdKTp85q9RZNwaXM15	Good as You	67	8	192053	4	0.626	0.516	-6.05	1	0.0388	0.142	0.769	153.653	0	0.4
50kpGaPAhYJ3sGmk6vplg0	Love Yourself	86	4	233720	4	0.609	0.378	-9.828	1	0.438	0.28	0.515	100.418	0	0.835
2fQ6sBFWaLv2Gxos4igHLy	Say Aah (feat. Fabolous)	65	1	207547	4	0.724	0.87	-3.614	0	0.113	0.833	0.81	93.01	0	0.00453
1bM50INir8voAkVoKuvEUI	OMG (feat. will.i.am)	76	4	269493	4	0.781	0.745	-5.81	0	0.0332	0.36	0.326	129.998	1.14e-05	0.198
4RVwu0g32PAqgUiJoXsdF8	Happier Than Ever	88	0	298899	3	0.332	0.225	-8.697	1	0.0348	0.128	0.297	81.055	0.00349	0.767
6FE2iI43OZnszFLuLtvvmg	Classic	83	1	175427	4	0.72	0.791	-4.689	1	0.124	0.157	0.756	102.071	0	0.0384
3O8NlPh2LByMU9lSRSHedm	Controlla	75	10	245227	4	0.59	0.468	-11.083	0	0.185	0.101	0.349	92.287	0	0.0789
5VSCgNlSmTV2Yq5lB40Eaw	Love Me Again	68	2	239894	4	0.495	0.894	-4.814	0	0.0441	0.103	0.213	126.03	0.000596	0.00453
3YJJjQPAbDT7mGpX3WtQ9A	Good Days	81	1	279204	4	0.436	0.655	-8.37	0	0.0583	0.688	0.412	121.002	8.1e-06	0.499
4iJyoBOLtHqaGxP12qzhQI	Peaches (feat. Daniel Caesar & Giveon)	84	0	198082	4	0.677	0.696	-6.181	1	0.119	0.42	0.464	90.03	0	0.321
6Vc5wAMmXdKIAM7WUoEb7N	Say Something	75	2	229400	3	0.407	0.147	-8.822	1	0.0355	0.0913	0.0765	141.284	2.89e-06	0.857
4h9wh7iOZ0GGn8QVp4RAOB	I Ain't Worried	92	0	148486	4	0.704	0.797	-5.927	1	0.0475	0.0546	0.825	139.994	0.000745	0.0826
27NovPIUIRrOZoCHxABJwK	INDUSTRY BABY (feat. Jack Harlow)	82	3	212000	4	0.736	0.704	-7.409	0	0.0615	0.0501	0.894	149.995	0	0.0203
6habFhsOp2NvshLv26DqMb	Despacito	82	2	229360	4	0.655	0.797	-4.787	1	0.153	0.067	0.839	177.928	0	0.198
7795WJLVKJoAyVoOtCWqXN	I'm Not The Only One	86	5	239317	4	0.677	0.485	-5.795	1	0.0361	0.0766	0.493	82.001	2.04e-05	0.529
28GUjBGqZVcAV4PHSYzkj2	So Good	66	7	213253	4	0.66	0.9	-5.02	1	0.14	0.219	0.591	85.51	0	0.0403
07MDkzWARZaLEdKxo6yArG	Meet Me At Our Spot	78	2	162680	4	0.773	0.47	-7.93	1	0.0299	0.0851	0.399	94.995	0.000193	0.0153
7DnAm9FOTWE3cUvso43HhI	Sweet but Psycho	82	1	187436	4	0.72	0.706	-4.719	1	0.0473	0.166	0.62	133.002	0	0.0684
45XhKYRRkyeqoW3teSOkCM	Wild Thoughts (feat. Rihanna & Bryson Tiller)	70	8	204664	4	0.613	0.681	-3.089	1	0.0778	0.126	0.619	97.621	0	0.0287
3QGsuHI8jO1Rx4JWLUh9jd	Treat You Better	87	10	187973	4	0.444	0.819	-4.078	0	0.341	0.107	0.747	82.695	0	0.106
1mXVgsBdtIVeCLJnSnmtdV	Too Good At Goodbyes	86	5	201000	4	0.681	0.372	-8.237	1	0.0432	0.169	0.476	91.873	0	0.64
5e0dZqrrTaoj6AIL7VjnBM	Written in the Stars (feat. Eric Turner)	48	7	207600	5	0.619	0.971	-3.045	1	0.13	0.196	0.295	122.552	0	0.0526
7JJmb5XwzOO8jgpou264Ml	There's Nothing Holdin' Me Back	87	11	199440	4	0.866	0.813	-4.063	0	0.0554	0.0779	0.969	121.998	0	0.38
6wN4nT2qy3MQc098yL3Eu9	Deuces (feat. Tyga & Kevin McCall)	71	1	276560	4	0.692	0.736	-5.109	1	0.11	0.0787	0.217	73.987	0	0.0324
2ihCaVdNZmnHZWt0fvAM7B	Little Talks	82	1	266600	4	0.457	0.757	-5.177	1	0.032	0.146	0.417	102.961	0	0.0206
4qikXelSRKvoCqFcHLB2H2	Mercy	74	6	329320	4	0.563	0.496	-9.381	0	0.406	0.173	0.426	139.993	5.8e-05	0.0685
5IgjP7X4th6nMNDh4akUHb	Under The Influence	89	9	184613	4	0.733	0.69	-5.529	0	0.0427	0.105	0.31	116.992	1.18e-06	0.0635
5kcE7pp02ezLZaUbbMv3Iq	Pound The Alarm	66	9	205640	4	0.728	0.858	-3.686	1	0.0609	0.0241	0.591	125.055	4.09e-06	0.0403
7HacCTm33hZYYN8DXpCYuG	I Like It	67	10	231373	4	0.648	0.942	-2.881	0	0.0878	0.0594	0.73	129.007	0	0.021
0gplL1WMoJ6iYaPgMCL0gX	Easy On Me	84	5	224695	4	0.604	0.366	-7.519	1	0.0282	0.133	0.13	141.981	0	0.578
5BhsEd82G0Mnim0IUH6xkT	Cruise	61	10	208960	4	0.457	0.948	-3.364	1	0.0354	0.0536	0.878	148	0	0.0191
4EAV2cKiqKP5UPZmY6dejk	Everyday	68	1	204747	4	0.667	0.741	-4.099	1	0.0378	0.0761	0.422	149.908	0	0.0425
5g7rJvWYVrloJZwKiShqlS	Dirty Paws	71	3	278373	4	0.359	0.649	-7.06	1	0.0349	0.0555	0.133	111.709	0.0124	0.107
1rfofaqEpACxVEHIZBJe6W	Havana (feat. Young Thug)	82	2	217307	4	0.765	0.523	-4.333	1	0.03	0.132	0.394	104.988	3.56e-05	0.184
6Z8R6UsFuGXGtiIxiD8ISb	Safe And Sound	85	0	192790	5	0.655	0.819	-4.852	1	0.0316	0.104	0.766	117.956	0.00374	0.000176
21jGcNKet2qwijlDFuPiPb	Circles	89	0	215280	4	0.695	0.762	-3.497	1	0.0395	0.0863	0.553	120.042	0.00244	0.192
0TXNKTzawI6VgLoA9UauRp	When You Love Someone	74	7	216560	4	0.681	0.453	-6.09	1	0.0278	0.0543	0.348	125.772	0	0.263
2GQEM9JuHu30sGFvRYeCxz	Faded	62	9	223480	4	0.867	0.477	-7.183	0	0.049	0.113	0.614	124.979	0.175	0.00843
4NTWZqvfQTlOMitlVn6tew	The Show Goes On	72	7	239613	4	0.591	0.889	-3.839	1	0.115	0.155	0.65	143.067	0	0.0189
5oO3drDxtziYU2H1X23ZIp	Love On The Brain	86	4	224000	3	0.509	0.637	-4.83	0	0.0471	0.0789	0.378	172.006	1.08e-05	0.0717
3bidbhpOYeV4knp8AIu8Xn	Can't Hold Us (feat. Ray Dalton)	83	2	258343	4	0.641	0.922	-4.457	1	0.0786	0.0862	0.847	146.078	0	0.0291
4u26EevCNXMhlvE1xFBJwX	If I Die Young	69	4	222773	4	0.606	0.497	-6.611	1	0.0277	0.275	0.362	130.739	0	0.348
0SGkqnVQo9KPytSri1H6cF	Bounce Back	71	1	222360	4	0.78	0.575	-5.628	0	0.139	0.129	0.273	81.502	0	0.106
3LUWWox8YYykohBbHUrrxd	We R Who We R	74	8	204760	4	0.736	0.817	-4.9	1	0.0407	0.117	0.653	119.95	0.00167	0.00987
6r2BECwMgEoRb5yLfp0Hca	Born This Way	71	11	260253	4	0.587	0.828	-5.108	1	0.161	0.331	0.494	123.907	0	0.00327
3xKsf9qdS1CyvXSMEid6g8	Pink + White	90	9	184516	3	0.545	0.545	-7.362	1	0.107	0.417	0.549	159.94	5.48e-05	0.667
0c4IEciLCDdXEhhKxj4ThA	Madness	70	10	281040	4	0.502	0.417	-7.665	1	0.0718	0.106	0.218	180.301	0.00419	0.127
0v1x6rN6JHRapa03JElljE	Dynamite	0	6	199054	4	0.746	0.765	-4.41	0	0.0993	0.0936	0.737	114.044	0	0.0112
7tFiyTwD0nx5a1eklYtX2J	Bohemian Rhapsody - Remastered 2011	75	0	354320	4	0.392	0.402	-9.961	0	0.0536	0.243	0.228	143.883	0	0.288
2YpeDb67231RjR0MgVLzsG	Old Town Road - Remix	79	6	157067	4	0.878	0.619	-5.56	1	0.102	0.113	0.639	136.041	0	0.0533
0y60itmpH0aPKsFiGxmtnh	Wait a Minute!	81	3	196520	4	0.764	0.705	-5.279	0	0.0278	0.0943	0.672	101.003	1.94e-05	0.0371
25cUhiAod71TIQSNicOaW3	Adorn	71	11	193147	4	0.625	0.576	-5.693	0	0.175	0.187	0.235	179.063	4.07e-05	0.0543
0e8nrvls4Qqv5Rfa2UhqmO	THATS WHAT I WANT	84	1	143901	4	0.737	0.846	-4.51	0	0.22	0.0486	0.546	87.981	0	0.00614
7BKLCZ1jbUBVqRi2FVlTVw	Closer	86	8	244960	4	0.748	0.524	-5.599	1	0.0338	0.111	0.661	95.01	0	0.414
6lanRgr6wXibZr8KgzXxBl	A Thousand Years	83	10	285120	3	0.421	0.407	-7.445	1	0.0267	0.11	0.161	139.028	0.000961	0.309
6xGruZOHLs39ZbVccQTuPZ	Glimpse of Us	85	8	233456	3	0.44	0.317	-9.258	1	0.0531	0.141	0.268	169.914	4.78e-06	0.891
4rHZZAmHpZrA3iH5zx8frV	Mirrors	81	5	484147	4	0.574	0.512	-6.664	0	0.0503	0.0946	0.512	76.899	0	0.234
2M9ULmQwTaTGmAdXaXpfz5	Billionaire (feat. Bruno Mars)	75	6	211160	4	0.633	0.673	-6.403	0	0.258	0.206	0.659	86.776	0	0.297
2Z8WuEywRWYTKe1NybPQEW	Ride	85	6	214507	4	0.645	0.713	-5.355	1	0.0393	0.113	0.566	74.989	0	0.00835
0jdny0dhgjUwoIp5GkqEaA	Praying	71	10	230267	4	0.543	0.39	-7.202	1	0.0322	0.111	0.303	73.415	0	0.489
7xQAfvXzm3AkraOtGPWIZg	Wow.	84	11	149547	4	0.829	0.539	-7.359	0	0.208	0.103	0.388	99.96	1.78e-06	0.136
2JvzF1RMd7lE3KmFlsyZD8	MIDDLE CHILD	84	8	213594	4	0.837	0.364	-11.713	1	0.276	0.271	0.463	123.984	0	0.149
0vFMQi8ZnOM2y8cuReZTZ2	Blown Away	65	9	240133	4	0.531	0.843	-2.569	0	0.0429	0.0283	0.392	136.991	0	0.0909
1lOe9qE0vR9zwWQAOk6CoO	Ransom	82	7	131240	4	0.745	0.642	-6.257	0	0.287	0.0658	0.226	179.974	0	0.0204
5cc9Zbfp9u10sfJeKZ3h16	3005	80	6	234215	4	0.664	0.447	-7.272	0	0.289	0.091	0.659	83.138	0	0.112
6Uj1ctrBOjOas8xZXGqKk4	Woman	87	5	172627	4	0.824	0.764	-4.175	0	0.0854	0.117	0.881	107.998	0.00294	0.0888
6Sq7ltF9Qa7SNFBsV5Cogx	Me Porto Bonito	90	1	178567	4	0.911	0.712	-5.105	0	0.0817	0.0933	0.425	92.005	2.68e-05	0.0901
5PUvinSo4MNqW7vmomGRS7	Blurred Lines	58	7	263053	4	0.861	0.504	-7.707	1	0.0489	0.0783	0.881	120	1.78e-05	0.00412
5NlFXQ0si6U87gXs6hq81B	Candy	71	10	201053	4	0.715	0.791	-6.63	1	0.0414	0.0694	0.879	116.043	0	0.0368
086myS9r57YsLbJpU0TgK9	Why'd You Only Call Me When You're High?	89	2	161124	4	0.691	0.631	-6.478	1	0.0368	0.104	0.8	92.004	1.13e-05	0.0483
2tJulUYLDKOg9XrtVkMgcJ	Grenade	80	2	222091	4	0.704	0.558	-7.273	0	0.0542	0.107	0.245	110.444	0	0.148
60nZcImufyMA1MKQY3dcCH	Happy - From "Despicable Me 2"	83	5	232720	4	0.647	0.822	-4.662	0	0.183	0.0908	0.962	160.019	0	0.219
0zREtnLmVnt8KUJZZbSdla	Wavin' Flag	61	0	220520	4	0.625	0.699	-6.416	1	0.0729	0.238	0.717	75.974	0	0.13
4gbVRS8gloEluzf0GzDOFc	Maps	86	1	189960	4	0.742	0.713	-5.522	0	0.0303	0.059	0.879	120.032	0	0.0205
34ZAzO78a5DAVNrYIGWcPm	Shirt	73	3	181831	4	0.824	0.453	-9.604	0	0.0968	0.0896	0.552	119.959	0.0273	0.146
52xJxFP6TqMuO4Yt0eOkMz	We Don't Talk About Bruno	77	0	216120	4	0.577	0.45	-8.516	0	0.0834	0.111	0.83	205.863	0	0.357
6Im9k8u9iIzKMrmV7BWtlF	34+35	80	0	173711	4	0.83	0.585	-6.476	1	0.094	0.248	0.485	109.978	0	0.237
2BOqDYLOJBiMOXShCV1neZ	Dancing On My Own	82	1	260285	4	0.681	0.174	-8.745	1	0.0315	0.0983	0.231	112.672	3.35e-05	0.837
61LtVmmkGr8P9I2tSPvdpf	Teach Me How to Dougie	70	11	237480	4	0.846	0.438	-4.981	1	0.141	0.0939	0.512	85.013	9.43e-05	0.2
2Fxmhks0bxGSBdJ92vM42m	bad guy	85	7	194088	4	0.701	0.425	-10.965	1	0.375	0.1	0.562	135.128	0.13	0.328
2FV7Exjr70J652JcGucCtE	The Mother We Share	59	1	191294	4	0.45	0.677	-6.428	1	0.0313	0.126	0.324	174.027	3.02e-06	0.0319
0V3wPSX9ygBnCm8psDIegu	Anti-Hero	93	4	200690	4	0.637	0.643	-6.571	1	0.0519	0.142	0.533	97.008	1.8e-06	0.13
0WSEq9Ko4kFPt8yo3ICd6T	Praise God	78	1	226653	4	0.798	0.545	-6.466	1	0.168	0.258	0.212	118.029	9.48e-05	0.00904
5knuzwU65gJK7IF5yJsuaW	Rockabye (feat. Sean Paul & Anne-Marie)	77	9	251088	4	0.72	0.763	-4.068	0	0.0523	0.18	0.742	101.965	0	0.406
69gQgkobVW8bWjoCjBYQUd	I Got U	62	9	285596	4	0.636	0.761	-7.752	0	0.035	0.0851	0.463	120.837	0.00784	0.00377
1auxYwYrFRqZP7t3s7w4um	Ni**as In Paris	77	1	219333	4	0.789	0.858	-5.542	1	0.311	0.349	0.775	140.022	0	0.127
5jzKL4BDMClWqRguW5qZvh	Teenage Dream	76	10	227741	4	0.719	0.798	-4.582	1	0.0361	0.134	0.591	120.011	2.34e-06	0.0162
0Oqc0kKFsQ6MhFOLBNZIGX	Doin' Time	84	7	202193	4	0.641	0.559	-11.132	0	0.0355	0.0937	0.523	144.982	0.00402	0.404
68rcszAg5pbVaXVvR7LFNh	One Day / Reckoning Song (Wankelmut Remix) - Radio Edit	70	3	215187	4	0.826	0.668	-6.329	0	0.0571	0.167	0.534	118.99	6.92e-05	0.223
4Kz4RdRCceaA9VgTqBhBfa	The Motto	77	1	181573	4	0.766	0.442	-8.558	1	0.356	0.111	0.39	201.8	6.12e-05	0.000107
3F5CgOj3wFlRv51JsHbxhe	Jimmy Cooks (feat. 21 Savage)	89	0	218365	4	0.529	0.673	-4.711	1	0.175	0.093	0.366	165.921	2.41e-06	0.000307
2GYHyAoLWpkxLVa4oYTVko	Alors on danse - Radio Edit	80	1	206067	4	0.791	0.59	-9.206	0	0.0793	0.065	0.714	119.951	0.00203	0.0994
7igeByaBM0MgGsgXtNxDJ7	positions	0	0	172325	4	0.736	0.802	-4.759	1	0.0864	0.094	0.675	144.005	0	0.468
127QTOFJsJQp5LbJbu3A1y	Toosie Slide	74	1	247059	4	0.834	0.454	-9.75	0	0.201	0.114	0.837	81.618	6.15e-06	0.321
4LEK9rD7TWIG4FCL1s27XC	cardigan	53	0	239560	4	0.613	0.581	-8.588	0	0.0424	0.25	0.551	130.033	0.000345	0.537
2vXKRlJBXyOcvZYTdNeckS	Lost in the Fire (feat. The Weeknd)	85	2	202093	4	0.658	0.671	-12.21	1	0.0363	0.115	0.166	100.966	0.000927	0.0933
7LcfRTgAVTs5pQGEQgUEzN	Moves Like Jagger - Studio Recording From "The Voice" Performance	74	11	201160	4	0.722	0.758	-4.477	0	0.0471	0.308	0.62	128.047	0	0.0111
3nY8AqaMNNHHLYV4380ol0	Dick (feat. Doja Cat)	71	9	175238	4	0.647	0.608	-6.831	1	0.42	0.0584	0.474	125.994	0	0.13
5UqCQaDshqbIk3pkhy4Pjg	Levels - Radio Edit	82	1	199907	4	0.584	0.889	-5.941	0	0.0343	0.309	0.464	126.04	0.828	0.0462
5FVd6KXrgO9B3JPmC8OPst	Do I Wanna Know?	89	5	272394	4	0.548	0.532	-7.596	1	0.0323	0.217	0.405	85.03	0.000263	0.186
2iUmqdfGZcHIhS3b9E9EWq	Everybody Talks	81	8	177280	4	0.471	0.924	-3.906	1	0.0586	0.313	0.725	154.961	0	0.00301
59CfNbkERJ3NoTXDvoURjj	Boyfriend	82	7	153000	3	0.345	0.612	-6.543	0	0.0608	0.194	0.232	179.773	0	0.232
3B54sVLJ402zGa6Xm4YGNe	Unforgettable	86	6	233902	4	0.726	0.769	-5.043	1	0.123	0.104	0.733	97.985	0.0101	0.0293
35ovElsgyAtQwYPYnZJECg	Lift Me Up - From Black Panther: Wakanda Forever - Music From and Inspired By	78	9	196520	4	0.247	0.299	-6.083	1	0.0315	0.131	0.172	177.115	0	0.899
5BoIP8Eha5hwmRVURkC2Us	In My Head	64	0	199027	4	0.762	0.748	-4.15	0	0.033	0.348	0.851	110.009	0	0.0266
0u2P5u6lvoDfwTYjAADbn4	lovely (with Khalid)	90	4	200186	4	0.351	0.296	-10.109	0	0.0333	0.095	0.12	115.284	0	0.934
5n0CTysih20NYdT2S0Wpe8	Trouble	73	0	225973	4	0.47	0.623	-5.655	1	0.0302	0.0992	0.298	77.861	0.000439	0.392
6s8nHXTJVqFjXE4yVZPDHR	Troublemaker (feat. Flo Rida)	77	0	185587	4	0.762	0.863	-3.689	0	0.0561	0.125	0.965	106.012	0	0.015
0nJW01T7XtvILxQgC5J7Wh	When I Was Your Man	89	0	213827	4	0.612	0.28	-8.648	1	0.0434	0.088	0.387	72.795	0	0.932
53DB6LJV9B8sz0p1s6tlGS	Roll Up	64	3	227773	5	0.523	0.805	-5.473	1	0.192	0.0914	0.602	125.358	0	0.0524
0FDzzruyVECATHXKHFs9eJ	A Sky Full of Stars	87	6	267867	4	0.545	0.675	-6.474	1	0.0279	0.209	0.162	124.97	0.00197	0.00617
6y468DyY1V67RBNCwzrMrC	L.I.F.E.G.O.E.S.O.N.	58	4	228000	4	0.603	0.745	-5.79	1	0.0368	0.348	0.606	81.981	0	0.207
0IkKz2J93C94Ei4BvDop7P	Party Rock Anthem	71	5	262173	4	0.75	0.727	-4.21	0	0.142	0.266	0.359	129.993	0	0.0189
0TAmnCzOtqRfvA38DDLTjj	Little Things	76	7	219040	4	0.709	0.22	-11.856	1	0.0327	0.175	0.53	110.076	0	0.811
6UelLqGlWMcVH1E5c4H7lY	Watermelon Sugar	90	0	174000	4	0.548	0.816	-4.209	1	0.0465	0.335	0.557	95.39	0	0.122
29JrmE89KgRyCxBIzq2Ocw	Strip That Down (feat. Quavo)	70	6	202062	4	0.873	0.495	-5.446	1	0.0518	0.0805	0.546	106.033	0	0.199
5p7ujcrUXASCNwRaWNHR1C	Without Me	76	6	201661	4	0.752	0.488	-7.05	1	0.0705	0.0936	0.533	136.041	9.11e-06	0.297
5BrTUo0xP1wKXLJWUaGFtk	Loyal (feat. Lil Wayne & Tyga)	75	10	264947	4	0.841	0.522	-5.963	0	0.049	0.188	0.616	99.059	1.37e-06	0.0168
3SxiAdI8dP9AaaEz1Z24mn	Earthquake (feat. Tinie Tempah)	62	0	274600	4	0.54	0.856	-3.966	0	0.1	0.276	0.258	153.071	0	0.109
3e9HZxeyfWwjeyPAMmWSSQ	thank u, next	82	1	207320	4	0.717	0.653	-5.634	1	0.0658	0.101	0.412	106.966	0	0.229
2tNE4DP5nL85XUJv1glO0a	This Ain't a Love Song	49	0	210680	4	0.458	0.905	-4.157	1	0.0451	0.378	0.553	176.667	0	0.000431
1000nHvUdawXuUHgBod4Wv	Panini	72	5	114893	4	0.703	0.594	-6.146	0	0.0752	0.123	0.475	153.848	0	0.342
1gihuPhrLraKYrJMAEONyc	Feel So Close - Radio Edit	83	7	206413	4	0.707	0.924	-2.842	1	0.031	0.204	0.919	127.937	0.00703	0.000972
7a86XRg84qjasly9f6bPSD	We Are Young (feat. Janelle MonÃ¡e)	76	10	250627	4	0.378	0.638	-5.576	1	0.075	0.0849	0.735	184.086	7.66e-05	0.02
6PQ88X9TkUIAUIZJHW2upE	Bad Habits	18	11	231041	4	0.808	0.897	-3.712	0	0.0348	0.364	0.591	126.026	3.14e-05	0.0469
4LRPiXqCikLlN15c3yImP7	As It Was	90	6	167303	4	0.52	0.731	-5.338	0	0.0557	0.311	0.662	173.93	0.00101	0.342
1BuZAIO8WZpavWVbbq3Lci	Powerglide (feat. Juicy J) - From SR3MM	66	1	332301	4	0.713	0.831	-4.75	0	0.15	0.118	0.584	173.948	0	0.0168
3iH29NcCxYgI5shlkZrUoB	gone girl	67	11	136568	4	0.677	0.714	-5.637	1	0.0287	0.0717	0.355	94.956	0	0.162
5hc71nKsUgtwQ3z52KEKQk	Somebody Else	73	0	347520	4	0.61	0.788	-5.724	1	0.0585	0.153	0.472	101.045	0.0142	0.195
1EAgPzRbK9YmdOESSMUm6P	Home	73	0	210173	4	0.606	0.826	-6.04	1	0.0307	0.117	0.322	121.04	1.56e-05	0.0256
2TUzU4IkfH8kcvY2MUlsd2	I Won't Let You Go	65	0	229303	4	0.537	0.611	-6.427	1	0.0304	0.146	0.161	105.955	0	0.229
4r6eNCsrZnQWJzzvFh4nlg	Firework	73	8	227893	4	0.638	0.832	-5.039	1	0.049	0.113	0.648	124.071	0	0.141
2ygvZOXrIeVL4xZmAWJT2C	my future	73	8	208155	4	0.444	0.309	-10.956	1	0.062	0.352	0.0875	104.745	0.132	0.795
5CZ40GBx1sQ9agT82CLQCT	traitor	88	3	229227	4	0.38	0.339	-7.885	1	0.0338	0.12	0.0849	100.607	0	0.691
4cluDES4hQEUhmXj6TXkSo	What Makes You Beautiful	86	4	199987	4	0.726	0.787	-2.494	1	0.0737	0.0596	0.888	124.99	0	0.009
1f8UCzB3RqIgNkW7QIiIeP	Heart Skips a Beat (feat. Rizzle Kicks)	63	9	202267	4	0.843	0.881	-3.951	1	0.0581	0.0765	0.876	110.621	0	0.14
5E6CDAxnBqc9V9Y6t5wTUE	Mr. Saxobeat - Radio Edit	63	11	195105	4	0.732	0.925	-4.165	0	0.051	0.14	0.782	127.012	0.000238	0.0276
4pi1G1x8tl9VfdD9bL3maT	Big Energy	69	11	172540	4	0.937	0.793	-4.431	0	0.115	0.341	0.794	106.022	0	0.0453
5GBuCHuPKx6UC7VsSPK0t3	Thotiana	66	10	129264	4	0.906	0.382	-12.89	0	0.269	0.113	0.391	104.025	0	0.18
2KukL7UlQ8TdvpaA7bY3ZJ	BREAK MY SOUL	72	1	278282	4	0.687	0.887	-5.04	0	0.0826	0.27	0.853	114.941	2.21e-06	0.0575
1HNkqx9Ahdgi1Ixy2xkKkL	Photograph	87	4	258987	4	0.614	0.379	-10.48	1	0.0476	0.0986	0.201	107.989	0.000464	0.607
1Cv1YLb4q0RzL6pybtaMLo	Sunday Best	77	5	158571	4	0.878	0.525	-6.832	1	0.0578	0.0714	0.694	112.022	0	0.183
0ZyfiFudK9Si2n2G9RkiWj	Ride	66	0	289080	4	0.373	0.686	-5.52	1	0.034	0.383	0.189	93.763	1.96e-06	0.128
5wEreUfwxZxWnEol61ulIi	Born To Die	69	4	286253	4	0.393	0.634	-6.629	0	0.0378	0.198	0.395	85.767	0.000166	0.2
4dTaAiV9xFFCxnPur9c9yL	Memories (feat. Kid Cudi)	70	8	210093	4	0.561	0.87	-6.103	1	0.343	0.246	0.498	129.98	2.82e-06	0.0015
030OCtLMrljNhp8OWHBWW3	Hey Daddy (Daddy's Home)	67	11	224093	4	0.59	0.698	-4.262	1	0.0286	0.107	0.352	95.975	0	0.000176
2ixsaeFioXJmMgkkbd4uj1	Budapest	82	5	200733	4	0.717	0.455	-8.303	1	0.0276	0.11	0.389	127.812	0	0.0846
67BtfxlNbhBmCDR2L2l8qd	MONTERO (Call Me By Your Name)	76	8	137876	4	0.61	0.508	-6.682	0	0.152	0.384	0.758	178.818	0	0.297
1BxfuPKGuaTgP7aM0Bbdwr	Cruel Summer	100	9	178427	4	0.552	0.702	-5.707	1	0.157	0.105	0.564	169.994	2.06e-05	0.117
7hR5toSPEgwFZ78jfHdANM	Half of My Heart	67	5	250373	4	0.681	0.593	-9.327	1	0.0251	0.106	0.731	115.058	0.000117	0.435
1qEmFfgcLObUfQm0j1W2CK	Late Night Talking	87	10	177955	4	0.714	0.728	-4.595	1	0.0468	0.106	0.901	114.996	0	0.298
5vL0yvddknhGj7IrBc6UTj	This Is How We Do	60	9	204285	4	0.69	0.636	-6.028	0	0.0457	0.147	0.8	96	0	0.0203
2xLMifQCjDGFmkHkpNLD9h	SICKO MODE	86	8	312820	4	0.834	0.73	-3.714	1	0.222	0.124	0.446	155.008	0	0.00513
3LtpKP5abr2qqjunvjlX5i	Doja	86	6	97393	4	0.911	0.573	-7.43	1	0.288	0.403	0.972	140.04	0	0.38
0ARKW62l9uWIDYMZTUmJHF	Shut Down	76	0	175889	3	0.82	0.686	-5.102	1	0.038	0.184	0.668	110.058	0	0.00412
3RiPr603aXAoi4GHyXx0uy	Hymn for the Weekend	85	0	258267	4	0.491	0.693	-6.487	0	0.0377	0.325	0.412	90.027	6.92e-06	0.211
1rDQ4oMwGJI7B4tovsBOxc	First Class	24	8	173948	4	0.905	0.563	-6.135	1	0.102	0.113	0.324	106.998	9.71e-06	0.0254
6RRNNciQGZEXnqk8SQ9yv5	You Need To Calm Down	84	2	171360	4	0.771	0.671	-5.617	1	0.0553	0.0637	0.714	85.026	0	0.00929
5sra5UY6sD658OabHL3QtI	Empire State of Mind (Part II) Broken Down	73	6	216480	4	0.484	0.368	-7.784	1	0.0341	0.118	0.142	92.923	3.82e-05	0.74
1PSBzsahR2AKwLJgx8ehBj	Bad Things (with Camila Cabello)	73	2	239293	4	0.697	0.691	-4.757	1	0.146	0.185	0.305	137.853	0	0.214
1r3myKmjWoOqRip99CmSj1	Don't Wanna Go Home	64	2	206080	4	0.671	0.808	-4.861	0	0.0652	0.134	0.637	121.956	0	0.02
7eJMfftS33KTjuF7lTsMCx	death bed (coffee for your head)	83	8	173333	4	0.726	0.431	-8.765	0	0.135	0.696	0.348	144.026	0	0.731
6HZ9VeI5IRFCNQLXhpF4bq	I Love It (feat. Charli XCX)	73	8	157153	4	0.711	0.906	-2.671	1	0.0284	0.153	0.824	125.916	1.64e-05	0.00952
1c8gk2PeTE04A1pIDH9YMk	Rolling in the Deep	82	8	228093	4	0.73	0.769	-5.114	1	0.0298	0.0473	0.507	104.948	0	0.138
5ZFVacinyPxz19eK2vTodL	Miami 2 Ibiza - Swedish House Mafia vs. Tinie Tempah	48	7	206461	4	0.736	0.929	-5.89	0	0.0674	0.402	0.658	125.03	1.11e-05	0.00237
1yK9LISg5uBOOW5bT2Wm0i	Try Sleeping with a Broken Heart	63	5	249013	5	0.496	0.821	-5.155	1	0.112	0.13	0.549	110.977	0.246	0.158
3TGRqZ0a2l1LRblBkJoaDx	Call Me Maybe	76	7	193400	4	0.783	0.58	-6.548	1	0.0408	0.108	0.66	120.021	2.28e-06	0.0114
7dt6x5M1jzdTEt8oCbisTK	Better Now	83	10	231267	4	0.68	0.578	-5.804	1	0.04	0.135	0.341	145.038	0	0.331
\.


--
-- TOC entry 4716 (class 2606 OID 76690)
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (album_id);


--
-- TOC entry 4712 (class 2606 OID 76676)
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (artist_id);


--
-- TOC entry 4718 (class 2606 OID 76697)
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- TOC entry 4714 (class 2606 OID 76683)
-- Name: playlists playlists_pkey; Type: CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.playlists
    ADD CONSTRAINT playlists_pkey PRIMARY KEY (playlist_id);


--
-- TOC entry 4710 (class 2606 OID 76669)
-- Name: tracks tracks_pkey; Type: CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.tracks
    ADD CONSTRAINT tracks_pkey PRIMARY KEY (track_id);


--
-- TOC entry 4706 (class 2606 OID 75948)
-- Name: album_tracks album_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_tracks
    ADD CONSTRAINT album_tracks_pkey PRIMARY KEY (album_id, track_id);


--
-- TOC entry 4702 (class 2606 OID 75924)
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (album_id);


--
-- TOC entry 4704 (class 2606 OID 75931)
-- Name: artist_genres artist_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artist_genres
    ADD CONSTRAINT artist_genres_pkey PRIMARY KEY (artist_id, genre_id);


--
-- TOC entry 4696 (class 2606 OID 75893)
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (artist_id);


--
-- TOC entry 4700 (class 2606 OID 75917)
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- TOC entry 4698 (class 2606 OID 75900)
-- Name: playlist_tracks playlist_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT playlist_tracks_pkey PRIMARY KEY (playlist_id, track_id);


--
-- TOC entry 4692 (class 2606 OID 75879)
-- Name: playlists playlists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlists
    ADD CONSTRAINT playlists_pkey PRIMARY KEY (playlist_id);


--
-- TOC entry 4708 (class 2606 OID 75965)
-- Name: track_artists track_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.track_artists
    ADD CONSTRAINT track_artists_pkey PRIMARY KEY (track_id, artist_id);


--
-- TOC entry 4694 (class 2606 OID 75886)
-- Name: tracks tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracks
    ADD CONSTRAINT tracks_pkey PRIMARY KEY (track_id);


--
-- TOC entry 4730 (class 2606 OID 76733)
-- Name: artists artist_genre_fk; Type: FK CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.artists
    ADD CONSTRAINT artist_genre_fk FOREIGN KEY (genre_id) REFERENCES denormalized_model.genres(genre_id);


--
-- TOC entry 4727 (class 2606 OID 76718)
-- Name: tracks track_album_fk; Type: FK CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.tracks
    ADD CONSTRAINT track_album_fk FOREIGN KEY (album_id) REFERENCES denormalized_model.albums(album_id);


--
-- TOC entry 4728 (class 2606 OID 76723)
-- Name: tracks track_artist_fk; Type: FK CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.tracks
    ADD CONSTRAINT track_artist_fk FOREIGN KEY (artist_id) REFERENCES denormalized_model.artists(artist_id);


--
-- TOC entry 4729 (class 2606 OID 76728)
-- Name: tracks track_playlist_fk; Type: FK CONSTRAINT; Schema: denormalized_model; Owner: postgres
--

ALTER TABLE ONLY denormalized_model.tracks
    ADD CONSTRAINT track_playlist_fk FOREIGN KEY (playlist_id) REFERENCES denormalized_model.playlists(playlist_id);


--
-- TOC entry 4723 (class 2606 OID 75949)
-- Name: album_tracks album_tracks_album_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_tracks
    ADD CONSTRAINT album_tracks_album_id_fkey FOREIGN KEY (album_id) REFERENCES public.albums(album_id);


--
-- TOC entry 4724 (class 2606 OID 75954)
-- Name: album_tracks album_tracks_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.album_tracks
    ADD CONSTRAINT album_tracks_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.tracks(track_id);


--
-- TOC entry 4721 (class 2606 OID 75932)
-- Name: artist_genres artist_genres_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artist_genres
    ADD CONSTRAINT artist_genres_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artists(artist_id);


--
-- TOC entry 4722 (class 2606 OID 75937)
-- Name: artist_genres artist_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artist_genres
    ADD CONSTRAINT artist_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id);


--
-- TOC entry 4719 (class 2606 OID 75901)
-- Name: playlist_tracks playlist_tracks_playlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT playlist_tracks_playlist_id_fkey FOREIGN KEY (playlist_id) REFERENCES public.playlists(playlist_id);


--
-- TOC entry 4720 (class 2606 OID 75906)
-- Name: playlist_tracks playlist_tracks_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playlist_tracks
    ADD CONSTRAINT playlist_tracks_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.tracks(track_id);


--
-- TOC entry 4725 (class 2606 OID 75971)
-- Name: track_artists track_artists_artist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.track_artists
    ADD CONSTRAINT track_artists_artist_id_fkey FOREIGN KEY (artist_id) REFERENCES public.artists(artist_id);


--
-- TOC entry 4726 (class 2606 OID 75966)
-- Name: track_artists track_artists_track_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.track_artists
    ADD CONSTRAINT track_artists_track_id_fkey FOREIGN KEY (track_id) REFERENCES public.tracks(track_id);


-- Completed on 2024-04-04 08:42:48

--
-- PostgreSQL database dump complete
--

