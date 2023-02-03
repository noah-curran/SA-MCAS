function set_init_conds(altitude, vc, latitude, longitude, pitch, roll, heading)
init_cond_file = fopen("aircraft/737-RTCL/init_auto.xml", "W");
newlineFormatSpec = "\n";
propertyFormatSpec = '\t<%s unit="%s">%s</%s>\n';

% Header
fwrite(init_cond_file, '<?xml version="1.0" encoding="utf-8"?>');
fprintf(init_cond_file, newlineFormatSpec);
fwrite(init_cond_file, '<initialize name="init_auto">');
fprintf(init_cond_file, newlineFormatSpec);

% Properties
altitude_tags = ["altitude", "FT", altitude, "altitude"];
vc_tags = ["vc", "KTS", vc, "vc"];
latitude_tags = ["latitude", "DEG", latitude, "latitude"];
longitude_tags = ["longitude", "DEG", longitude, "longitude"];
theta_tags = ["theta", "DEG", pitch, "theta"];
phi_tags = ["phi", "DEG", roll, "phi"];
psi_tags = ["psi", "DEG", heading, "psi"];
fprintf(init_cond_file, propertyFormatSpec, altitude_tags, vc_tags, latitude_tags, longitude_tags, theta_tags, phi_tags, psi_tags);

% Footer
fwrite(init_cond_file, '</initialize>');
fprintf(init_cond_file, newlineFormatSpec);

fclose(init_cond_file);
end % function
