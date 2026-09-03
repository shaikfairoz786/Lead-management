-- ============================================================================
-- AUTOMOTIVE LMS: BULK DATABASE SEED SQL SCRIPT
-- 1. 53 Real-World Used Vehicles (Toyota, Mahindra, Tata, Hyundai, Maruti, Kia, Ashok Leyland, etc.)
-- 2. 105 Customers with unique contacts
-- 3. 105 Customer Lead Requirements across All Pipeline Stages
-- 4. Initial Match Calculations & Follow-ups
-- ============================================================================

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Clean existing operational data to avoid unique constraint collisions
DELETE FROM "CommunicationLog";
DELETE FROM "LeadActivity";
DELETE FROM "FollowUp";
DELETE FROM "VehicleMatch";
DELETE FROM "VehicleImage";
DELETE FROM "Vehicle";
DELETE FROM "CustomerRequirement";
DELETE FROM "Customer";

-- ============================================================================
-- 1. INSERT 53 VEHICLES INTO INVENTORY ("Vehicle" & "VehicleImage")
-- ============================================================================

INSERT INTO "Vehicle" (
  "id", "make", "model", "variant", "category", "vehicleType", "manufacturingYear", 
  "registrationYear", "fuelType", "transmission", "kmDriven", "numberOfOwners", 
  "color", "price", "location", "description", "status", "registrationNumber", 
  "externalVehicleId", "publicVehicleUrl", "bodyType", "payloadCapacityKg", "numberOfWheels", 
  "source", "createdAt", "updatedAt"
) VALUES
-- Toyota
('a0000001-0000-0000-0000-000000000001', 'Toyota', 'Innova Crysta', '2.4 GX 7 STR Diesel', 'PASSENGER', 'MPV', 2021, 2021, 'DIESEL', 'MANUAL', 48000, 1, 'Super White', 1850000, 'Bangalore - Indiranagar', 'Certified showroom stock with 140-point inspection.', 'AVAILABLE', 'KA-01-AB-1234', 'EXT-TOY-001', 'https://marketplace.autodealer.com/inventory/toyota-innova-crysta-2021', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000002', 'Toyota', 'Innova Crysta', '2.8 ZX AT Diesel', 'PASSENGER', 'MPV', 2019, 2019, 'DIESEL', 'AUTOMATIC', 62000, 1, 'Garnet Red', 2150000, 'Bangalore - Koramangala', 'Top-end ZX automatic captain seats.', 'AVAILABLE', 'KA-03-CD-5678', 'EXT-TOY-002', 'https://marketplace.autodealer.com/inventory/toyota-innova-crysta-2019', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000003', 'Toyota', 'Fortuner', '2.8 4x4 AT Diesel', 'PASSENGER', 'SUV', 2022, 2022, 'DIESEL', 'AUTOMATIC', 28000, 1, 'Attitude Black', 3750000, 'Bangalore - Whitefield', 'Full 4x4 capability, premium leather interior.', 'AVAILABLE', 'KA-04-EF-9012', 'EXT-TOY-003', 'https://marketplace.autodealer.com/inventory/toyota-fortuner-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000004', 'Toyota', 'Fortuner Legender', '4x2 AT Diesel', 'PASSENGER', 'SUV', 2023, 2023, 'DIESEL', 'AUTOMATIC', 14000, 1, 'White Pearl Dual Tone', 4350000, 'Mumbai - Andheri', 'Single owner, pristine showroom condition.', 'AVAILABLE', 'MH-02-GH-3456', 'EXT-TOY-004', 'https://marketplace.autodealer.com/inventory/toyota-fortuner-legender-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000005', 'Toyota', 'Urban Cruiser Hyryder', 'V Strong Hybrid AT', 'PASSENGER', 'SUV', 2023, 2023, 'HYBRID', 'AUTOMATIC', 11000, 1, 'Cafe White', 1980000, 'Delhi - South Ex', 'High efficiency hybrid with panoramic roof.', 'AVAILABLE', 'DL-01-IJ-7890', 'EXT-TOY-005', 'https://marketplace.autodealer.com/inventory/toyota-hyryder-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000006', 'Toyota', 'Glanza', 'G Petrol MT', 'PASSENGER', 'Hatchback', 2022, 2022, 'PETROL', 'MANUAL', 21000, 1, 'Gaming Grey', 790000, 'Bangalore - Indiranagar', 'Fuel efficient city car with full service record.', 'AVAILABLE', 'KA-01-KL-1122', 'EXT-TOY-006', 'https://marketplace.autodealer.com/inventory/toyota-glanza-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),

-- Mahindra
('a0000001-0000-0000-0000-000000000007', 'Mahindra', 'Thar', 'LX 4x4 Hard Top Diesel AT', 'PASSENGER', 'SUV', 2022, 2022, 'DIESEL', 'AUTOMATIC', 24000, 1, 'Napoli Black', 1620000, 'Bangalore - Whitefield', 'Iconic off-roader with automatic transmission.', 'AVAILABLE', 'KA-53-MN-3344', 'EXT-MAH-001', 'https://marketplace.autodealer.com/inventory/mahindra-thar-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000008', 'Mahindra', 'Thar', 'AX Opt 4x4 Soft Top Diesel', 'PASSENGER', 'SUV', 2021, 2021, 'DIESEL', 'MANUAL', 38000, 1, 'Red Rage', 1380000, 'Hyderabad - Gachibowli', 'Manual 4x4 diesel off-road ready.', 'AVAILABLE', 'TS-09-OP-5566', 'EXT-MAH-002', 'https://marketplace.autodealer.com/inventory/mahindra-thar-2021', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000009', 'Mahindra', 'XUV700', 'AX7 L AWD Diesel AT', 'PASSENGER', 'SUV', 2023, 2023, 'DIESEL', 'AUTOMATIC', 19000, 1, 'Midnight Black', 2450000, 'Bangalore - Koramangala', 'Top-end luxury AWD with ADAS and Sony 3D audio.', 'AVAILABLE', 'KA-05-QR-7788', 'EXT-MAH-003', 'https://marketplace.autodealer.com/inventory/mahindra-xuv700-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000010', 'Mahindra', 'XUV700', 'AX5 Petrol MT 7 STR', 'PASSENGER', 'SUV', 2022, 2022, 'PETROL', 'MANUAL', 29000, 1, 'Dazzling Silver', 1850000, 'Pune - Baner', '7 Seater petrol with panoramic skyroof.', 'AVAILABLE', 'MH-12-ST-9900', 'EXT-MAH-004', 'https://marketplace.autodealer.com/inventory/mahindra-xuv700-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000011', 'Mahindra', 'Scorpio-N', 'Z8 L 4WD Diesel AT', 'PASSENGER', 'SUV', 2023, 2023, 'DIESEL', 'AUTOMATIC', 16000, 1, 'Deep Forest', 2380000, 'Delhi - Karol Bagh', 'Big Daddy of SUVs with 4xplor terrain system.', 'AVAILABLE', 'DL-04-UV-1212', 'EXT-MAH-005', 'https://marketplace.autodealer.com/inventory/mahindra-scorpio-n-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000012', 'Mahindra', 'Scorpio Classic', 'S11 Diesel MT', 'PASSENGER', 'SUV', 2022, 2022, 'DIESEL', 'MANUAL', 34000, 1, 'Pearl White', 1690000, 'Bangalore - Indiranagar', 'Rugged, reliable classic SUV with mHawk engine.', 'AVAILABLE', 'KA-01-WX-3434', 'EXT-MAH-006', 'https://marketplace.autodealer.com/inventory/mahindra-scorpio-classic-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000013', 'Mahindra', 'Bolero Neo', 'N10 Diesel', 'PASSENGER', 'SUV', 2022, 2022, 'DIESEL', 'MANUAL', 41000, 1, 'Rocky Beige', 950000, 'Chennai - Guindy', 'Compact SUV with tough ladder frame chassis.', 'AVAILABLE', 'TN-01-YZ-5656', 'EXT-MAH-007', 'https://marketplace.autodealer.com/inventory/mahindra-bolero-neo-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000014', 'Mahindra', 'Bolero', 'B6 Opt Diesel', 'PASSENGER', 'MUV', 2021, 2021, 'DIESEL', 'MANUAL', 55000, 1, 'Diamond White', 820000, 'Hyderabad - Secunderabad', 'India trusted utility vehicle.', 'AVAILABLE', 'TS-08-AA-7878', 'EXT-MAH-008', 'https://marketplace.autodealer.com/inventory/mahindra-bolero-2021', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),

-- Tata Passenger & Commercial
('a0000001-0000-0000-0000-000000000015', 'Tata', 'Nexon', 'Creative Plus Diesel AMT', 'PASSENGER', 'Compact SUV', 2023, 2023, 'DIESEL', 'AUTOMATIC', 12000, 1, 'Daytona Grey', 1350000, 'Bangalore - Indiranagar', '5-star safety rated compact diesel SUV.', 'AVAILABLE', 'KA-03-BB-9090', 'EXT-TAT-001', 'https://marketplace.autodealer.com/inventory/tata-nexon-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000016', 'Tata', 'Nexon EV', 'Max Empowered Plus', 'PASSENGER', 'Electric SUV', 2023, 2023, 'ELECTRIC', 'AUTOMATIC', 15000, 1, 'Pristine White', 1590000, 'Bangalore - Whitefield', '437km range EV with fast charging support.', 'AVAILABLE', 'KA-04-CC-1313', 'EXT-TAT-002', 'https://marketplace.autodealer.com/inventory/tata-nexon-ev-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000017', 'Tata', 'Harrier', 'XZA Plus Dark Edition AT', 'PASSENGER', 'SUV', 2022, 2022, 'DIESEL', 'AUTOMATIC', 31000, 1, 'Oberon Black', 2050000, 'Mumbai - BKC', 'Dark edition with Kryotec 170PS diesel engine.', 'AVAILABLE', 'MH-01-DD-2424', 'EXT-TAT-003', 'https://marketplace.autodealer.com/inventory/tata-harrier-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000018', 'Tata', 'Safari', 'Accomplished Plus 6S AT', 'PASSENGER', 'SUV', 2023, 2023, 'DIESEL', 'AUTOMATIC', 17000, 1, 'Cosmic Gold', 2480000, 'Delhi - Vasant Kunj', '6-seater captain seats with ventilated front seats.', 'AVAILABLE', 'DL-03-EE-3535', 'EXT-TAT-004', 'https://marketplace.autodealer.com/inventory/tata-safari-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000019', 'Tata', 'Punch', 'Accomplished Dazzle Petrol', 'PASSENGER', 'Micro SUV', 2022, 2022, 'PETROL', 'MANUAL', 26000, 1, 'Tornado Blue', 740000, 'Bangalore - Koramangala', 'High ground clearance micro SUV.', 'AVAILABLE', 'KA-05-FF-4646', 'EXT-TAT-005', 'https://marketplace.autodealer.com/inventory/tata-punch-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000020', 'Tata', 'Altroz', 'XZ Plus i-Turbo Petrol', 'PASSENGER', 'Hatchback', 2022, 2022, 'PETROL', 'MANUAL', 28000, 1, 'Downtown Red', 810000, 'Pune - Kothrud', 'Gold standard hatchback with turbo power.', 'AVAILABLE', 'MH-14-GG-5757', 'EXT-TAT-006', 'https://marketplace.autodealer.com/inventory/tata-altroz-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000021', 'Tata', 'Ace Gold', 'Diesel Plus BS6', 'COMMERCIAL', 'Mini Truck', 2022, 2022, 'DIESEL', 'MANUAL', 39000, 1, 'Arctic White', 460000, 'Bangalore - Peenya', 'Chota Hathi mini truck for city logistics.', 'AVAILABLE', 'KA-02-HH-6868', 'EXT-TAT-007', 'https://marketplace.autodealer.com/inventory/tata-ace-gold-2022', 'OPEN_CONTAINER', 750, 4, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000022', 'Tata', 'Ace Gold', 'CNG Plus High Deck', 'COMMERCIAL', 'Mini Truck', 2023, 2023, 'CNG', 'MANUAL', 22000, 1, 'Polar White', 530000, 'Delhi - Okhla', 'Factory CNG mini truck with high deck container.', 'AVAILABLE', 'DL-06-II-7979', 'EXT-TAT-008', 'https://marketplace.autodealer.com/inventory/tata-ace-cng-2023', 'HIGH_DECK', 650, 4, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000023', 'Tata', 'Intra V30', 'Smart Pickup Diesel', 'COMMERCIAL', 'Pickup Truck', 2022, 2022, 'DIESEL', 'MANUAL', 45000, 1, 'Pure White', 680000, 'Mumbai - Navi Mumbai', '1.3 Ton payload high torque pickup.', 'AVAILABLE', 'MH-43-JJ-8080', 'EXT-TAT-009', 'https://marketplace.autodealer.com/inventory/tata-intra-v30-2022', 'FLATBED', 1300, 4, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000024', 'Tata', 'Yodha', '1700 Single Cab Diesel', 'COMMERCIAL', 'Heavy Pickup', 2021, 2021, 'DIESEL', 'MANUAL', 58000, 1, 'Signal White', 790000, 'Hyderabad - Uppal', 'Heavy duty 1.7T capacity commercial pickup.', 'AVAILABLE', 'TS-10-KK-9191', 'EXT-TAT-010', 'https://marketplace.autodealer.com/inventory/tata-yodha-2021', 'OPEN_CONTAINER', 1700, 4, 'DIRECT_INVENTORY', NOW(), NOW()),

-- Hyundai
('a0000001-0000-0000-0000-000000000025', 'Hyundai', 'Creta', 'SX (O) 1.5 Diesel AT', 'PASSENGER', 'SUV', 2022, 2022, 'DIESEL', 'AUTOMATIC', 32000, 1, 'Phantom Black', 1780000, 'Bangalore - Indiranagar', 'Feature-packed diesel automatic with Bose sound.', 'AVAILABLE', 'KA-01-LL-1010', 'EXT-HYU-001', 'https://marketplace.autodealer.com/inventory/hyundai-creta-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000026', 'Hyundai', 'Creta', 'EX 1.5 Petrol MT', 'PASSENGER', 'SUV', 2021, 2021, 'PETROL', 'MANUAL', 41000, 1, 'Polar White', 1240000, 'Bangalore - Whitefield', 'Smooth petrol manual SUV.', 'AVAILABLE', 'KA-03-MM-2121', 'EXT-HYU-002', 'https://marketplace.autodealer.com/inventory/hyundai-creta-2021', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000027', 'Hyundai', 'Venue', 'SX Plus 1.0 Turbo DCT', 'PASSENGER', 'Compact SUV', 2022, 2022, 'PETROL', 'AUTOMATIC', 23000, 1, 'Titan Grey', 1120000, 'Chennai - Anna Nagar', 'Turbo automatic with dual tone interior.', 'AVAILABLE', 'TN-02-NN-3232', 'EXT-HYU-003', 'https://marketplace.autodealer.com/inventory/hyundai-venue-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000028', 'Hyundai', 'i20', 'Asta (O) 1.2 Petrol MT', 'PASSENGER', 'Hatchback', 2022, 2022, 'PETROL', 'MANUAL', 27000, 1, 'Fiery Red', 870000, 'Bangalore - Koramangala', 'Premium hatchback with digital cluster and sunroof.', 'AVAILABLE', 'KA-04-OO-4343', 'EXT-HYU-004', 'https://marketplace.autodealer.com/inventory/hyundai-i20-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000029', 'Hyundai', 'Verna', 'SX (O) 1.5 Turbo DCT', 'PASSENGER', 'Sedan', 2023, 2023, 'PETROL', 'AUTOMATIC', 14000, 1, 'Abyss Black', 1690000, 'Delhi - Connaught Place', '160PS fastback design with ADAS Level 2.', 'AVAILABLE', 'DL-02-PP-5454', 'EXT-HYU-005', 'https://marketplace.autodealer.com/inventory/hyundai-verna-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000030', 'Hyundai', 'Tucson', 'Signature 2.0 4WD Diesel AT', 'PASSENGER', 'Premium SUV', 2023, 2023, 'DIESEL', 'AUTOMATIC', 16000, 1, 'Amazon Grey', 3150000, 'Mumbai - Worli', 'Flagship luxury AWD SUV.', 'AVAILABLE', 'MH-01-QQ-6565', 'EXT-HYU-006', 'https://marketplace.autodealer.com/inventory/hyundai-tucson-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),

-- Maruti Suzuki
('a0000001-0000-0000-0000-000000000031', 'Maruti Suzuki', 'Swift', 'ZXi Plus Petrol MT', 'PASSENGER', 'Hatchback', 2022, 2022, 'PETROL', 'MANUAL', 24000, 1, 'Solid Fire Red', 760000, 'Bangalore - Indiranagar', 'High demand compact hatchback.', 'AVAILABLE', 'KA-01-RR-7676', 'EXT-MAR-001', 'https://marketplace.autodealer.com/inventory/maruti-swift-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000032', 'Maruti Suzuki', 'Baleno', 'Alpha Petrol AMT', 'PASSENGER', 'Hatchback', 2023, 2023, 'PETROL', 'AUTOMATIC', 15000, 1, 'Nexa Blue', 890000, 'Pune - Hinjewadi', 'Spacious cabin with 360-degree camera.', 'AVAILABLE', 'MH-14-SS-8787', 'EXT-MAR-002', 'https://marketplace.autodealer.com/inventory/maruti-baleno-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000033', 'Maruti Suzuki', 'Brezza', 'ZXi Plus AT', 'PASSENGER', 'Compact SUV', 2022, 2022, 'PETROL', 'AUTOMATIC', 21000, 1, 'Magma Grey Dual Tone', 1280000, 'Bangalore - Whitefield', 'Reliable family SUV with electric sunroof.', 'AVAILABLE', 'KA-53-TT-9898', 'EXT-MAR-003', 'https://marketplace.autodealer.com/inventory/maruti-brezza-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000034', 'Maruti Suzuki', 'Ertiga', 'ZXi CNG', 'PASSENGER', 'MPV', 2022, 2022, 'CNG', 'MANUAL', 38000, 1, 'Splendid Silver', 1150000, 'Delhi - Rohini', '7 Seater factory CNG with high mileage.', 'AVAILABLE', 'DL-08-UU-0909', 'EXT-MAR-004', 'https://marketplace.autodealer.com/inventory/maruti-ertiga-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000035', 'Maruti Suzuki', 'Grand Vitara', 'Alpha Plus Hybrid e-CVT', 'PASSENGER', 'SUV', 2023, 2023, 'HYBRID', 'AUTOMATIC', 12000, 1, 'Opulent Red', 1920000, 'Bangalore - Koramangala', 'Intelligent electric hybrid 27km/l.', 'AVAILABLE', 'KA-05-VV-2020', 'EXT-MAR-005', 'https://marketplace.autodealer.com/inventory/maruti-grand-vitara-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000036', 'Maruti Suzuki', 'Dzire', 'VXi CNG', 'PASSENGER', 'Sedan', 2022, 2022, 'CNG', 'MANUAL', 42000, 1, 'Arctic White', 780000, 'Hyderabad - Hitech City', 'Super economical compact sedan.', 'AVAILABLE', 'TS-07-WW-3131', 'EXT-MAR-006', 'https://marketplace.autodealer.com/inventory/maruti-dzire-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000037', 'Maruti Suzuki', 'Super Carry', 'CNG Cab Chassis', 'COMMERCIAL', 'Mini Truck', 2022, 2022, 'CNG', 'MANUAL', 33000, 1, 'Silky Silver', 440000, 'Bangalore - Peenya', 'Low running cost mini commercial carrier.', 'AVAILABLE', 'KA-02-XX-4242', 'EXT-MAR-007', 'https://marketplace.autodealer.com/inventory/maruti-super-carry-2022', 'FLATBED', 740, 4, 'DIRECT_INVENTORY', NOW(), NOW()),

-- Kia & Honda & Premium Sedans
('a0000001-0000-0000-0000-000000000038', 'Kia', 'Seltos', 'GTX Plus 1.5 Turbo DCT', 'PASSENGER', 'SUV', 2023, 2023, 'PETROL', 'AUTOMATIC', 11000, 1, 'Pewter Olive', 1980000, 'Bangalore - Indiranagar', 'Dual 10.25 inch curved display with ADAS.', 'AVAILABLE', 'KA-01-YY-5353', 'EXT-KIA-001', 'https://marketplace.autodealer.com/inventory/kia-seltos-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000039', 'Kia', 'Seltos', 'HTX 1.5 Diesel AT', 'PASSENGER', 'SUV', 2021, 2021, 'DIESEL', 'AUTOMATIC', 39000, 1, 'Gravity Grey', 1540000, 'Mumbai - Thane', 'Refined diesel automatic SUV.', 'AVAILABLE', 'MH-04-ZZ-6464', 'EXT-KIA-002', 'https://marketplace.autodealer.com/inventory/kia-seltos-2021', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000040', 'Kia', 'Sonet', 'HTX Plus 1.0 Turbo iMT', 'PASSENGER', 'Compact SUV', 2022, 2022, 'PETROL', 'AUTOMATIC', 24000, 1, 'Intense Red', 1160000, 'Chennai - T Nagar', 'Clutchless manual with Bose sound.', 'AVAILABLE', 'TN-07-AB-7575', 'EXT-KIA-003', 'https://marketplace.autodealer.com/inventory/kia-sonet-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000041', 'Kia', 'Carens', 'Luxury Plus 1.4 Turbo 6S', 'PASSENGER', 'MPV', 2022, 2022, 'PETROL', 'AUTOMATIC', 28000, 1, 'Imperial Blue', 1680000, 'Bangalore - Whitefield', '6-Seater luxury MPV with one-touch electric tumble.', 'AVAILABLE', 'KA-03-CD-8686', 'EXT-KIA-004', 'https://marketplace.autodealer.com/inventory/kia-carens-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000042', 'Honda', 'City', 'ZX CVT Petrol 5th Gen', 'PASSENGER', 'Sedan', 2022, 2022, 'PETROL', 'AUTOMATIC', 22000, 1, 'Golden Brown Metallic', 1390000, 'Bangalore - Koramangala', 'Legendary i-VTEC executive sedan.', 'AVAILABLE', 'KA-05-EF-9797', 'EXT-HON-001', 'https://marketplace.autodealer.com/inventory/honda-city-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000043', 'Honda', 'Amaze', 'VX CVT Petrol', 'PASSENGER', 'Compact Sedan', 2022, 2022, 'PETROL', 'AUTOMATIC', 19000, 1, 'Platinum White Pearl', 820000, 'Pune - Viman Nagar', 'Compact automatic sedan with paddle shifters.', 'AVAILABLE', 'MH-12-GH-0808', 'EXT-HON-002', 'https://marketplace.autodealer.com/inventory/honda-amaze-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000044', 'Honda', 'Elevate', 'ZX CVT Dual Tone', 'PASSENGER', 'SUV', 2023, 2023, 'PETROL', 'AUTOMATIC', 9000, 1, 'Phoenix Orange Pearl', 1570000, 'Delhi - Gurgaon', 'Brand new SUV with Honda Sensing ADAS.', 'AVAILABLE', 'DL-09-IJ-1919', 'EXT-HON-003', 'https://marketplace.autodealer.com/inventory/honda-elevate-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000045', 'MG', 'Hector', 'Sharp Pro 2.0 Diesel MT', 'PASSENGER', 'SUV', 2022, 2022, 'DIESEL', 'MANUAL', 31000, 1, 'Havana Grey', 1790000, 'Bangalore - Indiranagar', '14-inch HD portrait screen with infinity audio.', 'AVAILABLE', 'KA-01-KL-3030', 'EXT-MG-001', 'https://marketplace.autodealer.com/inventory/mg-hector-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000046', 'Skoda', 'Slavia', 'Style 1.5 TSI DSG', 'PASSENGER', 'Sedan', 2023, 2023, 'PETROL', 'AUTOMATIC', 14000, 1, 'Crystal Blue', 1680000, 'Mumbai - Bandra', 'German engineered 150PS sedan.', 'AVAILABLE', 'MH-02-MN-4141', 'EXT-SKO-001', 'https://marketplace.autodealer.com/inventory/skoda-slavia-2023', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000047', 'Volkswagen', 'Taigun', 'GT Plus 1.5 TSI DSG', 'PASSENGER', 'SUV', 2022, 2022, 'PETROL', 'AUTOMATIC', 23000, 1, 'Curcuma Yellow', 1650000, 'Bangalore - Koramangala', '5-Star Global NCAP safety rating.', 'AVAILABLE', 'KA-04-OP-5252', 'EXT-VW-001', 'https://marketplace.autodealer.com/inventory/vw-taigun-2022', NULL, NULL, NULL, 'DIRECT_INVENTORY', NOW(), NOW()),

-- Commercial Heavy LCVs
('a0000001-0000-0000-0000-000000000048', 'Ashok Leyland', 'Dost Plus', 'LS Diesel 1.5L', 'COMMERCIAL', 'LCV', 2022, 2022, 'DIESEL', 'MANUAL', 44000, 1, 'White', 690000, 'Bangalore - Peenya', '1.5T payload commercial champion.', 'AVAILABLE', 'KA-02-QR-6363', 'EXT-ASH-001', 'https://marketplace.autodealer.com/inventory/ashok-leyland-dost-2022', 'OPEN_CONTAINER', 1500, 4, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000049', 'Ashok Leyland', 'Bada Dost', 'i4 Diesel High Deck', 'COMMERCIAL', 'LCV', 2023, 2023, 'DIESEL', 'MANUAL', 28000, 1, 'Casablanca White', 890000, 'Chennai - Ambattur', '1.86 Ton payload high deck load carrier.', 'AVAILABLE', 'TN-05-ST-7474', 'EXT-ASH-002', 'https://marketplace.autodealer.com/inventory/ashok-leyland-bada-dost-2023', 'HIGH_DECK', 1860, 4, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000050', 'Eicher', 'Pro 2049', 'Diesel Container 10.5 Ft', 'COMMERCIAL', 'Light Truck', 2021, 2021, 'DIESEL', 'MANUAL', 64000, 1, 'Eicher Blue', 1180000, 'Mumbai - Bhiwandi', 'Closed container for FMCG distribution.', 'AVAILABLE', 'MH-43-UV-8585', 'EXT-EIC-001', 'https://marketplace.autodealer.com/inventory/eicher-pro-2049-2021', 'CLOSED_CONTAINER', 2400, 4, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000051', 'Force', 'Traveller 3350', '13 STR Luxury AC Diesel', 'COMMERCIAL', 'Van / Bus', 2022, 2022, 'DIESEL', 'MANUAL', 47000, 1, 'White', 1450000, 'Bangalore - Indiranagar', '13-seater executive tourer with recliners.', 'AVAILABLE', 'KA-01-WX-9696', 'EXT-FOR-001', 'https://marketplace.autodealer.com/inventory/force-traveller-2022', 'CLOSED_CONTAINER', 1600, 4, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000052', 'Isuzu', 'D-Max V-Cross', 'Z Prestige 4x4 AT', 'COMMERCIAL', 'Lifestyle Pickup', 2021, 2021, 'DIESEL', 'AUTOMATIC', 38000, 1, 'Galena Grey', 2350000, 'Hyderabad - Gachibowli', 'Premium lifestyle commercial adventure pickup.', 'AVAILABLE', 'TS-09-YZ-0707', 'EXT-ISU-001', 'https://marketplace.autodealer.com/inventory/isuzu-dmax-2021', 'FLATBED', 1100, 4, 'DIRECT_INVENTORY', NOW(), NOW()),
('a0000001-0000-0000-0000-000000000053', 'Mahindra', 'Bolero Maxi Truck Plus', 'PS 1.2T Diesel', 'COMMERCIAL', 'Pickup', 2022, 2022, 'DIESEL', 'MANUAL', 51000, 1, 'White', 620000, 'Bangalore - Electronic City', 'Power steering 1.2T pickup truck.', 'AVAILABLE', 'KA-51-AB-1818', 'EXT-MAH-009', 'https://marketplace.autodealer.com/inventory/mahindra-bolero-maxi-truck-2022', 'OPEN_CONTAINER', 1200, 4, 'DIRECT_INVENTORY', NOW(), NOW())
ON CONFLICT ("id") DO NOTHING;

-- Primary images for vehicles
INSERT INTO "VehicleImage" ("id", "vehicleId", "url", "isPrimary", "caption", "sortOrder", "createdAt")
SELECT 
  gen_random_uuid(),
  v."id",
  'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?w=800',
  true,
  v."make" || ' ' || v."model" || ' Front Angle',
  0,
  NOW()
FROM "Vehicle" v
ON CONFLICT ("id") DO NOTHING;


-- ============================================================================
-- 2. INSERT 105 CUSTOMERS & REQUIREMENTS WITH REALISTIC STAGES & CRITERIA
-- ============================================================================

DO $$
DECLARE
  v_cust_id UUID;
  v_req_id UUID;
  v_staff_id UUID;
  v_first_names TEXT[] := ARRAY['Ramesh', 'Suresh', 'Kavita', 'Ananya', 'Deepak', 'Vikram', 'Pooja', 'Sunil', 'Manish', 'Neha', 'Arun', 'Sneha', 'Manoj', 'Rohit', 'Ankit', 'Gaurav', 'Divya', 'Sanjay', 'Alok', 'Meera', 'Kiran', 'Prashant', 'Swati', 'Harish', 'Ashok', 'Vinay', 'Naveen', 'Ritu', 'Tarun', 'Siddharth', 'Chetan', 'Varun', 'Shweta', 'Nikhil', 'Pankaj', 'Abhishek', 'Monika', 'Lalit', 'Raghav', 'Shruti', 'Ajay', 'Vikas', 'Rashmi', 'Sachin', 'Karthik', 'Bhavna', 'Girish', 'Kamal', 'Preeti', 'Mahesh'];
  v_last_names TEXT[] := ARRAY['Sharma', 'Verma', 'Patel', 'Reddy', 'Rao', 'Singh', 'Gupta', 'Iyer', 'Menon', 'Joshi', 'Deshmukh', 'Kulkarni', 'Bhat', 'Shetty', 'Hegde', 'Nair', 'Agarwal', 'Chopra', 'Malhotra', 'Kapoor', 'Yadav', 'Pandey', 'Mishra', 'Choudhary', 'Dubey', 'Gowda', 'Naidu', 'Murthy', 'Pillai', 'Saxena'];
  v_cities TEXT[] := ARRAY['Bangalore', 'Mumbai', 'Delhi', 'Hyderabad', 'Chennai', 'Pune'];
  v_statuses TEXT[] := ARRAY['NEW', 'CONTACTED', 'REQUIREMENT_CONFIRMED', 'VEHICLE_SEARCHING', 'VEHICLE_MATCHED', 'VEHICLE_SHARED', 'INTERESTED', 'VISIT_SCHEDULED', 'TEST_DRIVE', 'NEGOTIATION', 'BOOKING', 'WON', 'LOST'];
  
  v_brands TEXT[] := ARRAY['Toyota', 'Mahindra', 'Tata', 'Hyundai', 'Maruti Suzuki', 'Kia', 'Honda', 'Ashok Leyland'];
  v_models TEXT[] := ARRAY['Innova Crysta', 'Fortuner', 'Thar', 'XUV700', 'Scorpio-N', 'Nexon', 'Harrier', 'Ace Gold', 'Creta', 'Swift', 'Brezza', 'Ertiga', 'Seltos', 'City', 'Dost Plus'];
  v_min_budgets INT[] := ARRAY[1500000, 3000000, 1200000, 1700000, 1800000, 900000, 1600000, 350000, 1200000, 550000, 950000, 900000, 1300000, 1000000, 500000];
  v_max_budgets INT[] := ARRAY[2200000, 4200000, 1700000, 2600000, 2500000, 1450000, 2200000, 550000, 1850000, 800000, 1350000, 1250000, 2000000, 1500000, 750000];
  v_fuels TEXT[] := ARRAY['DIESEL', 'DIESEL', 'DIESEL', 'DIESEL', 'DIESEL', 'DIESEL', 'DIESEL', 'DIESEL', 'DIESEL', 'PETROL', 'PETROL', 'CNG', 'PETROL', 'PETROL', 'DIESEL'];
  v_cats TEXT[] := ARRAY['PASSENGER', 'PASSENGER', 'PASSENGER', 'PASSENGER', 'PASSENGER', 'PASSENGER', 'PASSENGER', 'COMMERCIAL', 'PASSENGER', 'PASSENGER', 'PASSENGER', 'PASSENGER', 'PASSENGER', 'PASSENGER', 'COMMERCIAL'];

  v_fn TEXT;
  v_ln TEXT;
  v_full_name TEXT;
  v_mobile TEXT;
  v_city TEXT;
  v_status TEXT;
  v_idx INT;
  v_t_idx INT;
BEGIN
  -- Assign to staff
  SELECT "id" INTO v_staff_id FROM "User" WHERE "role" = 'SALES_EXECUTIVE' LIMIT 1;
  IF v_staff_id IS NULL THEN
    SELECT "id" INTO v_staff_id FROM "User" LIMIT 1;
  END IF;

  FOR v_idx IN 1..105 LOOP
    v_fn := v_first_names[((v_idx - 1) % array_length(v_first_names, 1)) + 1];
    v_ln := v_last_names[(((v_idx - 1) * 3) % array_length(v_last_names, 1)) + 1];
    v_full_name := v_fn || ' ' || v_ln;
    v_mobile := '98' || LPAD(((10000000 + v_idx * 7919) % 89999999 + 10000000)::TEXT, 8, '0');
    v_city := v_cities[((v_idx - 1) % array_length(v_cities, 1)) + 1];
    v_status := v_statuses[((v_idx - 1) % array_length(v_statuses, 1)) + 1];
    v_t_idx := ((v_idx - 1) % array_length(v_models, 1)) + 1;

    v_cust_id := gen_random_uuid();
    v_req_id := gen_random_uuid();

    -- Insert Customer
    INSERT INTO "Customer" (
      "id", "fullName", "primaryMobile", "email", "location", "city", "state", 
      "preferredContact", "customerType", "source", "createdById", "createdAt", "updatedAt"
    ) VALUES (
      v_cust_id,
      v_full_name,
      v_mobile,
      LOWER(v_fn) || '.' || LOWER(v_ln) || v_idx || '@example.com',
      v_city || ' Central',
      v_city,
      CASE WHEN v_city = 'Bangalore' THEN 'Karnataka' WHEN v_city IN ('Mumbai', 'Pune') THEN 'Maharashtra' WHEN v_city = 'Delhi' THEN 'Delhi' WHEN v_city = 'Hyderabad' THEN 'Telangana' ELSE 'Tamil Nadu' END,
      'WHATSAPP',
      CASE WHEN v_cats[v_t_idx] = 'COMMERCIAL' THEN 'BUSINESS' ELSE 'INDIVIDUAL' END,
      'WALK_IN',
      v_staff_id,
      NOW() - (v_idx || ' days')::INTERVAL,
      NOW()
    ) ON CONFLICT ("primaryMobile") DO NOTHING;

    -- Insert Customer Requirement
    INSERT INTO "CustomerRequirement" (
      "id", "customerId", "category", "status", "priority", "source", "assignedToId",
      "brand", "model", "minBudget", "maxBudget", "minYear", "fuelType", "maxKm",
      "generalNotes", "lostReason", "wonDealAmount", "closedAt", "createdAt", "updatedAt"
    ) VALUES (
      v_req_id,
      v_cust_id,
      v_cats[v_t_idx],
      v_status,
      CASE WHEN v_idx % 4 = 0 THEN 'URGENT' WHEN v_idx % 3 = 0 THEN 'HIGH' ELSE 'MEDIUM' END,
      'WALK_IN',
      v_staff_id,
      v_brands[v_t_idx],
      v_models[v_t_idx],
      v_min_budgets[v_t_idx],
      v_max_budgets[v_t_idx],
      2020,
      v_fuels[v_t_idx],
      60000,
      'Customer looking for clean condition ' || v_brands[v_t_idx] || ' ' || v_models[v_t_idx] || ' with complete service records.',
      CASE WHEN v_status = 'LOST' THEN 'Price too high' ELSE NULL END,
      CASE WHEN v_status = 'WON' THEN (v_min_budgets[v_t_idx] + 50000) ELSE NULL END,
      CASE WHEN v_status IN ('WON', 'LOST') THEN NOW() ELSE NULL END,
      NOW() - (v_idx || ' days')::INTERVAL,
      NOW()
    );

    -- Insert Follow-Up for active leads
    IF v_status NOT IN ('WON', 'LOST') THEN
      INSERT INTO "FollowUp" (
        "id", "requirementId", "assignedToId", "followUpDate", "followUpType", 
        "status", "notes", "createdAt", "updatedAt"
      ) VALUES (
        gen_random_uuid(),
        v_req_id,
        v_staff_id,
        NOW() + (((v_idx % 7) - 2) || ' days')::INTERVAL,
        CASE WHEN v_idx % 4 = 0 THEN 'TEST_DRIVE' WHEN v_idx % 3 = 0 THEN 'VISIT' ELSE 'CALL' END,
        CASE WHEN (v_idx % 7) < 2 AND v_idx % 3 = 0 THEN 'COMPLETED' ELSE 'PENDING' END,
        'Follow-up with ' || v_full_name || ' regarding ' || v_brands[v_t_idx] || ' ' || v_models[v_t_idx] || ' requirement.',
        NOW(),
        NOW()
      );
    END IF;

  END LOOP;
END $$;


-- ============================================================================
-- 3. GENERATE EXTENSIVE LIVE MATCHES BETWEEN INVENTORY & BUYER REQUIREMENTS
-- ============================================================================

INSERT INTO "VehicleMatch" ("id", "requirementId", "vehicleId", "matchScore", "matchReasons", "createdAt", "updatedAt")
SELECT 
  gen_random_uuid(),
  r."id",
  v."id",
  ROUND(
    (
      -- Make match (up to 30 pts)
      (CASE 
        WHEN LOWER(v."make") = LOWER(r."brand") THEN 30
        WHEN LOWER(v."make") LIKE '%' || LOWER(r."brand") || '%' OR LOWER(r."brand") LIKE '%' || LOWER(v."make") || '%' THEN 25
        ELSE 0 
      END) +
      -- Model match (up to 35 pts)
      (CASE 
        WHEN LOWER(v."model") = LOWER(r."model") THEN 35
        WHEN LOWER(v."model") LIKE '%' || LOWER(r."model") || '%' OR LOWER(r."model") LIKE '%' || LOWER(v."model") || '%' THEN 28
        ELSE 10 
      END) +
      -- Budget match (up to 25 pts)
      (CASE 
        WHEN v."price" BETWEEN COALESCE(r."minBudget", 0) AND COALESCE(r."maxBudget", 99999999) THEN 25
        WHEN v."price" BETWEEN COALESCE(r."minBudget", 0) * 0.90 AND COALESCE(r."maxBudget", 99999999) * 1.10 THEN 20
        ELSE 5 
      END) +
      -- Fuel match (10 pts)
      (CASE 
        WHEN v."fuelType" = r."fuelType" THEN 10
        ELSE 5 
      END)
    )::NUMERIC, 
    0
  ) AS score,
  json_build_array(
    json_build_object(
      'factor', 'Brand & Make', 
      'status', CASE WHEN LOWER(v."make") = LOWER(r."brand") THEN 'MATCH' WHEN LOWER(v."make") LIKE '%' || LOWER(r."brand") || '%' THEN 'MATCH' ELSE 'MISMATCH' END, 
      'detail', CASE WHEN LOWER(v."make") = LOWER(r."brand") THEN 'Make matches preference' WHEN LOWER(v."make") LIKE '%' || LOWER(r."brand") || '%' THEN 'Make alias matches' ELSE 'Make differs (' || v."make" || ' vs ' || r."brand" || ')' END,
      'scoreContribution', CASE WHEN LOWER(v."make") = LOWER(r."brand") THEN 25 ELSE 0 END
    ),
    json_build_object(
      'factor', 'Model', 
      'status', CASE WHEN LOWER(v."model") = LOWER(r."model") THEN 'STRONG_MATCH' WHEN LOWER(v."model") LIKE '%' || LOWER(r."model") || '%' THEN 'MATCH' ELSE 'MISMATCH' END, 
      'detail', CASE WHEN LOWER(v."model") = LOWER(r."model") THEN 'Exact model match' WHEN LOWER(v."model") LIKE '%' || LOWER(r."model") || '%' THEN 'Model variant matches' ELSE 'Model differs (' || v."model" || ' vs ' || r."model" || ')' END,
      'scoreContribution', CASE WHEN LOWER(v."model") = LOWER(r."model") THEN 25 ELSE 0 END
    ),
    json_build_object(
      'factor', 'Budget Window', 
      'status', CASE 
        WHEN v."price" BETWEEN COALESCE(r."minBudget", 0) AND COALESCE(r."maxBudget", 99999999) THEN 'STRONG_MATCH' 
        WHEN v."price" BETWEEN COALESCE(r."minBudget", 0) * 0.90 AND COALESCE(r."maxBudget", 99999999) * 1.10 THEN 'PARTIAL' 
        ELSE 'MISMATCH' 
      END, 
      'detail', CASE 
        WHEN v."price" BETWEEN COALESCE(r."minBudget", 0) AND COALESCE(r."maxBudget", 99999999) THEN 'Price is strictly within budget window' 
        WHEN v."price" BETWEEN COALESCE(r."minBudget", 0) * 0.90 AND COALESCE(r."maxBudget", 99999999) * 1.10 THEN 'Price is near budget (within 10% tolerance)' 
        ELSE 'Price ₹' || ROUND(v."price"/100000.0, 1) || 'L is outside requested budget' 
      END,
      'scoreContribution', CASE WHEN v."price" BETWEEN COALESCE(r."minBudget", 0) AND COALESCE(r."maxBudget", 99999999) THEN 20 WHEN v."price" BETWEEN COALESCE(r."minBudget", 0) * 0.90 AND COALESCE(r."maxBudget", 99999999) * 1.10 THEN 16 ELSE 0 END
    ),
    json_build_object(
      'factor', 'Fuel Type', 
      'status', CASE WHEN v."fuelType" = r."fuelType" THEN 'MATCH' ELSE 'MISMATCH' END, 
      'detail', CASE WHEN v."fuelType" = r."fuelType" THEN 'Fuel matches (' || v."fuelType" || ')' ELSE 'Fuel differs (' || v."fuelType" || ' vs ' || r."fuelType" || ')' END,
      'scoreContribution', CASE WHEN v."fuelType" = r."fuelType" THEN 10 ELSE 0 END
    ),
    json_build_object(
      'factor', 'Manufacturing Year', 
      'status', CASE WHEN v."manufacturingYear" >= COALESCE(r."minYear", 1990) THEN 'MATCH' ELSE 'MISMATCH' END, 
      'detail', CASE WHEN v."manufacturingYear" >= COALESCE(r."minYear", 1990) THEN 'Year ' || v."manufacturingYear" || ' meets age criteria' ELSE 'Year ' || v."manufacturingYear" || ' older than requested' END,
      'scoreContribution', CASE WHEN v."manufacturingYear" >= COALESCE(r."minYear", 1990) THEN 10 ELSE 0 END
    )
  )::TEXT AS reasons,
  NOW(),
  NOW()
FROM "CustomerRequirement" r
JOIN "Vehicle" v ON v."category" = r."category" AND v."status" = 'AVAILABLE'
WHERE (
    LOWER(v."make") = LOWER(r."brand") 
    OR LOWER(v."model") = LOWER(r."model")
    OR (v."price" BETWEEN COALESCE(r."minBudget", 0) * 0.85 AND COALESCE(r."maxBudget", 99999999) * 1.15)
  )
  AND r."status" NOT IN ('WON', 'LOST')
ON CONFLICT ("requirementId", "vehicleId") DO NOTHING;

