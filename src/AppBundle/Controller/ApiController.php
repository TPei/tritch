<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class ApiController extends Controller
{
    /**
     * @Route("/api", name="apimain")
     */
    public function indexAction(Request $request)
    {
        $json = $this->getTwitchData($this->url(), $this->params());
        $channels = $this->parseTwitchData($json);

        return new JsonResponse(array('channels' => $channels));
    }

    private function getTwitchData($url, $params) {

        $jsonurl = $url["baseUrl"]. $url["apiRoute"] . "?";

        foreach($params as $key => $value) {
            $jsonurl .= $key . "=" . $value;
        }

        $json = file_get_contents($jsonurl);

        return json_decode($json);
    }

    private function parseTwitchData($json) {
        $channels = [];
        foreach($json->top as $channel) {
            array_push($channels, array(
                "id" => $channel->game->_id,
                "name" => $channel->game->name,
                "viewers" => $channel->viewers
            ));
        }

        return $channels;
    }

    private function url() {
        $url = array (
            "baseUrl" => "https://api.twitch.tv/kraken/",
            "apiRoute" => "games/top"
        );

        return $url;
    }

    private function params() {
        $params = array (
            "limit" => "20",
            "client-id" => "not_the_actual_client_id"
        );

        return $params;
    }
}
