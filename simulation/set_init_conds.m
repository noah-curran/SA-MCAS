% The initial conditions file serves as an interface between MATLAB and
% JSBSim. Ideally the interface wouldn't rely on paging this data to a
% file, but this works.

function set_init_conds(altitude, vc, latitude, longitude, pitch, roll, heading)
%% Open File
init_cond_file = fopen("aircraft/737/init_auto.xml", "W");

newlineFormatSpec = "\n";

%% Header Lines
fwrite(init_cond_file, '<?xml version="1.0" encoding="utf-8"?>');
fprintf(init_cond_file, newlineFormatSpec);
fwrite(init_cond_file, '<initialize name="init_auto">');
fprintf(init_cond_file, newlineFormatSpec);

%% Print property lines
altitude_tags = ["altitude", "FT", altitude, "altitude"];
vc_tags = ["vc", "KTS", vc, "vc"];
latitude_tags = ["latitude", "DEG", latitude, "latitude"];
longitude_tags = ["longitude", "DEG", longitude, "longitude"];
theta_tags = ["theta", "DEG", pitch, "theta"]; % pitch
phi_tags = ["phi", "DEG", roll, "phi"];   % roll
psi_tags = ["psi", "DEG", heading, "psi"];   % heading
propertyFormatSpec = '\t<%s unit="%s">%s</%s>\n';
fprintf(init_cond_file, propertyFormatSpec, altitude_tags, vc_tags, latitude_tags, longitude_tags, theta_tags, phi_tags, psi_tags);

%% Bottom Header
fwrite(init_cond_file, '</initialize>');
fprintf(init_cond_file, newlineFormatSpec);

%% Close file
fclose(init_cond_file);
end % function