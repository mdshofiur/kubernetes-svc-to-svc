"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const dotenv_1 = __importDefault(require("dotenv"));
const user_route_1 = __importDefault(require("./modules/user/user.route"));
const os_1 = __importDefault(require("os"));
const axios_1 = __importDefault(require("axios"));
dotenv_1.default.config();
const app = (0, express_1.default)();
const port = process.env.PORT || 80;
app.use(express_1.default.json());
app.use(user_route_1.default);
app.get('/', (req, res) => {
    const headers = req.headers;
    const hostName = os_1.default.hostname();
    res.json({ hostName, headers });
});
app.post('/api/hello', (req, res) => {
    const body = req.body;
    console.log("🚀 service-1 body", body);
    res.json(body);
});
app.post('/api/svc', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const body = req.body;
    try {
        const response = yield axios_1.default.post('http://backend-sv2-svc.devops.svc.cluster.local/api/hello', body);
        console.log('response from service-1', response.data);
        res.status(200).json({ success: true, response: response.data });
    }
    catch (error) {
        console.error('Error sending POST request:', error.message);
        res.status(500).json({ success: false, error: error.message });
    }
}));
app.listen(port, () => {
    console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
