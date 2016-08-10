#ifdef __ROOTCLING__
#define ROOT_PARSER
#elif __CINT__
#define ROOT_PARSER
#endif

#ifdef ROOT_PARSER

#pragma link off all globals;
#pragma link off all classes;


#pragma link C++ namespace     WaveCalType;
#pragma link C++ enum          WaveCalType::EWaveCalType;
#pragma link C++ nestedtypedef WaveCalType::WaveCalType_t;

#pragma link C++ namespace     AnitaRing;
#pragma link C++ enum          AnitaRing::EAnitaRing;
#pragma link C++ nestedtypedef AnitaRing::AnitaRing_t;

#pragma link C++ namespace     AnitaBand;
#pragma link C++ enum          AnitaBand::EAnitaBand;
#pragma link C++ nestedtypedef AnitaBand::AnitaBand_t;

#pragma link C++ namespace     AnitaPol;
#pragma link C++ enum          AnitaPol::EAnitaPol;
#pragma link C++ nestedtypedef AnitaPol::AnitaPol_t;

#pragma link C++ namespace     AnitaLocations;
#pragma link C++ namespace     AnitaCompress;


#pragma link C++ class GenericHeader_t+;
#pragma link C++ class AnitaGeomTool+;
#pragma link C++ class RawAnitaEvent+;
#pragma link C++ class RawAnitaHeader+;
#pragma link C++ class TimedAnitaHeader+;
#pragma link C++ class UsefulAnitaEvent+;
#pragma link C++ class CalibratedAnitaEvent+;
#pragma link C++ class Adu5Pat+;
#pragma link C++ class Adu5Vtg+;
#pragma link C++ class G12Pos+;
#pragma link C++ class G12Sat+;
#pragma link C++ class GpsGga+;
#pragma link C++ class Adu5Sat+;
#pragma link C++ class AnitaEventCalibrator+;
#pragma link C++ class PrettyAnitaHk+;
#pragma link C++ class SurfHk+;
#pragma link C++ class AveragedSurfHk+;
#pragma link C++ class TurfRate+;
#pragma link C++ class SummedTurfRate+;
#pragma link C++ class AcqdStart+;
#pragma link C++ class GpsdStart+;
#pragma link C++ class MonitorHk+;
#pragma link C++ class LogWatchdStart+;
#pragma link C++ class RunStart+;
#pragma link C++ class CommandEcho+;
#pragma link C++ class OtherMonitorHk+;
#pragma link C++ class RawHk+;
#pragma link C++ class CalibratedHk+;
#pragma link C++ class RawSSHk+;
#pragma link C++ class CalibratedSSHk+;
#pragma link C++ class SlowRate+;
#pragma link C++ class GpuPowerSpectra+;
#pragma link C++ class AnitaDataset+;
#pragma link C++ class RTLSpectrum+; 

#else
#error "for compilation"
#endif

