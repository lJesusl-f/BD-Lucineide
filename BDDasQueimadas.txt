-- Bioma
CREATE TABLE IF NOT EXISTS tbBioma( 
 idBioma INT PRIMARY KEY,  
 areaAtingida VARCHAR(100),  
 nomeBioma VARCHAR(100) 
); 

-- Satélite
CREATE TABLE IF NOT EXISTS tbSatelite( 
 idSatelite INT PRIMARY KEY,  
 nomesSatelite VARCHAR(100) 
); 

-- Alerta
CREATE TABLE IF NOT EXISTS tbAlerta( 
 idAlerta INT PRIMARY KEY,  
 nivelAlerta INT 
); 

-- Usuário
CREATE TABLE IF NOT EXISTS tbUser( 
 idUser INT PRIMARY KEY,  
 nomeUser VARCHAR(200),  
 ContatoUser VARCHAR(200) 
); 

-- Queimada
CREATE TABLE IF NOT EXISTS tbQueimada( 
 idFogo INT PRIMARY KEY,  
 data TIMESTAMP,  
 lat_lon VARCHAR(200)
); 

-- Localizações (CEP)
CREATE TABLE IF NOT EXISTS tbCEP( 
 idLoc INT PRIMARY KEY,  
 estado VARCHAR(100),  
 cidade VARCHAR(200) 
); 

-- Onde aconteceu/ocorreu
CREATE TABLE IF NOT EXISTS tbOnde (
  idOnde INT,
  idBioma INT,
  idLoc INT,
  idFogo INT,
  PRIMARY KEY (idOnde),
  FOREIGN KEY (idBioma) REFERENCES tbBioma(idBioma),
  FOREIGN KEY (idLoc) REFERENCES tbCEP(idLoc),
  FOREIGN KEY (idFogo) REFERENCES tbQueimada(idFogo)
);

-- Observações por stélite
CREATE TABLE IF NOT EXISTS tbObserva (
  idObs INT PRIMARY KEY,
  idFogo INT,
  idSatelite INT,
  CONSTRAINT fk_obs_fogo FOREIGN KEY (idFogo) REFERENCES tbQueimada(idFogo),
  CONSTRAINT fk_obs_satelite FOREIGN KEY (idSatelite) REFERENCES tbSatelite(idSatelite)
);

-- Dados Coletados
CREATE TABLE IF NOT EXISTS tbDados (
  idDado INT PRIMARY KEY,
  conteudoDado VARCHAR(200),
  idAlerta INT,
  idSatelite INT,
  CONSTRAINT fk_dado_alerta FOREIGN KEY (idAlerta) REFERENCES tbAlerta(idAlerta),
  CONSTRAINT fk_dado_satelite FOREIGN KEY (idSatelite) REFERENCES tbSatelite(idSatelite)
);

-- Mensagens
CREATE TABLE IF NOT EXISTS tbMensagem (
  idMsg INT PRIMARY KEY,
  textoMsg VARCHAR(300),
  idAlerta INT,
  idUser INT,
  CONSTRAINT fk_msg_alerta FOREIGN KEY (idAlerta) REFERENCES tbAlerta(idAlerta),
  CONSTRAINT fk_msg_user FOREIGN KEY (idUser) REFERENCES tbUser(idUser)
);